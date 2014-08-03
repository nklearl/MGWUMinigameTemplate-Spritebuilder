//
//  MyGameEnd.m
//  MGWUMinigameTemplate
//
//  Created by Kinlam Ng on 8/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "MyGameEnd.h"

@implementation MyGameEnd{
    CCLabelTTF *_totalCoins;
    CCLabelTTF *_totalSetBonus;
    CCLabelTTF *_totalDeduction;
    CCLabelTTF *_totalPoints;
}

-(void) setMessage:(int) coins Sets:(int) sets RemainLives:(int) lives{
    _totalCoins.string = [NSString stringWithFormat:@"+ %i", coins];
    sets = sets*15;
    _totalSetBonus.string = [NSString stringWithFormat:@"+ %i", sets];
    lives = (30 - lives*10);
    _totalDeduction.string = [NSString stringWithFormat:@"- %i", lives];
    _finalPoints = coins + sets - lives;
    if (_finalPoints > 100) {
        _finalPoints = 100;
    } else if (_finalPoints<0){
        _finalPoints = 0;
    }
    _totalPoints.string = [NSString stringWithFormat:@"%i", _finalPoints];
}

-(void)endMinigame {
    MyMinigame *minigame = [[MyMinigame alloc]init];
    [minigame endMinigameWithScore:self.finalPoints];
    CCLOG(@"Total Point: %i", self.finalPoints);
}

@end
