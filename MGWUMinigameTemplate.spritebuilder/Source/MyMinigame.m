//
//  MGWUMinigameTemplate
//
//  Created by Zachary Barryte on 6/6/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "MyMinigame.h"
#import "MyCoin.h"
#import "MyBomb.h"
#import "MyGameEnd.h"

@implementation MyMinigame {
    CCPhysicsNode *_physicsNode;
    NSTimer *timer;
    CCLabelTTF *_timeLabel;
    CCLabelTTF *_blueCoin;
    CCLabelTTF *_greenCoin;
    CCLabelTTF *_pinkCoin;
    CCLabelTTF *_redCoin;
    CCLabelTTF *_tealCoin;
    CCLabelTTF *_lives;
    int time;
    int blueCoin;
    int greenCoin;
    int pinkCoin;
    int redCoin;
    int tealCoin;
    int randomSpot;
    int randomBomb;
    int lives;
    BOOL gameover;
    MyGameEnd *summary;
}

-(id)init {
    if ((self = [super init])) {
        // Initialize any arrays, dictionaries, etc in here
        self.instructions = @"[Goal]: Collect specified coins as many as posible.\n"
                            "\n[Rules]: You have 1 minute to collect coins. This game will end"
                            "\nwhen the time runs out or your character loses all 3 lives.\n"
                            "\n[Movement Controls]: Tap left or right side of the character.";
        time = 60;
        lives = 3;
        gameover = NO;
    }
    return self;
}

-(void)tick{
    if (time>0 && gameover==NO) {
        time--;
        _timeLabel.string = [NSString stringWithFormat:@"Time Left: %is",time];
        //CCLOG(@"%f",_physicsNode.contentSizeInPoints.width);
        int screenSize = _physicsNode.contentSizeInPoints.width;
        randomSpot = arc4random() % screenSize;
        if (randomSpot<35) {
            randomSpot+=35;
        } else if (randomSpot>_physicsNode.contentSizeInPoints.width-35){
            randomSpot-=35;
        }
        //CCLOG(@"%i",randomSpot);
        MyCoin * coin = [[MyCoin alloc]init];
        coin.position = ccp(randomSpot, 300);
        [_physicsNode addChild:coin];
        coin.physicsBody.collisionType = @"coin";
        
        randomBomb = arc4random() % 3;
        if (randomBomb==0) {
            MyBomb * bomb = [[MyBomb alloc]init];
            randomSpot = arc4random() % screenSize;
            if (randomSpot<50) {
                randomSpot+=50;
            } else if (randomSpot>_physicsNode.contentSizeInPoints.width-50){
                randomSpot-=50;
            }
            bomb.position = ccp(randomSpot, 300);
            bomb.physicsBody.collisionMask = @[];
            [_physicsNode addChild:bomb];
        }
    } else {
        gameover = YES;
        [self endGameWithMessage];
        [self performSelectorOnMainThread:@selector(stopTimer) withObject:nil waitUntilDone:YES];
    }
}

- (void) stopTimer
{
    [timer invalidate];
    timer = nil;
}

-(void)didLoadFromCCB {
    // Set up anything connected to Sprite Builder here
    //_physicsNode.collisionDelegate = self;
    // We're calling a public method of the character that tells it to jump!
    //[self.hero jump];
    _physicsNode.collisionDelegate = self;
}

-(void)onEnter {
    [super onEnter];
    // Create anything you'd like to draw here
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    // accept touches
    self.userInteractionEnabled = YES;
}

-(void)update:(CCTime)delta {
    // Called each update cycle
    // n.b. Lag and other factors may cause it to be called more or less frequently on different devices or sessions
    // delta will tell you how much time has passed since the last cycle (in seconds)
    for (CCNode * node in _physicsNode.children) {
        if (node.position.y<=150 && [node.name  isEqual: @"bomb"]) {
            node.physicsBody.collisionMask = @[@"floor", @"hero"];
        }
    }
}

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    //get the x,y coordinates of the touch
    if (gameover == NO) {
        CGPoint touchLocation = [touch locationInNode:self];
        [self.hero moveCharacter:touchLocation.x];
    }
}

-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair coin:(CCNode *)nodeA wildcard:(CCNode *)nodeB
{
    if ([nodeB.physicsBody.collisionType  isEqual: @"floor"]){
        //CCLOG(@"node B is floor");
        [_physicsNode removeChild:nodeA];
    } else if ([nodeB.physicsBody.collisionType  isEqual: @"hero"]){
        //CCLOG(@"node B is hero");
        MyCoin *currentCoin = (MyCoin*)nodeA;
        //CCLOG(@"%i", currentCoin.coinType);
        switch (currentCoin.coinType) {
            case 0:
                blueCoin++;
                _blueCoin.string = [NSString stringWithFormat:@"x%i", blueCoin];
                break;
            case 1:
                greenCoin++;
                _greenCoin.string = [NSString stringWithFormat:@"x%i", greenCoin];
                break;
            case 2:
                pinkCoin++;
                _pinkCoin.string = [NSString stringWithFormat:@"x%i", pinkCoin];
                break;
            case 3:
                redCoin++;
                _redCoin.string = [NSString stringWithFormat:@"x%i", redCoin];
                break;
            case 4:
                tealCoin++;
                _tealCoin.string = [NSString stringWithFormat:@"x%i", tealCoin];
                break;
                
            default:
                break;
        }
        [_physicsNode removeChild:nodeA];
    }
}

-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair bomb:(CCNode *)nodeA wildcard:(CCNode *)nodeB{
    if ([nodeB.physicsBody.collisionType  isEqual: @"floor"]){
        [_physicsNode removeChild:nodeA];
    } else if ([nodeB.physicsBody.collisionType  isEqual: @"hero"]){
        if (lives>1) {
            lives--;
        }else{
            lives = 0;
            gameover = YES;
            [self endGameWithMessage];
            [self performSelectorOnMainThread:@selector(stopTimer) withObject:nil waitUntilDone:YES];
        }
        
        _lives.string = [NSString stringWithFormat:@"Lives: %i", lives];
        [_physicsNode removeChild:nodeA];
    }
}

- (void)endGameWithMessage {
    [_physicsNode removeChildByName:@"hero"];
    summary = (MyGameEnd*)[CCBReader load:@"MyGameEnd"];
    
    int CoinsArray[5] = {blueCoin, greenCoin, pinkCoin, redCoin, tealCoin};
    int totalCoins = 0;
    int lowestNum = 20;
    
    for (int i=0; i < 5; i++) {
        if (CoinsArray[i]<lowestNum) {
            lowestNum = CoinsArray[i];
        }
        totalCoins = totalCoins + CoinsArray[i];
    }
    
    [summary setMessage:totalCoins Sets:lowestNum RemainLives:lives];
    [self addChild:summary];
    summary.positionType = CCPositionTypeNormalized;
}

-(void)endMinigame {
    // Be sure you call this method when you end your minigame!
    // Of course you won't have a random score, but your score *must* be between 1 and 100 inclusive
    //[self endMinigameWithScore:arc4random()%100 + 1];
    //[self endMinigameWithScore:summary.finalPoints];
    //CCLOG(@"returns %i", summary.finalPoints);
}

// DO NOT DELETE!
-(MyCharacter *)hero {
    return (MyCharacter *)self.character;
}
// DO NOT DELETE!

@end
