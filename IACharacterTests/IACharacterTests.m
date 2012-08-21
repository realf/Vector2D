//
//  IACharacterTests.m
//  IACharacterTests
//
//  Created by Sergey Dunets on 8/22/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IACharacterTests.h"
#import "IACharacter.h"

@implementation IACharacterTests

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
    IACharacter *testCharacter = [[IACharacter alloc] init];
    STAssertNotNil(testCharacter, @"testCharacter is nil");
    STAssertEqualObjects(testCharacter.name, @"Default Name", @"Wrong default name");
    STAssertTrue(testCharacter.position.x == 0 && testCharacter.position.y == 0, @"Wrong default position");
    STAssertTrue(testCharacter.isEnabled, @"Wrong default isEnabled state");
    [testCharacter release];
}

- (void)testInitWithNamePosition
{
    IACharacter *testCharacter = [[IACharacter alloc] initWithName:@"Alice" position:[IAPosition newPositionWithX:1 y:1]];
    STAssertNotNil(testCharacter, @"testCharacter is nil");
    STAssertEqualObjects(testCharacter.name, @"Alice", @"Wrong default name");
    STAssertTrue(testCharacter.position.x == 1 && testCharacter.position.y == 1, @"Wrong default position");
    STAssertTrue(testCharacter.isEnabled, @"Wrong default isEnabled state");
    [testCharacter release];
}

- (void)testMemoryLeaks
{
    IACharacter *testCharacter = [[IACharacter alloc] init];
    STAssertEquals([testCharacter.name retainCount], 1u, @"Wrong retain count");
    STAssertEquals([testCharacter.position retainCount], 1u, @"Wrong retain count");
    [testCharacter release];
}

@end
