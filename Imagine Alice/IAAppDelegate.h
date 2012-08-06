//
//  IAAppDelegate.h
//  Imagine Alice
//
//  Created by Sergey Dunets on 8/6/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IAViewController;

@interface IAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) IAViewController *viewController;

@end
