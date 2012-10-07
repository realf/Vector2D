//
//  IARuleEngine.m
//  Imagine Alice
//
//  Created by Sergey Dunets on 8/12/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IARuleEngine.h"
#import "Vector2D.h"
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
    DDLogInfo(@"History saved. Alice is at (%f, %f)", [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->x, [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->y);
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
    Vector2D *right = [[Vector2D xAxis] copy];
    Vector2D *left = [[[Vector2D xAxis] copy] mult:-1.0];
    Vector2D *up = [[Vector2D yAxis] copy];
    Vector2D *down = [[[Vector2D yAxis] copy] mult:-1.0];
    NSArray *aliceMoves = @[right, left, up, down];
    IAGameObject *alice = [[IAGameObject alloc] initWithName:@"Alice" absolutePosition:[Vector2D withX:self.board.numCols/2 Y:self.board.numRows/2] availableMoves:aliceMoves];
    [self addGameObject:alice];
    [alice release];
    DDLogInfo(@"Let's play! Alice is at (%f, %f)", [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->x, [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->y);
    
    self.isGameOver = NO;
}


- (void)doComputerMoves
{
    // Let the computer make his move
    [self doRandomMoveForGameObject:self.gameObjects[@"Alice"]];    
    DDLogInfo(@"iPhone moves to (%f, %f)", [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->x, [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->y);
    [self saveHistory];
    DDLogInfo(@"History saved. Alice is at (%f, %f)", [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->x, [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->y);
}

#warning "Stub method"
// Stub.
- (void)moveAliceToDirection:(NSString *)direction
{
    if (!self.isGameOver && [self.gameObjects objectForKey:@"Alice"])
    {
        if ([direction isEqualToString:@"Up"])
            [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->y += 1.0;
        else if ([direction isEqualToString:@"Down"])
            [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->y -= 1.0;
        else if ([direction isEqualToString:@"Right"])
            [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->x += 1.0;
        else if ([direction isEqualToString:@"Left"])
            [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->x -= 1.0;
        
        // If Alice is inside the board
        if ([self.board isAbsolutePositionOnBoard:[[self.gameObjects objectForKey:@"Alice"] absolutePosition]])
        {
            DDLogInfo(@"%@", [NSString stringWithFormat:@"Alice position is (%f, %f)", [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->x, [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->y]);
            [self saveHistory];
            DDLogInfo(@"History saved. Alice is at (%f, %f)", [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->x, [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->y);
            
            [self doComputerMoves];
        }
        else
        {
            DDLogInfo(@"Game over! Alice position is (%f, %f)", [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->x, [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->y);
            
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

- (NSMutableArray *)allowedMovesForGameObject:(IAGameObject *)object
{
    NSMutableArray *allowedMoves = [[[NSMutableArray alloc] init] autorelease];
    
    // If we have more complicated rules for different characters, we should use them here
    
    Vector2D *absolutePositionAfterMove = [Vector2D zero];
    
    for (Vector2D *move in [object availableMoves])
    {
        // Check if the position is on the board after this move
        absolutePositionAfterMove = [[object absolutePosition] add:move];
        if ([self.board isAbsolutePositionOnBoard:absolutePositionAfterMove])
        {
            [allowedMoves addObject:move];
        }
    }
    return allowedMoves;
}

- (NSMutableArray *)deniedMovesForGameObject:(IAGameObject *)object
{
    NSMutableArray *deniedMoves = [[[NSMutableArray alloc] init] autorelease];
    
    // If we have more complicated rules for different characters, we should use them here
    
    Vector2D *absolutePositionAfterMove = [Vector2D zero];
    
    for (Vector2D *move in [object availableMoves])
    {
        absolutePositionAfterMove = [[[object absolutePosition] copy] add:move];
        // Check if we do not go back
        if ([[[self.history gameObject:object atHistoryPointWithIndex:0] absolutePosition] isEqual:absolutePositionAfterMove]
        // Check if the position is not on the board after this move
            || ![self.board isAbsolutePositionOnBoard:absolutePositionAfterMove])
        {
            [deniedMoves addObject:move];
        }
    }
    return deniedMoves;
}

- (void)doRandomMoveForGameObject:(IAGameObject *)object
{
    // We use "allow, deny" sequence.
    // Implement here more complex logic if needed.
    NSMutableArray *allowedMoves = [self allowedMovesForGameObject:object];
    NSMutableArray *deniedMoves = [self deniedMovesForGameObject:object];
    for (Vector2D *move in allowedMoves)
    {
        if ([deniedMoves containsObject:move])
            [allowedMoves removeObject:move];
    }
    NSUInteger numberOfAllowedMoves = [allowedMoves count];
    NSAssert(numberOfAllowedMoves > 0, @"No moves allowed");
    NSInteger randomMoveNumber = arc4random_uniform(numberOfAllowedMoves);
    NSAssert(randomMoveNumber >= 0 && randomMoveNumber < numberOfAllowedMoves, @"randomMoveNumber is out of range");
    Vector2D *move = [allowedMoves objectAtIndex:randomMoveNumber];
    [object.absolutePosition add:move];
    [[NSNotificationCenter defaultCenter] postNotificationName:IAObjectMovedNotification object:move];
}

@end
