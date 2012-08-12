//
//  IAMoveEngine.h
//  Imagine Alice
//
//  Created by Sergey Dunets on 8/12/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAPosition.h"

/***
 Provides basic movement operations.
 ***/

@interface IAMoveEngine : NSObject

- (BOOL)isPosition:(IAPosition *)position insideTheBoardWithWidth:(NSUInteger)width height:(NSUInteger)height;
- (NSArray *)legalMovesForPosition:(IAPosition *)position onTheBoardWithWidth:(NSUInteger)width height:(NSUInteger)height;
- (IAPosition *)makeRandomMoveFromPosition:(IAPosition *)position onTheBoardWithWidth:(NSInteger)width height:(NSInteger)height;

@end
