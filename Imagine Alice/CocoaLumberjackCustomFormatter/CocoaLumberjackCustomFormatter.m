//
//  CocoaLumberjackCustomFormatter.m
//  Imagine Alice
//
//  Created by Sergey Dunets on 8/8/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "CocoaLumberjackCustomFormatter.h"
#import <libkern/OSAtomic.h>

@implementation CocoaLumberjackCustomFormatter

- (NSString *)stringFromDate:(NSDate *)date
{
    int32_t loggerCount = OSAtomicAdd32(0, &atomicLoggerCount);
    
    if (loggerCount <= 1)
    {
        // Single-threaded mode.
        
        if (threadUnsafeDateFormatter == nil)
        {   
            threadUnsafeDateFormatter = [[NSDateFormatter alloc] init];
            NSString *formatString = [NSDateFormatter dateFormatFromTemplate:@"hhmmssSSSEdMMMYYYY" options:0
                                                                      locale:[NSLocale currentLocale]];
            [threadUnsafeDateFormatter setDateFormat:formatString];
        }
        
        return [threadUnsafeDateFormatter stringFromDate:date];
    }
    else
    {
        // Multi-threaded mode.
        // NSDateFormatter is NOT thread-safe.
        
        NSString *key = @"MyCustomFormatter_NSDateFormatter";
        
        NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
        NSDateFormatter *dateFormatter = [threadDictionary objectForKey:key];
        
        if (dateFormatter == nil)
        {
            dateFormatter = [[NSDateFormatter alloc] init];
            NSString *formatString = [NSDateFormatter dateFormatFromTemplate:@"hhmmssSSSEdMMMYYYY" options:0
                                                                      locale:[NSLocale currentLocale]];
            [dateFormatter setDateFormat:formatString];
            
            [threadDictionary setObject:dateFormatter forKey:key];
        }
        
        return [dateFormatter stringFromDate:date];
    }
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    NSString *logLevel;
    switch (logMessage->logFlag)
    {
        case LOG_FLAG_ERROR : logLevel = @"Error:"; break;
        case LOG_FLAG_WARN  : logLevel = @"Warning:"; break;
        case LOG_FLAG_INFO  : logLevel = @"Info:"; break;
        default             : logLevel = @"Verbose:"; break;
    }
    
    NSString *dateAndTime = [self stringFromDate:(logMessage->timestamp)];
    NSString *logMsg = logMessage->logMsg;
    NSString *file = [NSString stringWithCString:logMessage->file encoding:NSASCIIStringEncoding];
    NSString *lineNumber = [NSString stringWithFormat:@"%@", [NSNumber numberWithInt:logMessage->lineNumber]];
    NSString *function = [NSString stringWithCString:logMessage->function encoding:NSASCIIStringEncoding];
    
    return [NSString stringWithFormat:@"%@ %@, file: %@, line %@: %@ | %@\n", logLevel, dateAndTime, file, lineNumber, function, logMsg];
}

- (void)didAddToLogger:(id <DDLogger>)logger
{
    OSAtomicIncrement32(&atomicLoggerCount);
}
- (void)willRemoveFromLogger:(id <DDLogger>)logger
{
    OSAtomicDecrement32(&atomicLoggerCount);
}

@end
