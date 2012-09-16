//
//  IAGameObject.h
//  ImagineAlice-iPhone
//
//  Created by Sergey Dunets on 7/29/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAAbsolutePosition.h"


// Represents objects in the game.
@interface IAGameObject : NSObject

@property (retain, nonatomic) NSMutableString *name;
@property (retain, nonatomic) IAAbsolutePosition *position;

- (id)initWithName:(NSString *)name position:(IAAbsolutePosition *)position;

@end
