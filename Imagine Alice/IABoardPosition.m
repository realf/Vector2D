//
//  IABoardPosition.m
//  Imagine Alice
//
//  Created by Sergey Dunets on 9/16/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IABoardPosition.h"

@implementation IABoardPosition

@synthesize x = _x;
@synthesize y = _y;

+ (IABoardPosition *)boardPositionWithX:(NSInteger)x y:(NSInteger)y
{
    IABoardPosition *position = [[[IABoardPosition alloc] init] autorelease];
    position.x = x;
    position.y = y;
    return position;
}

// The designated initializer
- (id)initWithBoardPosition:(IABoardPosition *)position
{
    if (self = [super init])
    {
        _x = position.x;
        _y = position.y;
    }
    return self;
}

@end
