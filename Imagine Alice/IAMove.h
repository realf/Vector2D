//
//  IAMove.h
//  Imagine Alice
//
//  Created by Sergey Dunets on 8/12/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>

/***
 Representation of any character's move
 ***/

@interface IAMove : NSObject

// {deltaX=0, deltaY=1} is up; {0, -1} is down; {1, 0} is right; {-1, 0} is left.
@property (assign, nonatomic) NSInteger deltaX;
@property (assign, nonatomic) NSInteger deltaY;
+ (IAMove *)moveWithNumberOfStepsInXDirection:(NSInteger)deltaX yDirection:(NSInteger)deltaY;

@end
