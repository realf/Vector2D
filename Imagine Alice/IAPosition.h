//
//  IAPosition.h
//  Imagine Alice
//
//  Created by Sergey Dunets on 8/12/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>

// The position is given in absolute values. The position (0.0, 0.0) is 
// the left bottom corner of the board cell (0, 0).

@interface IAPosition : NSObject

@property (assign, nonatomic) double x;
@property (assign, nonatomic) double y;

+ (IAPosition *)newPositionWithX:(double)x y:(double)y;
- (id)initWithPosition:(IAPosition *)position;

@end
