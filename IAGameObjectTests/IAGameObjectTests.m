//
//  IAGameObjectTests.m
//  IAGameObjectTests
//
//  Created by Sergey Dunets on 8/22/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IAGameObjectTests.h"
#import "IAGameObject.h"

@implementation IAGameObjectTests

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

- (void)testInit
{
    IAGameObject *testCharacter = [[IAGameObject alloc] init];
    STAssertNotNil(testCharacter, @"testCharacter is nil");
    STAssertEqualObjects(testCharacter.name, @"Default Name", @"Wrong default name");
    STAssertEqualObjects(testCharacter.position, [IAAbsolutePosition absolutePositionWithX:0.0 y:0.0], @"Wrong default position");
//    STAssertTrue(testCharacter.isEnabled, @"Wrong default isEnabled state");
    [testCharacter release];
}

- (void)testInitWithNamePosition
{
    IAGameObject *testCharacter = [[IAGameObject alloc] initWithName:@"Alice" position:[IAAbsolutePosition absolutePositionWithX:1 y:1]];
    STAssertNotNil(testCharacter, @"testCharacter is nil");
    STAssertEqualObjects(testCharacter.name, @"Alice", @"Wrong default name");
    STAssertEqualObjects(testCharacter.position, [IAAbsolutePosition absolutePositionWithX:1.0 y:1.0], @"Wrong default position");
//    STAssertTrue(testCharacter.isEnabled, @"Wrong default isEnabled state");
    [testCharacter release];
}

- (void)testMemoryLeaks
{
    IAGameObject *testCharacter = [[IAGameObject alloc] init];
    STAssertEquals([testCharacter.name retainCount], 1u, @"Wrong retain count");
    STAssertEquals([testCharacter.position retainCount], 1u, @"Wrong retain count");
    [testCharacter release];
}

@end
