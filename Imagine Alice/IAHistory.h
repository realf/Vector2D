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
- (IAGameObject *)gameObjectWithName:(NSString *)name atHistoryPointIndex:(NSUInteger)historyPointIndex;

// We can also get objects at the last history point
- (IAGameObject *)gameObjectAtLastHistoryPointWithObjectName:(NSString *)name;

@end
