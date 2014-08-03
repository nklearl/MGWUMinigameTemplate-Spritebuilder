//
//  MyBomb.m
//  MGWUMinigameTemplate
//
//  Created by Kinlam Ng on 8/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "MyBomb.h"

@implementation MyBomb

-(id)init{
    self = [super initWithImageNamed:@"items/item_bomb_1.png"];
    if (self) {
        self.physicsBody.density = 1;
        self.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:15 andCenter:self.anchorPointInPoints];
        self.physicsBody.collisionCategories = @[@"bomb"];
        self.physicsBody.collisionMask = @[];
        self.physicsBody.collisionType = @"bomb";
        self.physicsBody.allowsRotation = NO;
        self.name = @"bomb";
    }
    return self;
}

-(void)onEnter{
    [super onEnter];

    
}

@end
