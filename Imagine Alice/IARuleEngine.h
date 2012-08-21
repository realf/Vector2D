//
//  IARuleEngine.h
//  Imagine Alice
//
//  Created by Sergey Dunets on 8/12/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IACharacter.h"
#import "IABoard.h"

/***
 Provides basic movement operations.
 ***/

@interface IARuleEngine : NSObject

- (BOOL)isCharacter:(IACharacter *)character onBoard:(IABoard *)board;
- (NSArray *)legalMovesForPosition:(IAPosition *)position onTheBoardWithWidth:(NSUInteger)width height:(NSUInteger)height;
- (IAPosition *)makeRandomMoveFromPosition:(IAPosition *)position onTheBoardWithWidth:(NSInteger)width height:(NSInteger)height;

@end
