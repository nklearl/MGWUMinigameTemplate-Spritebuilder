//
//  MyCoin.m
//  MGWUMinigameTemplate
//
//  Created by Kinlam Ng on 7/27/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "MyCoin.h"

@implementation MyCoin {
    NSArray *items;
}

-(id)init{
    items = @[@"characters/blue_symbol.png",
              @"characters/green_symbol.png",
              @"characters/pink_symbol.png",
              @"characters/red_symbol.png",
              @"characters/teal_symbol.png"];
    
    _coinType = arc4random() % 5;
    
    self = [super initWithImageNamed:[items objectAtIndex:_coinType]];

    if (self) {
        self.scaleX = 0.25;
        self.scaleY = 0.25;
        self.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:63.5 andCenter:self.anchorPointInPoints];
        self.physicsBody.density = 1;
        //CCLOG(@"coin created");
    }
    return self;
}

@end
