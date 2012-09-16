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

/// Class IABoard represents the game board. It is responsible operations
/// with board coordinates.

@interface IABoard : NSObject

@property (assign, nonatomic) NSUInteger numCols;
@property (assign, nonatomic) NSUInteger numRows;

- (id)initWithNumCols:(NSUInteger)numCols numRows:(NSUInteger)numRows;
- (id)init;
- (BOOL)isAbsolutePositionOnBoard:(IAAbsolutePosition *)position;
- (BOOL)isBoardPositionOnBoard:(IABoardPosition *)position;
+ (IABoardPosition *)boardPositionForAbsolutePosition:(IAAbsolutePosition *)absolutePosition;

@end
