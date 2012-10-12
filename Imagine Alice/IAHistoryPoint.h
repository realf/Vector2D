//
//  IAHistoryPoint.h
//  Imagine Alice
//
//  Created by Sergey Dunets on 9/16/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IAHistoryPointProtocol <NSObject>
- (NSString *)name;
- (id)copy;
@end

/// Class IAHistoryPoint is used when we need to save the game state.
/// Every object adds itself to the history point, if it wants to be saved.

@interface IAHistoryPoint : NSObject

- (void)addObjectToHistoryPoint:(id<IAHistoryPointProtocol, NSCopying>)object;

// Gets the object with a given name.
- (id<IAHistoryPointProtocol, NSCopying>)objectWithName:(NSString *)name;

@end
