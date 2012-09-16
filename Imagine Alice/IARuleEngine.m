//
//  IARuleEngine.m
//  Imagine Alice
//
//  Created by Sergey Dunets on 8/12/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IARuleEngine.h"
#import "IABoard.h"
#import "IAMove.h"

@interface IARuleEngine()

@end

@implementation IARuleEngine

@synthesize history = _history;
@synthesize gameObjects = _gameObjects;
@synthesize board = _board;

- (id)gameObjects
{
    if (_gameObjects == nil)
        _gameObjects = [[NSMutableDictionary alloc] init];
    return _gameObjects;
}

- (id)history
{
    if (_history == nil)
        _history = [[IAHistory alloc] init];
    return _history;
}

- (id)board
{
    if (_board == nil)
        _board = [[IABoard alloc] init];
    return _board;
}

- (void)saveHistory
{
    if (self.gameObjects != nil)
    {
        IAHistoryPoint *historyPoint = [[IAHistoryPoint alloc] init];
        for (id key in self.gameObjects)
        {
            [historyPoint addObjectToHistoryPoint:[self.gameObjects objectForKey:key]];
        }
#warning "Think if we need to save the board"
        // TODO We don't save the board. Do we need it?
        [self.history addHistoryPoint:historyPoint];
        [historyPoint release];
    }
}

- (void)addGameObject:(IAGameObject *)gameObject
{
    if (gameObject.name)
        [self.gameObjects setObject:gameObject forKey:gameObject.name];
}

- (void)removeGameObject:(IAGameObject *)gameObject
{
    if (gameObject.name)
        [self.gameObjects removeObjectForKey:gameObject.name];
}

- (void)dealloc
{
    [_history release];
    [_gameObjects release];
    [_board release];
}

- (NSArray *)legalMovesForPosition:(IAAbsolutePosition *)position onTheBoardWithWidth:(NSUInteger)width height:(NSUInteger)height
{
    NSMutableArray *legalMoves = [[[NSMutableArray alloc] init] autorelease];
    
    // If we have more complicated rules for different characters, we should use them here
    IAMove *moveUp = [IAMove moveWithNumberOfStepsInXDirection:0 yDirection:1];
    IAMove *moveDown = [IAMove moveWithNumberOfStepsInXDirection:0 yDirection:-1];
    IAMove *moveRight = [IAMove moveWithNumberOfStepsInXDirection:1 yDirection:0];
    IAMove *moveLeft = [IAMove moveWithNumberOfStepsInXDirection:-1 yDirection:0];
    
    IAAbsolutePosition *positionAfterMove = [[IAAbsolutePosition alloc] init];
    
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

- (IAAbsolutePosition *)makeRandomMoveFromPosition:(IAAbsolutePosition *)position onTheBoardWithWidth:(NSInteger)width height:(NSInteger)height
{
    NSArray *legalMoves = [self legalMovesForPosition:position onTheBoardWithWidth:width height:height];
    NSUInteger numberOfLegalMoves = [legalMoves count];
    NSAssert(numberOfLegalMoves > 0, @"Cannot make a legal move");
    NSInteger randomMoveNumber = arc4random_uniform(numberOfLegalMoves);
    NSAssert(randomMoveNumber >= 0 && randomMoveNumber < numberOfLegalMoves, @"randomMoveNumber is out of range");
    IAAbsolutePosition *nextPosition = [[[IAAbsolutePosition alloc] init] autorelease];
    nextPosition.x = position.x + [[legalMoves objectAtIndex:randomMoveNumber] deltaX];
    nextPosition.y = position.y + [[legalMoves objectAtIndex:randomMoveNumber] deltaY];
    return nextPosition;
}

@end
