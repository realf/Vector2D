//
//  IABoardPosition.h
//  Imagine Alice
//
//  Created by Sergey Dunets on 9/16/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Class IABoardPosition represents the position in board values. 
/// All objects with absolute coordinates in the range of
/// [0.0, 0.0; 1.0, 1.0) have the board coordinates (0, 0);

@interface IABoardPosition : NSObject

@property (assign, nonatomic) NSInteger x;
@property (assign, nonatomic) NSInteger y;

+ (IABoardPosition *)newBoardPositionWithX:(NSInteger)x y:(NSInteger)y;
- (id)initWithBoardPosition:(IABoardPosition *)position;

@end
