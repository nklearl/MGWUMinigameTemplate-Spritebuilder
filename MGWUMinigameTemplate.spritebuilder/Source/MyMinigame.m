//
//  MGWUMinigameTemplate
//
//  Created by Zachary Barryte on 6/6/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "MyMinigame.h"
#import "MyCoin.h"

@implementation MyMinigame {
    MyCoin *coin;
}

-(id)init {
    if ((self = [super init])) {
        // Initialize any arrays, dictionaries, etc in here
        self.instructions = @"Goal: Collect specified items as many as posible"
                            "\nMovement Control: Tap left or right side of the screen";
    }
    return self;
}

-(void)didLoadFromCCB {
    // Set up anything connected to Sprite Builder here
    
    // We're calling a public method of the character that tells it to jump!
    [self.hero jump];
    coin = [[MyCoin alloc]init];
}

-(void)onEnter {
    [super onEnter];
    // Create anything you'd like to draw here
    
    // accept touches
    self.userInteractionEnabled = YES;
}

-(void)update:(CCTime)delta {
    // Called each update cycle
    // n.b. Lag and other factors may cause it to be called more or less frequently on different devices or sessions
    // delta will tell you how much time has passed since the last cycle (in seconds)
}

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    //get the x,y coordinates of the touch
    CGPoint touchLocation = [touch locationInNode:self];
    [self moveCharacter:touchLocation.x];
}

-(void) moveCharacter:(int)xVal{
    //int halfScreenSize = self.contentSize.width;
    int halfScreenSize = [UIScreen mainScreen].bounds.size.height/2;
    
    //CCLOG(@"half of screen size = %i", halfScreenSize);
    if (xVal<halfScreenSize) {
        //CCLOG(@"move left%i", xVal);
        //[self.hero.animationManager runAnimationsForSequenceNamed:@"AnimSideWalking"];
        [self.hero moveLeft];
    } else if (xVal>halfScreenSize){
        //CCLOG(@"move right%i", xVal);
        //[self.hero.animationManager runAnimationsForSequenceNamed:@"AnimSideWalking"];
        [self.hero moveRight];
    }
    
}

-(void)endMinigame {
    // Be sure you call this method when you end your minigame!
    // Of course you won't have a random score, but your score *must* be between 1 and 100 inclusive
    [self endMinigameWithScore:arc4random()%100 + 1];
}

// DO NOT DELETE!
-(MyCharacter *)hero {
    return (MyCharacter *)self.character;
}
// DO NOT DELETE!

@end
