//
//  IARow.m
//  ImagineAlice-iPhone
//
//  Created by Sergey Dunets on 7/27/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IARow.h"

@interface IARow()

// Each row contains WIDTH cells.
@property (retain, nonatomic) NSMutableArray *row;

@end


@implementation IARow

@synthesize row = _row;

- (NSMutableArray *)row
{
    if (_row == nil) {
        _row = [[NSMutableArray alloc] init];
    }
    return _row;
}

- (void)insertCell:(IACell *)cell inRowAtIndex:(NSUInteger)index
{
    [self.row insertObject:cell atIndex:index];
}

- (void)replaceCellInRowAtIndex:(NSUInteger)index withCell:(IACell *)cell
{
    [self.row replaceObjectAtIndex:index withObject:cell];
}

- (IACell *)cellInRowAtIndex:(NSUInteger)index
{
    return [self.row objectAtIndex:index];
}

- (void)dealloc
{
    [_row release];
    [super dealloc];
}

@end
