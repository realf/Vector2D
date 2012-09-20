//
//  IACell.h
//  ImagineAlice-iPhone
//
//  Created by Sergey Dunets on 7/29/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IACharacter.h"

// Represents the cell on the board. It is a collection of characters and 
// location-specific conditions.
@interface IACell : NSObject

@property (retain, nonatomic) NSMutableArray *characters;

- (id)initWithCharacters:(NSMutableArray *)characters;
- (void)addCharacter:(IACharacter *)character;
- (IACharacter *)characterAtIndex:(NSUInteger)index;

@end
