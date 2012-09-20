//
//  IARow.h
//  ImagineAlice-iPhone
//
//  Created by Sergey Dunets on 7/27/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IACell.h"

@interface IARow : NSObject

- (void)insertCell:(IACell *)cell inRowAtIndex:(NSUInteger)index;
- (void)replaceCellInRowAtIndex:(NSUInteger)index withCell:(IACell *)cell;
- (IACell *)cellInRowAtIndex:(NSUInteger)index;

@end
