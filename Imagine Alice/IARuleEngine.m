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
#import "DDLog.h"

#ifdef DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_ERROR;
#endif

@implementation IARuleEngine

@synthesize history = _history;
@synthesize gameObjects = _gameObjects;
@synthesize board = _board;
@synthesize isGameOver = _isGameOver;

- (id)init
{
    if (self = [super init])
    {
        _board = [[IABoard alloc] init];
        _gameObjects = [[NSMutableDictionary alloc] init];
        _history = [[IAHistory alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_history release];
    [_gameObjects release];
    [_board release];
    [super dealloc];
}

- (void)startGame
{
    [self loadLevel];
    [self saveHistory];
    DDLogInfo(@"History saved. Alice is at (%f, %f)", [[self.gameObjects objectForKey:@"Alice"] absolutePosition].x, [[self.gameObjects objectForKey:@"Alice"] absolutePosition].y);
    // other initializations here...
}

- (void)stopGame
{
    [self clearGameObjects];
    [self.history clear];
    self.isGameOver = YES;
}

- (void)clearGameObjects
{
    [self.gameObjects removeAllObjects];
}

#warning "This is a stub. Add the level loader in future."
// This is a stub. Later we will load levels with different rules and objects.
- (void)loadLevel
{
    // Put Alice to the center
    IAGameObject *alice = [[IAGameObject alloc] initWithName:@"Alice" absolutePosition:[IAAbsolutePosition absolutePositionWithX:self.board.numCols/2 y:self.board.numRows/2]];
    [self addGameObject:alice];
    [alice release];
    DDLogInfo(@"Let's play! Alice is at (%f, %f)", [[self.gameObjects objectForKey:@"Alice"] absolutePosition].x, [[self.gameObjects objectForKey:@"Alice"] absolutePosition].y);
    
    self.isGameOver = NO;
}


- (void)doComputerMoves
{
    // Let the computer make his move
    IAAbsolutePosition *nextAlicePosition = [self absolutePositionAfterRandomMoveFromAbsolutePosition:[[self.gameObjects objectForKey:@"Alice"] absolutePosition]];
    [[self.gameObjects objectForKey:@"Alice"] setAbsolutePosition:nextAlicePosition];
    
    DDLogInfo(@"iPhone moves to (%f, %f)", [[self.gameObjects objectForKey:@"Alice"] absolutePosition].x, [[self.gameObjects objectForKey:@"Alice"] absolutePosition].y);
    [self saveHistory];
    DDLogInfo(@"History saved. Alice is at (%f, %f)", [[self.gameObjects objectForKey:@"Alice"] absolutePosition].x, [[self.gameObjects objectForKey:@"Alice"] absolutePosition].y);
}

#warning "Stub method"
// Stub.
- (void)moveAliceToDirection:(NSString *)direction
{
    if (!self.isGameOver && [self.gameObjects objectForKey:@"Alice"])
    {
        if ([direction isEqualToString:@"Up"])
            [[self.gameObjects objectForKey:@"Alice"] absolutePosition].y += 1.0;
        else if ([direction isEqualToString:@"Down"])
            [[self.gameObjects objectForKey:@"Alice"] absolutePosition].y -= 1.0;
        else if ([direction isEqualToString:@"Right"])
            [[self.gameObjects objectForKey:@"Alice"] absolutePosition].x += 1.0;
        else if ([direction isEqualToString:@"Left"])
            [[self.gameObjects objectForKey:@"Alice"] absolutePosition].x -= 1.0;
        
        // If Alice is inside the board
        if ([self.board isAbsolutePositionOnBoard:[[self.gameObjects objectForKey:@"Alice"] absolutePosition]])
        {
            DDLogInfo(@"%@", [NSString stringWithFormat:@"Alice position is (%f, %f)", [[[self.gameObjects objectForKey:@"Alice"] absolutePosition] x], [[[self.gameObjects objectForKey:@"Alice"] absolutePosition] y]]);
            [self saveHistory];
            DDLogInfo(@"History saved. Alice is at (%f, %f)", [[self.gameObjects objectForKey:@"Alice"] absolutePosition].x, [[self.gameObjects objectForKey:@"Alice"] absolutePosition].y);
            
            [self doComputerMoves];
        }
        else
        {
            DDLogInfo(@"Game over! Alice position is (%f, %f)", [[self.gameObjects objectForKey:@"Alice"] absolutePosition].x, [[self.gameObjects objectForKey:@"Alice"] absolutePosition].y);
            
            //// TODO add notification about the end of game
            
            [self stopGame];
            //[self.theNewGameButton setHidden:NO];
        }
    }
}

- (void)saveHistory
{
    if (self.gameObjects != nil)
    {
        IAHistoryPoint *historyPoint = [[IAHistoryPoint alloc] init];
        for (id key in self.gameObjects)
            [historyPoint addObjectToHistoryPoint:[self.gameObjects objectForKey:key]];

#warning "Think if we need to save the board"
        // TODO We don't save the board. Do we need to?
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

- (NSArray *)legalMovesForAbsolutePosition:(IAAbsolutePosition *)absolutePosition
{
    NSMutableArray *legalMoves = [[[NSMutableArray alloc] init] autorelease];
    
    // If we have more complicated rules for different characters, we should use them here
    IAMove *moveUp = [IAMove moveByAbsoluteDeltaX:0.0 deltaY:1.0 moveDescription:@"Up"];
    IAMove *moveDown = [IAMove moveByAbsoluteDeltaX:0.0 deltaY:-1.0 moveDescription:@"Down"];
    IAMove *moveRight = [IAMove moveByAbsoluteDeltaX:1.0 deltaY:0.0 moveDescription:@"Right"];
    IAMove *moveLeft = [IAMove moveByAbsoluteDeltaX:-1.0 deltaY:0.0 moveDescription:@"Left"];
    
    IAAbsolutePosition *absolutePositionAfterMove = [[IAAbsolutePosition alloc] init];
    
    // Search for all possible moves by checking the position on the board after each move
    absolutePositionAfterMove.y = absolutePosition.y + moveUp.deltaY;
    if (YES == [self.board isAbsolutePositionOnBoard:absolutePositionAfterMove])
    {
        [legalMoves addObject:moveUp];
    }
    
    absolutePositionAfterMove.y = absolutePosition.y + moveDown.deltaY;
    if (YES == [self.board isAbsolutePositionOnBoard:absolutePositionAfterMove])
    {
        [legalMoves addObject:moveDown];
    }
    
    absolutePositionAfterMove.y = absolutePosition.y;
    absolutePositionAfterMove.x = absolutePosition.x + moveRight.deltaX;
    if (YES == [self.board isAbsolutePositionOnBoard:absolutePositionAfterMove])
    {
        [legalMoves addObject:moveRight];
    }
    
    absolutePositionAfterMove.x = absolutePosition.x + moveLeft.deltaX;
    if (YES == [self.board isAbsolutePositionOnBoard:absolutePositionAfterMove])
    {
        [legalMoves addObject:moveLeft];
    }
    
    [absolutePositionAfterMove release];
    return legalMoves;
}

- (IAAbsolutePosition *)absolutePositionAfterRandomMoveFromAbsolutePosition:(IAAbsolutePosition *)absolutePosition
{
    NSArray *legalMoves = [self legalMovesForAbsolutePosition:absolutePosition];
    NSUInteger numberOfLegalMoves = [legalMoves count];
    NSAssert(numberOfLegalMoves > 0, @"Cannot make a legal move");
    NSInteger randomMoveNumber = arc4random_uniform(numberOfLegalMoves);
    NSAssert(randomMoveNumber >= 0 && randomMoveNumber < numberOfLegalMoves, @"randomMoveNumber is out of range");
    
    IAAbsolutePosition *nextPosition = [[[IAAbsolutePosition alloc] init] autorelease];
    
    IAMove *move = [legalMoves objectAtIndex:randomMoveNumber];
    nextPosition.x = absolutePosition.x + [move deltaX];
    nextPosition.y = absolutePosition.y + [move deltaY];

    [[NSNotificationCenter defaultCenter] postNotificationName:IAObjectMovedNotification object:move.moveDescription];
    
    return nextPosition;
}

@end
