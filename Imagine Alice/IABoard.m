//
//  IABoard.m
//  ImagineAlice-iPhone
//
//  Created by Sergey Dunets on 7/29/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IABoard.h"

static const NSUInteger kMaxBoardSize = 10;
static const NSUInteger kMinBoardSize = 3;
static const NSUInteger kDefaultBoardSize = kMinBoardSize;

@implementation IABoard

@synthesize numCols = _numCols;
@synthesize numRows = _numRows;

// Designated initializer.
// It checks if values are valid and, if they are not valid, it uses defaults.
- (id)initWithNumCols:(NSUInteger)numCols numRows:(NSUInteger)numRows
{
    if (self = [super init]) 
    {
        if (numCols >= kMinBoardSize && numCols <= kMaxBoardSize)
            _numCols = numCols;
        else
            _numCols = kDefaultBoardSize;
        
        if (numRows >= kMinBoardSize && numRows <= kMaxBoardSize)
            _numRows = numRows;
        else
            _numRows = kDefaultBoardSize;
    }
    return self;
}

- (id)init
{
    return [self initWithNumCols:kDefaultBoardSize numRows:kDefaultBoardSize];
}

// Currently, since the board is rectangular and does not contain holes, 
// we can check the position simply comparing coordinates with numRows and numCols.
- (BOOL)isAbsolutePositionOnBoard:(Vector2D *)absolutePosition
{
    return (absolutePosition->x >= 0 && absolutePosition->x < self.numCols && absolutePosition->y >= 0 && absolutePosition->y < self.numRows);
}

@end
