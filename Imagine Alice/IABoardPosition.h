//
//  IABoardPosition.h
//  Imagine Alice
//
//  Created by Sergey Dunets on 9/16/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Class IABoardPosition represents the position in the board coordinate system. 

@interface IABoardPosition : NSObject

@property (assign, nonatomic) NSInteger x;
@property (assign, nonatomic) NSInteger y;

+ (IABoardPosition *)boardPositionWithX:(NSInteger)x y:(NSInteger)y;
- (id)initWithBoardPosition:(IABoardPosition *)position;

@end
