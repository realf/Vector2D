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
static const NSUInteger kDefaultBoardSize = 3;

@implementation IABoard

@synthesize numCols = _numCols;
@synthesize numRows = _numRows;

// Designated initializer.
// It checks if values are valid and if they are not, it uses defaults.
- (id)initWithNumCols:(NSUInteger)numCols numRows:(NSUInteger)numRows
{
    if (self = [super init]) 
    {
        if (_numCols >= kMinBoardSize && _numCols <= kMaxBoardSize)
            _numCols = numCols;
        else
            _numCols = kDefaultBoardSize;
        
        if (_numRows >= kMinBoardSize && _numRows <= kMaxBoardSize)
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

@end
