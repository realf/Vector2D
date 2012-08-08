//
//  CocoaLumberjackCustomFormatter.h
//  Imagine Alice
//
//  Created by Sergey Dunets on 8/8/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDLog.h"

@interface CocoaLumberjackCustomFormatter : NSObject <DDLogFormatter>
{
    int atomicLoggerCount;
    NSDateFormatter *threadUnsafeDateFormatter;
}
@end
