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

@end
