//
//  IAAbsolutePosition.m
//  Imagine Alice
//
//  Created by Sergey Dunets on 8/12/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IAAbsolutePosition.h"
#import "IAGlobalConstants.h"

@implementation IAAbsolutePosition

@synthesize x = _x;
@synthesize y = _y;

+ (IAAbsolutePosition *)absolutePositionWithX:(double)x y:(double)y
{
    IAAbsolutePosition *position = [[[IAAbsolutePosition alloc] init] autorelease];
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

- (BOOL)isEqual:(id)object
{
    return ([object isMemberOfClass:[self class]] && fabs([(IAAbsolutePosition *)object x] - self.x) < EPSILON && fabs([(IAAbsolutePosition *)object y] - self.y) < EPSILON);
}

@end
