//
//  IACell.m
//  ImagineAlice-iPhone
//
//  Created by Sergey Dunets on 7/29/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IACell.h"
#import "IACharacter.h"
#import "DDLog.h"


static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation IACell

@synthesize characters = _characters;

- (NSMutableArray *)characters
{
    if (_characters == nil) {
        _characters = [[NSMutableArray alloc] init];
    }
    return _characters;
}

- (id)initWithCharacters:(NSMutableArray *)characters
{
    if (self = [super init]) {
        [_characters release];
        _characters = [characters copy];
    }
    return self;
}

- (void)addCharacter:(IACharacter *)character
{
    [self.characters addObject:character];
}

- (IACharacter *)characterAtIndex:(NSUInteger)index
{
    if (index <= [self.characters count]) {
        return [self.characters objectAtIndex:index];
    }
    else
    {
        DDLogError(@"Index out of bands");
        return nil;
    }
}

- (void)dealloc
{
    [_characters release];
    [super dealloc];
}

@end
