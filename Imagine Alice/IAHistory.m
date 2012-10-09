//
//  IAHistory.m
//  Imagine Alice
//
//  Created by Sergey Dunets on 9/16/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IAHistory.h"

@interface IAHistory()

@property (retain, nonatomic) NSMutableArray *history;

@end

@implementation IAHistory

@synthesize history = _history;

- (NSMutableArray *)history
{
    if (!_history)
    {
        _history = [[NSMutableArray alloc] init];
    }
    return _history;
}

- (void)addHistoryPoint:(IAHistoryPoint *)historyPoint
{
    if (historyPoint)
    {
        [self.history addObject:historyPoint];
    }
}

- (void)clear
{
    [self.history removeAllObjects];
}

- (IAGameObject *)gameObject:(IAGameObject *)object atHistoryPointWithIndex:(NSUInteger)index
{
    return ([[self.history objectAtIndex:index] objectWithName:object.name]);
}

- (IAGameObject *)gameObjectAtPreviousHistoryPoint:(IAGameObject *)object
{
    return ([self gameObject:object atHistoryPointWithIndex:[self.history count] - 1]);
}

- (NSString *)description
{
    NSMutableString *descriptionString = [NSMutableString stringWithString:@"History:\n"];
    for (IAHistoryPoint *hp in self.history)
        [descriptionString appendFormat:@"<History point>\n%@</History point>\n\n", hp.description];
    return descriptionString;
}

- (void)dealloc
{
    [_history release];
    [super dealloc];
}

@end
