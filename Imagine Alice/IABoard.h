//
//  IABoard.h
//  ImagineAlice-iPhone
//
//  Created by Sergey Dunets on 7/29/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector2D.h"

/// Class IABoard represents the game board. It is responsible for operations
/// with board coordinates.

@interface IABoard : NSObject

@property (assign, nonatomic) NSUInteger numCols;
@property (assign, nonatomic) NSUInteger numRows;

// Designated initializer
- (id)initWithNumCols:(NSUInteger)numCols numRows:(NSUInteger)numRows;

// Checks if given absolute position is on the board
- (BOOL)isAbsolutePositionOnBoard:(Vector2D *)absolutePosition;

@end
