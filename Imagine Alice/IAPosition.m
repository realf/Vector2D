//
//  IAPosition.m
//  Imagine Alice
//
//  Created by Sergey Dunets on 8/12/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IAPosition.h"

@implementation IAPosition

@synthesize x = _x;
@synthesize y = _y;

+ (IAPosition *)newPositionWithX:(NSInteger)x y:(NSInteger)y
{
    IAPosition *position = [[IAPosition alloc] init];
    position.x = x;
    position.y = y;
    return position;
}

@end
