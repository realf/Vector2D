//
//  IABoard.h
//  ImagineAlice-iPhone
//
//  Created by Sergey Dunets on 7/29/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAPosition.h"

@interface IABoard : NSObject

@property (assign, nonatomic) NSUInteger numCols;
@property (assign, nonatomic) NSUInteger numRows;

- (id)initWithNumCols:(NSUInteger)numCols numRows:(NSUInteger)numRows;
- (id)init;
- (BOOL)isPositionOnBoard:(IAPosition *)position;

@end
