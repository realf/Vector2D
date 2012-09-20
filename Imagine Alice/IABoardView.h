//
//  BoardView.h
//  ImagineAlice
//
//  Created by Sergey Dunets on 7/19/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IABoardView;


@protocol BoardViewDataSource <NSObject>

- (NSMutableArray *)charactersPositionsForBoardView:(IABoardView *)sender;

@end


@interface IABoardView : UIImageView

@property (assign, nonatomic) IBOutlet id <BoardViewDataSource> dataSource;

@end
