//
//  IAGameObject.m
//  ImagineAlice-iPhone
//
//  Created by Sergey Dunets on 7/29/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IAGameObject.h"

static NSString * const kDefaultObjectName = @"Default Name";

@implementation IAGameObject

@synthesize name = _name;
@synthesize position = _position;

- (id)initWithName:(NSString *)name position:(IAAbsolutePosition *)position
{
    if (self = [super init])
    {
        if (name) 
            _name = [[NSMutableString alloc] initWithString:name];
        else 
            _name = [[NSMutableString alloc] initWithString:kDefaultObjectName];
        
        // If the absolute position is nil, we will automatically set _position to (0.0, 0.0)
        _position = [[IAAbsolutePosition alloc] initWithAbsolutePosition:position];
    }
    return self;
}

- (id)init
{
    return [self initWithName:nil position:nil];
}

- (void)dealloc
{
    [_position release];
    [_name release];
    [super dealloc];
}

@end
