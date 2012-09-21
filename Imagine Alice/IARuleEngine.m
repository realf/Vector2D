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

@interface IARuleEngine()

@end

@implementation IARuleEngine

@synthesize history = _history;
@synthesize gameObjects = _gameObjects;
@synthesize board = _board;
@synthesize isGameOver = _isGameOver;

/*- (id)gameObjects
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
 */

#warning "This is a stub. Add the level loader in future."
// This is a stub. Later we will load levels with different rules and objects.

- (id)init
{
    if (self = [super init])
    {
        [self resetGame];
    }
    return self;
}

#warning "Stub method"
// Stub
- (void)moveAliceToDirection:(NSString *)direction
{
    if (!self.isGameOver)
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
            
            // Let the computer make his move
            IAAbsolutePosition *nextAlicePosition = [self makeRandomMoveFromPosition:[[self.gameObjects objectForKey:@"Alice"] absolutePosition]];
            //[self.screen setText:[NSString stringWithFormat:@"iPhone moves Alice by (%d, %d)", nextAlicePosition.x - self.alicePosition.x, nextAlicePosition.y - self.alicePosition.y]];
            //DDLogInfo(@"iPhone moves Alice %@\n---------\n", direction);
            [[self.gameObjects objectForKey:@"Alice"] setAbsolutePosition:nextAlicePosition];
            DDLogInfo(@"iPhone moves to (%f, %f)\n----\n", [[self.gameObjects objectForKey:@"Alice"] absolutePosition].x, [[self.gameObjects objectForKey:@"Alice"] absolutePosition].y);
        }
        else
        {
            //[self.screen setText:[NSString stringWithFormat:@"Game over! Alice position is (%d, %d)", self.alicePosition.x, self.alicePosition.y]];
            DDLogInfo(@"Game over! Alice position is (%f, %f)", [[self.gameObjects objectForKey:@"Alice"] absolutePosition].x, [[self.gameObjects objectForKey:@"Alice"] absolutePosition].y);
            self.isGameOver = YES;
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
    [super dealloc];
}

- (void)resetGame
{
    /*self.boardWidth = 3;
     self.boardHeight = 3;
     self.alicePosition.x = self.boardWidth / 2;
     self.alicePosition.y = self.boardHeight / 2;
     [self.screen setText:[NSString stringWithFormat:@"Let's play! Alice is at (%d, %d)", self.alicePosition.x, self.alicePosition.y]];*/
    
    if (self.board)
        [self.board release];
    self.board = [[IABoard alloc] initWithNumCols:3 numRows:3];
    
    // Put Alice to the center
    IAGameObject *alice = [[IAGameObject alloc] initWithName:@"Alice" absolutePosition:[IAAbsolutePosition absolutePositionWithX:self.board.numCols/2 y:self.board.numRows/2]];
    
    if (self.gameObjects)
        [self.gameObjects release];
    self.gameObjects = [[NSMutableDictionary alloc] init];
    [self addGameObject:alice];
    
    if (self.history)
        [self.history release];
    self.history = [[IAHistory alloc] init];
    
    self.isGameOver = NO;
    DDLogInfo(@"Let's play! Alice is at (%f, %f)", [[self.gameObjects objectForKey:@"Alice"] absolutePosition].x, [[self.gameObjects objectForKey:@"Alice"] absolutePosition].y);
    //self.aliceCanGo = YES;
}

- (NSArray *)legalMovesForAbsolutePosition:(IAAbsolutePosition *)absolutePosition
{
    NSMutableArray *legalMoves = [[[NSMutableArray alloc] init] autorelease];
    
    // If we have more complicated rules for different characters, we should use them here
    IAMove *moveUp = [IAMove moveWithNumberOfStepsInXDirection:0 yDirection:1];
    IAMove *moveDown = [IAMove moveWithNumberOfStepsInXDirection:0 yDirection:-1];
    IAMove *moveRight = [IAMove moveWithNumberOfStepsInXDirection:1 yDirection:0];
    IAMove *moveLeft = [IAMove moveWithNumberOfStepsInXDirection:-1 yDirection:0];
    
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

- (IAAbsolutePosition *)makeRandomMoveFromPosition:(IAAbsolutePosition *)absolutePosition
{
    NSArray *legalMoves = [self legalMovesForAbsolutePosition:absolutePosition];
    NSUInteger numberOfLegalMoves = [legalMoves count];
    NSAssert(numberOfLegalMoves > 0, @"Cannot make a legal move");
    NSInteger randomMoveNumber = arc4random_uniform(numberOfLegalMoves);
    NSAssert(randomMoveNumber >= 0 && randomMoveNumber < numberOfLegalMoves, @"randomMoveNumber is out of range");
    IAAbsolutePosition *nextPosition = [[[IAAbsolutePosition alloc] init] autorelease];
    nextPosition.x = absolutePosition.x + [[legalMoves objectAtIndex:randomMoveNumber] deltaX];
    nextPosition.y = absolutePosition.y + [[legalMoves objectAtIndex:randomMoveNumber] deltaY];
    return nextPosition;
}

@end
