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
@synthesize isEnabled = _isEnabled;

- (id)initWithName:(NSString *)name position:(IAPosition *)position
{
    if (self = [super init])
    {
        if (name) 
            _name = [[NSMutableString alloc] initWithString:name];
        else 
            _name = [[NSMutableString alloc] initWithString:kDefaultObjectName];
        
        // If position is nil, we will automatically set _position to (0, 0)
        _position = [[IAPosition alloc] initWithPosition:position];
        _isEnabled = YES;
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
