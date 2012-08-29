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

+ (IAPosition *)newPositionWithX:(float)x y:(float)y
{
    IAPosition *position = [[IAPosition alloc] init];
    position.x = x;
    position.y = y;
    return position;
}

- (id)initWithPosition:(IAPosition *)position
{
    if (self = [super init])
    {
        _x = position.x;
        _y = position.y;
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    float delta = 1e-6;
    return ([object isMemberOfClass:[self class]] && fabs([(IAPosition *)object x] - self.x) < delta && fabs([(IAPosition *)object y] - self.y) < delta);
}

@end
