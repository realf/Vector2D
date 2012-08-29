//
//  IAGameObject.h
//  ImagineAlice-iPhone
//
//  Created by Sergey Dunets on 7/29/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAPosition.h"


// Represents the character in the game.
@interface IAGameObject : NSObject

@property (retain, nonatomic) NSMutableString *name;
@property (retain, nonatomic) IAPosition *position;
@property (assign, nonatomic) BOOL isEnabled;

- (id)initWithName:(NSString *)name position:(IAPosition *)position;

@end
