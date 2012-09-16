//
//  IAHistory.h
//  Imagine Alice
//
//  Created by Sergey Dunets on 9/16/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IAHistoryPoint.h"

/// The class IAHistory represents the sequence of history points.

@interface IAHistory : NSObject

- (void)addHistoryPoint:(IAHistoryPoint *)historyPoint;

@end
