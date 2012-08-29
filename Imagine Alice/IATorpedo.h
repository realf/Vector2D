//
//  IATorpedo.h
//  Imagine Alice
//
//  Created by Sergey Dunets on 8/29/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IAGameObject.h"

@interface IATorpedo : IAGameObject

@property (retain, nonatomic) NSNumber *speed;
- (id)initWitName:(NSString *)name position:(IAPosition *)position speed:(NSNumber *)speed;

@end
