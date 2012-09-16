//
//  IAAbsolutePosition.h
//  Imagine Alice
//
//  Created by Sergey Dunets on 8/12/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Class IAAbsolutePosition represents the position in absolute values. 
/// The position (0.0, 0.0) is the left bottom corner of the board cell (0, 0).

@interface IAAbsolutePosition : NSObject

@property (assign, nonatomic) double x;
@property (assign, nonatomic) double y;

+ (IAAbsolutePosition *)newAbsolutePositionWithX:(double)x y:(double)y;
- (id)initWithAbsolutePosition:(IAAbsolutePosition *)position;

@end
