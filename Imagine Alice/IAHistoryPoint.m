//
//  IAHistoryPoint.m
//  Imagine Alice
//
//  Created by Sergey Dunets on 9/16/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IAHistoryPoint.h"

@interface IAHistoryPoint()

@property (retain, nonatomic) NSMutableArray *historyPoint;

@end

@implementation IAHistoryPoint

@synthesize historyPoint = _historyPoint;

- (NSMutableArray *)historyPoint
{
    if (!_historyPoint)
    {
        _historyPoint = [[NSMutableArray alloc] init];
    }
    return _historyPoint;
}

- (void)addObjectToHistoryPoint:(id)object
{
    if (object)
    {
        [self.historyPoint addObject:object];
    }
}

@end
