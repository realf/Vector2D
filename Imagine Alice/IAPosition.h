//
//  IAPosition.h
//  Imagine Alice
//
//  Created by Sergey Dunets on 8/12/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>

// Left hand bottom corner is x=0, y=0

@interface IAPosition : NSObject

@property (assign, nonatomic) float x;
@property (assign, nonatomic) float y;

+ (IAPosition *)newPositionWithX:(float)x y:(float)y;
- (id)initWithPosition:(IAPosition *)position;

@end
