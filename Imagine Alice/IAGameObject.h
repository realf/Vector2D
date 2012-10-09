//
//  IAGameObject.h
//  ImagineAlice-iPhone
//
//  Created by Sergey Dunets on 7/29/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector2D.h"
#import "IAHistoryPoint.h"

/// Class IAGameObject represents objects in the game.

@interface IAGameObject : NSObject <IAHistoryPointProtocol, NSCopying>

@property (retain, nonatomic) NSMutableString *name;
@property (retain, nonatomic) Vector2D *absolutePosition;
@property (retain, nonatomic) NSMutableArray *availableMoves;
@property (retain, nonatomic) NSMutableArray *historyOfPositions;

- (id)initWithName:(NSString *)name absolutePosition:(Vector2D *)position
    availableMoves:(NSArray *)moves;

- (void)savePositionToHistory;
- (void)clearPositionHistory;

@end
