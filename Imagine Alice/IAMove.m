//
//  IAMove.m
//  Imagine Alice
//
//  Created by Sergey Dunets on 8/12/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IAMove.h"

@implementation IAMove

@synthesize deltaX = _deltaX;
@synthesize deltaY = _deltaY;
@synthesize moveDescription = _moveDescription;

+ (IAMove *)moveByAbsoluteDeltaX:(double)deltaX deltaY:(double)deltaY moveDescription:(NSString *)moveDescription
{
    IAMove *move = [[[IAMove alloc] init] autorelease];
    move.deltaX = deltaX;
    move.deltaY = deltaY;
    move.moveDescription = moveDescription;
    return move;
}

@end
