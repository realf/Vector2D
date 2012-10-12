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
        _board = [[IABoard alloc] initWithNumCols:3 numRows:3];
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
    for (NSString* key in self.gameObjects)
        [self.gameObjects[key] savePositionToHistory];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:IAGameStateChangedNotification object:[NSString stringWithFormat:@"Let's play! Alice is on %@, board is %dX%d.", [[[self.gameObjects objectForKey:@"Alice"] absolutePosition] intDescription], self.board.numCols, self.board.numRows]];
    
    DDLogInfo(@"History saved. Alice is at (%f, %f)", [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->x, [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->y);
    // other initializations here...
}

- (void)stopGame
{
    [self clearGameObjects];
    [self.history clear];
    for (NSString* key in self.gameObjects)
    {
        [[self.gameObjects objectForKey:key] clearPositionHistory];
    }
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
    const Vector2D * const right = [Vector2D withX:1.0 Y:0.0];
    const Vector2D * const left = [Vector2D withX:-1.0 Y:0.0];
    const Vector2D * const up = [Vector2D withX:0.0 Y:1.0];
    const Vector2D * const down = [Vector2D withX:0.0 Y:-1.0];
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
    [[self.gameObjects objectForKey:@"Alice"] savePositionToHistory];
    
    DDLogInfo(@"History saved. Alice is at (%f, %f)", [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->x, [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->y);
}

#warning "Stub method"
// Stub.
- (void)moveAliceToDirection:(NSString *)direction
{
    [self moveGameObject:self.gameObjects[@"Alice"] toDirection:direction];
}

- (void)moveGameObject:(IAGameObject *)object toDirection:(NSString *)direction
{
    Vector2D *move = [Vector2D zero];
    if (!self.isGameOver)
    {
        if ([direction isEqualToString:@"Up"])
            [move add:[Vector2D withX:0.0 Y:1.0]];
        else if ([direction isEqualToString:@"Down"])
            [move add:[Vector2D withX:0.0 Y:-1.0]];
        else if ([direction isEqualToString:@"Right"])
            [move add:[Vector2D withX:1.0 Y:0.0]];
        else if ([direction isEqualToString:@"Left"])
            [move add:[Vector2D withX:-1.0 Y:0.0]];
        
        // If the object will stay inside the board and will not
        // return to its previous position after this turn
        if (![self checkIfGameObject:object goesOutsideTheBoardAfterMove:move]
            && ![self checkIfGameObject:object returnsBackAfterMove:move])
        {
            // Move it
            [object.absolutePosition add:move];
            
            DDLogInfo(@"%@", [NSString stringWithFormat:@"%@ position is (%f, %f)", object.name, object.absolutePosition->x, object.absolutePosition->y]);
            [self saveHistory];
            [[self.gameObjects objectForKey:@"Alice"] savePositionToHistory];
            
            DDLogInfo(@"History saved. Alice is at (%f, %f)", object.absolutePosition->x, object.absolutePosition->y);
            
            [self doComputerMoves];
        }
        else
        {
            if ([self checkIfGameObject:object goesOutsideTheBoardAfterMove:move])
            {
                [object.absolutePosition add:move];
                [[NSNotificationCenter defaultCenter] postNotificationName:IAGameStateChangedNotification object:[NSString stringWithFormat:@"Game over. You moved outside the board: %@", object.absolutePosition.intDescription]];
            }
            if ([self checkIfGameObject:object returnsBackAfterMove:move])
            {
                [object.absolutePosition add:move];
                [[NSNotificationCenter defaultCenter] postNotificationName:IAGameStateChangedNotification object:[NSString stringWithFormat:@"Game over. You returned to your previous position: %@", object.absolutePosition.intDescription]];
            }
            
            DDLogInfo(@"Game over! Alice position is (%f, %f)", [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->x, [[self.gameObjects objectForKey:@"Alice"] absolutePosition]->y);
            
            [self stopGame];
        }
    }
}

- (void)saveHistory
{
    if (self.gameObjects != nil)
    {
        IAHistoryPoint *historyPoint = [[IAHistoryPoint alloc] init];
        for (NSString* key in self.gameObjects)
            [historyPoint addObjectToHistoryPoint:[self.gameObjects objectForKey:key]];
        
        // TODO: We don't save the board. Do we need to?
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

// Returns YES if the object attempts to go back
- (BOOL)checkIfGameObject:(IAGameObject*)object returnsBackAfterMove:(Vector2D *)move
{
    Vector2D *absolutePositionAfterMove = [[[object.absolutePosition copy] autorelease] add:move];
    
    // Here we learn out, how many steps we did before. We expect the first element in
    // object.historyOfPositions is its initial position
    NSInteger steps = object.historyOfPositions.count;
    
    Vector2D *absolutePositionAtPreviousMove = (steps > 1) ? object.historyOfPositions[steps - 2] : nil;
    
    if (absolutePositionAtPreviousMove != nil
        && [absolutePositionAtPreviousMove isEqual:absolutePositionAfterMove])
        return YES;

    return NO;
}

// Returns YES if object is going to go outside the board
- (BOOL)checkIfGameObject:(IAGameObject *)object goesOutsideTheBoardAfterMove:(Vector2D *)move
{
    Vector2D *absolutePositionAfterMove = [[[object.absolutePosition copy] autorelease] add:move];
    // Check if the object's position is not on the board after this move
    return (![self.board isAbsolutePositionOnBoard:absolutePositionAfterMove]);
}

- (NSMutableArray *)deniedMovesForGameObject:(IAGameObject *)object
{
    NSMutableArray *deniedMoves = [[[NSMutableArray alloc] init] autorelease];
    
    // If we have more complicated rules for different characters, we should use them here
    
    for (Vector2D *move in [object availableMoves])
    {
        // 1. Check if we do not go back
        if ([self checkIfGameObject:object returnsBackAfterMove:move])
        {
            if (![deniedMoves containsObject:move])
                [deniedMoves addObject:move];
        }
        
        // 2. Check if the object's position is not on the board after this move
        if ([self checkIfGameObject:object goesOutsideTheBoardAfterMove:move])
        {
            if (![deniedMoves containsObject:move])
                [deniedMoves addObject:move];
        }
    }
    return deniedMoves;
}

- (NSMutableArray *)availableMovesAfterApplyingRulesToGameObject:(IAGameObject*)object
{
    // We get available moves from object and then check if some of them
    // are denied.
    // Implement here more complex logic if needed.
    NSMutableArray *availableMoves = object.availableMoves;
    NSMutableArray *deniedMoves = [self deniedMovesForGameObject:object];
    NSMutableArray *availableMinusDeniedMoves = [[[NSMutableArray alloc] init] autorelease];
    for (Vector2D *move in availableMoves)
    {
        if (![deniedMoves containsObject:move])
            [availableMinusDeniedMoves addObject:move];
    }
    return availableMinusDeniedMoves;
}

- (void)doRandomMoveForGameObject:(IAGameObject *)object
{
    NSMutableArray *availableMinusDeniedMoves = [self availableMovesAfterApplyingRulesToGameObject:object];
    NSUInteger numberOfMoves = [availableMinusDeniedMoves count];

    NSInteger randomNumber;
    Vector2D *move;
    if (numberOfMoves != 0)
    {
        randomNumber= arc4random_uniform(numberOfMoves);
        move = availableMinusDeniedMoves[randomNumber];
        [object.absolutePosition add:move];
        [[NSNotificationCenter defaultCenter] postNotificationName:IAObjectMovedNotification object:move];
    }
    else
    {
        DDLogError(@"No moves available.\n%@", self.history);
    }
}

@end
