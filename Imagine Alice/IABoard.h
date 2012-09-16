//
//  IABoard.h
//  ImagineAlice-iPhone
//
//  Created by Sergey Dunets on 7/29/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAAbsolutePosition.h"
#import "IABoardPosition.h"

/// Class IABoard represents the game board. It is responsible for operations
/// with board coordinates.

@interface IABoard : NSObject

@property (assign, nonatomic) NSUInteger numCols;
@property (assign, nonatomic) NSUInteger numRows;

// Designated initializer
- (id)initWithNumCols:(NSUInteger)numCols numRows:(NSUInteger)numRows;

// Checks if given absolute position is on the board
- (BOOL)isAbsolutePositionOnBoard:(IAAbsolutePosition *)absolutePosition;

// Checks if given position (in board coordinates) is on the board
- (BOOL)isBoardPositionOnBoard:(IABoardPosition *)boardPosition;

// Converts absolute coordinates to board coordinates
+ (IABoardPosition *)boardPositionForAbsolutePosition:(IAAbsolutePosition *)absolutePosition;

@end
