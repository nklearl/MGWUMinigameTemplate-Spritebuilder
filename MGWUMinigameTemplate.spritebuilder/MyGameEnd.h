//
//  MyGameEnd.h
//  MGWUMinigameTemplate
//
//  Created by Kinlam Ng on 8/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "MyMinigame.h"

@interface MyGameEnd : CCNode

@property (nonatomic, assign) int finalPoints;

-(void) setMessage:(int) coins Sets:(int) sets RemainLives:(int) lives;

@end
