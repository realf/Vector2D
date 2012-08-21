//
//  IAPositionChecker.m
//  Imagine Alice
//
//  Created by Sergey Dunets on 8/12/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IARuleEngine.h"
#import "IAMove.h"

@implementation IARuleEngine

- (BOOL)isCharacter:(IACharacter *)character onBoard:(IABoard *)board
{
    if (character.position.x >= 0 && character.position.x < board.numCols && character.position.y >= 0 && character.position.y < board.numRows)
        return YES;
    else
        return NO;
}

- (NSArray *)legalMovesForPosition:(IAPosition *)position onTheBoardWithWidth:(NSUInteger)width height:(NSUInteger)height
{
    NSMutableArray *legalMoves = [[[NSMutableArray alloc] init] autorelease];
    
    // If we have more complicated rules for different characters, we should use them here
    IAMove *moveUp = [IAMove moveWithNumberOfStepsInXDirection:0 yDirection:1];
    IAMove *moveDown = [IAMove moveWithNumberOfStepsInXDirection:0 yDirection:-1];
    IAMove *moveRight = [IAMove moveWithNumberOfStepsInXDirection:1 yDirection:0];
    IAMove *moveLeft = [IAMove moveWithNumberOfStepsInXDirection:-1 yDirection:0];
    
    IAPosition *positionAfterMove = [[IAPosition alloc] init];
    
    // Search for all possible moves by checking the position on the board after each move
    positionAfterMove.y = position.y + moveUp.deltaY;
    if (YES == [self isPosition:positionAfterMove insideTheBoardWithWidth:width height:height])
    {
        [legalMoves addObject:moveUp];
    }
    
    positionAfterMove.y = position.y + moveDown.deltaY;
    if (YES == [self isPosition:positionAfterMove insideTheBoardWithWidth:width height:height])
    {
        [legalMoves addObject:moveDown];
    }
    
    positionAfterMove.y = position.y;
    positionAfterMove.x = position.x + moveRight.deltaX;
    if (YES == [self isPosition:positionAfterMove insideTheBoardWithWidth:width height:height])
    {
        [legalMoves addObject:moveRight];
    }
    
    positionAfterMove.x = position.x + moveLeft.deltaX;
    if (YES == [self isPosition:positionAfterMove insideTheBoardWithWidth:width height:height])
    {
        [legalMoves addObject:moveLeft];
    }
    
    [positionAfterMove release];
    return legalMoves;
}

- (IAPosition *)makeRandomMoveFromPosition:(IAPosition *)position onTheBoardWithWidth:(NSInteger)width height:(NSInteger)height
{
    NSArray *legalMoves = [self legalMovesForPosition:position onTheBoardWithWidth:width height:height];
    NSUInteger numberOfLegalMoves = [legalMoves count];
    NSAssert(numberOfLegalMoves > 0, @"Cannot make a legal move");
    NSInteger randomMoveNumber = arc4random_uniform(numberOfLegalMoves);
    NSAssert(randomMoveNumber >= 0 && randomMoveNumber < numberOfLegalMoves, @"randomMoveNumber is out of range");
    IAPosition *nextPosition = [[[IAPosition alloc] init] autorelease];
    nextPosition.x = position.x + [[legalMoves objectAtIndex:randomMoveNumber] deltaX];
    nextPosition.y = position.y + [[legalMoves objectAtIndex:randomMoveNumber] deltaY];
    return nextPosition;
}

@end
