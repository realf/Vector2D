//
//  IATorpedo.m
//  Imagine Alice
//
//  Created by Sergey Dunets on 8/29/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IATorpedo.h"

@implementation IATorpedo

@synthesize speed = _speed;

- (id)initWitName:(NSString *)name position:(Vector2D *)position speed:(NSNumber *)speed
{
    if (self = [super initWithName:name absolutePosition:position availableMoves:@[]])
    {
        _speed = speed;
    }
    return self;
}

- (void)dealloc
{
    [_speed release];
    [super dealloc];
}

@end
