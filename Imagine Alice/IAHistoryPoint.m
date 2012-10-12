//
//  IAHistoryPoint.m
//  Imagine Alice
//
//  Created by Sergey Dunets on 9/16/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IAHistoryPoint.h"

@interface IAHistoryPoint()
@property (retain, nonatomic) NSMutableDictionary *historyPoint;
@end

@implementation IAHistoryPoint

@synthesize historyPoint = _historyPoint;

- (NSMutableDictionary *)historyPoint
{
    if (!_historyPoint)
    {
        _historyPoint = [[NSMutableDictionary alloc] init];
    }
    return _historyPoint;
}

- (void)addObjectToHistoryPoint:(id<IAHistoryPointProtocol>)object
{
    if (object)
    {
        [self.historyPoint setObject:[[object copy] autorelease] forKey:[object name]];
    }
}

- (id<IAHistoryPointProtocol, NSCopying>)objectWithName:(NSString *)name
{
    return [self.historyPoint objectForKey:name];
}

- (NSString *)description
{
    NSMutableString *descriptionString = [NSMutableString stringWithString:@""];
    for (NSString *hp in self.historyPoint)
        [descriptionString appendFormat:@"%@\n", self.historyPoint[hp]];
    return descriptionString;
}

-(void)dealloc
{
    [_historyPoint release];
    [super dealloc];
}

@end
