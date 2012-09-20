//
//  BoardView.m
//  ImagineAlice
//
//  Created by Sergey Dunets on 7/19/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IABoardView.h"

@interface IABoardView()

@end


@implementation IABoardView

@synthesize dataSource = _dataSource;

- (void)setup
{
#ifdef DEBUG
    self.backgroundColor = [UIColor redColor];
#endif
    self.image = [UIImage imageNamed:@"chessboard300_300.png"];
    self.contentMode = UIViewContentModeRedraw;
    self.tag = 0;
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

@end
