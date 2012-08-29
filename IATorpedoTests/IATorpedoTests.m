//
//  IATorpedoTests.m
//  IATorpedoTests
//
//  Created by Sergey Dunets on 8/29/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IATorpedoTests.h"
#import "IATorpedo.h"

@implementation IATorpedoTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testInitWithNamePositionSpeed
{
    IATorpedo* test = [[IATorpedo alloc] initWitName:@"Torpedo 1" position:[IAPosition newPositionWithX:1 y:1] speed:[NSNumber numberWithFloat:1.0]];
    STAssertEqualObjects(test.name, @"Torpedo 1", @"Wrong name");
    STAssertEqualObjects(test.position, [IAPosition newPositionWithX:1 y:1], @"Wrong position");
    STAssertEqualObjects(test.speed, [NSNumber numberWithFloat:1.0], @"Wrong speed");
}

@end
