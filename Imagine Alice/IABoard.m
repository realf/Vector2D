//
//  IABoard.m
//  ImagineAlice-iPhone
//
//  Created by Sergey Dunets on 7/29/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IABoard.h"
#import "IAGlobalConstants.h"
#import "IABoardPosition.h"

static const NSUInteger kMaxBoardSize = 10;
static const NSUInteger kMinBoardSize = 3;
static const NSUInteger kDefaultBoardSize = kMinBoardSize;

@implementation IABoard

@synthesize numCols = _numCols;
@synthesize numRows = _numRows;

// Designated initializer.
// It checks if values are valid and if they are not, it uses defaults.
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
// we can check the board position simply comparing coordinates with numRows and numCols.
- (BOOL)isBoardPositionOnBoard:(IABoardPosition *)boardPosition
{
    return (boardPosition.x >= 0 && boardPosition.x < self.numCols && boardPosition.y >= 0 && boardPosition.y < self.numRows);
}

- (BOOL)isAbsolutePositionOnBoard:(IAAbsolutePosition *)absolutePosition
{
    return ([self isBoardPositionOnBoard:[[self class] boardPositionForAbsolutePosition:absolutePosition]]);
}

+ (IABoardPosition *)boardPositionForAbsolutePosition:(IAAbsolutePosition *)absolutePosition
{
    IABoardPosition *boardPosition = [[[IABoardPosition alloc] init] autorelease];
    if (fabs(ceil(absolutePosition.x) - absolutePosition.x) < EPSILON)
        boardPosition.x = (NSInteger)ceil(absolutePosition.x);
    else
        boardPosition.x = (NSInteger)floor(absolutePosition.x);
    
    if (fabs(ceil(absolutePosition.y) - absolutePosition.y) < EPSILON) 
        boardPosition.y = (NSInteger)ceil(absolutePosition.y);
    else
        boardPosition.y = (NSInteger)floor(absolutePosition.y);
    return boardPosition;
}

@end
