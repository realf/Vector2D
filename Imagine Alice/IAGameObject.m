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
@synthesize absolutePosition = _absolutePosition;
@synthesize availableMoves = _availableMoves;
@synthesize historyOfPositions = _historyOfPositions;

- (id)initWithName:(NSString *)name absolutePosition:(Vector2D *)position
    availableMoves:(NSArray *)moves
{
    if (self = [super init])
    {
        if (name) 
            _name = [[NSMutableString alloc] initWithString:name];
        else 
            _name = [[NSMutableString alloc] initWithString:kDefaultObjectName];
        _absolutePosition = [position copy];
        _availableMoves = [moves copy];
        _historyOfPositions = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)init
{
    return [self initWithName:nil absolutePosition:[Vector2D zero] availableMoves:[NSArray array]];
}

- (void)dealloc
{
    [_historyOfPositions release];
    [_availableMoves release];
    [_absolutePosition release];
    [_name release];
    [super dealloc];
}

- (IAGameObject *)copyWithZone:(NSZone *)zone
{
    IAGameObject *object = [[IAGameObject alloc] initWithName:[self name] absolutePosition:[self absolutePosition] availableMoves:[self availableMoves]];
    return object;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@: %@", self.name, self.absolutePosition.description];
}

- (void)savePositionToHistory
{
    [self.historyOfPositions addObject:[self.absolutePosition copy]];
}

- (void)clearPositionHistory
{
    [self.historyOfPositions removeAllObjects];
}

@end
