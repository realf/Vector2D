//
//  IAAbsolutePosition.m
//  Imagine Alice
//
//  Created by Sergey Dunets on 8/12/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IAAbsolutePosition.h"

@implementation IAAbsolutePosition

@synthesize x = _x;
@synthesize y = _y;

+ (IAAbsolutePosition *)newAbsolutePositionWithX:(double)x y:(double)y
{
    IAAbsolutePosition *position = [[IAAbsolutePosition alloc] init];
    position.x = x;
    position.y = y;
    return position;
}


// The disignated initializer
- (id)initWithAbsolutePosition:(IAAbsolutePosition *)position
{
    if (self = [super init])
    {
        _x = position.x;
        _y = position.y;
    }
    return self;
}

- (id)init
{
    return([self initWithAbsolutePosition:[[self class] newAbsolutePositionWithX:0.0 y:0.0]]);
}

- (BOOL)isEqual:(id)object
{
    float delta = 1e-6;
    return ([object isMemberOfClass:[self class]] && fabs([(IAAbsolutePosition *)object x] - self.x) < delta && fabs([(IAAbsolutePosition *)object y] - self.y) < delta);
}

@end
