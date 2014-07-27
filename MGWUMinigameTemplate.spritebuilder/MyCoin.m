//
//  MyCoin.m
//  MGWUMinigameTemplate
//
//  Created by K on 7/27/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "MyCoin.h"

@implementation MyCoin {
    
}

-(id)init {
    if ((self = [super init])) {
        self.scaleX = 0.3;
        self.scaleY = 0.3;
        self.position = ccp(100, 100);
    }
    return self;
}

-(void)didLoadFromCCB {
    // Set up anything connected to Sprite Builder here
}

-(void)onEnter {
    [super onEnter];
    // Create anything you'd like to draw here
}

@end
