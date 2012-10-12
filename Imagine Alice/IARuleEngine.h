//
//  IARuleEngine.h
//  Imagine Alice
//
//  Created by Sergey Dunets on 8/12/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAGameObject.h"
#import "IABoard.h"
#import "IAHistory.h"

static NSString * const IAObjectMovedNotification = @"IAObjectMovedNotification";
static NSString * const IAGameStateChangedNotification = @"IAGameStateChangedNotification";

/***
 Class IARuleEngine provides basic game rules. 
 It manages the gameplay and interaction of main game objects. 
 In future it will be able to load levels with custom rules for every level.
 ***/

@interface IARuleEngine : NSObject

// Contains current game objects
@property (retain, nonatomic) NSMutableDictionary *gameObjects;

// The board we use on the current level
@property (retain, nonatomic) IABoard *board;

// Contains states of all game objects after every turn
@property (retain, nonatomic) IAHistory *history;

// Set this if the game ends
@property (assign, nonatomic) BOOL isGameOver;

// The game begins here
- (void)startGame;

// Saves all game objects to the history
- (void)saveHistory;

// Adds the object to the current game
- (void)addGameObject:(IAGameObject *)gameObject;

// Removes given object from the game
- (void)removeGameObject:(IAGameObject *)gameObject;

#warning "stub"
// stub
- (void)moveAliceToDirection:(NSString *)direction;

@end
