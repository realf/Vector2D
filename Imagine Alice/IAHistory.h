//
//  IAHistory.h
//  Imagine Alice
//
//  Created by Sergey Dunets on 9/16/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IAHistoryPoint.h"
#import "IAGameObject.h"

/// Class IAHistory represents the sequence of history points.

@interface IAHistory : NSObject

- (void)addHistoryPoint:(IAHistoryPoint *)historyPoint;

// We can get objects by their names.
- (IAGameObject *)gameObject:(IAGameObject *)object atHistoryPointWithIndex:(NSUInteger)index;

// We can also get objects at the last history point
- (IAGameObject *)gameObjectAtPreviousHistoryPoint:(IAGameObject *)object;

- (void)clear;

@end
