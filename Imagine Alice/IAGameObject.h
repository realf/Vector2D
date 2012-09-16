//
//  IAGameObject.h
//  ImagineAlice-iPhone
//
//  Created by Sergey Dunets on 7/29/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAAbsolutePosition.h"
#import "IAHistoryPoint.h"

/// Class IAGameObject represents objects in the game.

@interface IAGameObject : NSObject <IAHistoryPointProtocol>

@property (retain, nonatomic) NSMutableString *name;
@property (retain, nonatomic) IAAbsolutePosition *absolutePosition;

- (id)initWithName:(NSString *)name absolutePosition:(IAAbsolutePosition *)absolutePosition;

@end
