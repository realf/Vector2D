//
//  IABoardTests.m
//  IABoardTests
//
//  Created by Sergey Dunets on 8/22/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IABoardTests.h"
#import "IABoard.h"
#import "IAGlobalConstants.h"

@implementation IABoardTests

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
    IABoard *testBoard = [[IABoard alloc] init];
    STAssertNotNil(testBoard, @"testBoard is nil");
    STAssertEquals(testBoard.numCols, 3u, @"Default numCols is wrong");
    STAssertEquals(testBoard.numRows, 3u, @"Default numRows is wrong");
    [testBoard release];
}

- (void)testInitWithNumColsNumRows
{
    IABoard *testBoard = [[IABoard alloc] initWithNumCols:5 numRows:5];
    STAssertNotNil(testBoard, @"testBoard is nil");
    STAssertEquals(testBoard.numCols, 5u, @"Default numCols is wrong");
    STAssertEquals(testBoard.numRows, 5u, @"Default numRows is wrong");
    [testBoard release];
}

- (void)testInitWithMinNumColsNumRows
{
    IABoard *testBoard = [[IABoard alloc] initWithNumCols:3 numRows:3];
    STAssertNotNil(testBoard, @"testBoard is nil");
    STAssertEquals(testBoard.numCols, 3u, @"Default numCols is wrong");
    STAssertEquals(testBoard.numRows, 3u, @"Default numRows is wrong");
    [testBoard release];
}

- (void)testInitWithMaxNumColsNumRows
{
    IABoard *testBoard = [[IABoard alloc] initWithNumCols:10 numRows:10];
    STAssertNotNil(testBoard, @"testBoard is nil");
    STAssertEquals(testBoard.numCols, 10u, @"Default numCols is wrong");
    STAssertEquals(testBoard.numRows, 10u, @"Default numRows is wrong");
    [testBoard release];
}

- (void)testInitWithLargeNumColsNumRows
{
    IABoard *testBoard = [[IABoard alloc] initWithNumCols:11 numRows:11];
    STAssertNotNil(testBoard, @"testBoard is nil");
    STAssertEquals(testBoard.numCols, 3u, @"Default numCols is wrong");
    STAssertEquals(testBoard.numRows, 3u, @"Default numRows is wrong");
    [testBoard release];
}

- (void)testInitWithSmallNumColsNumRows
{
    IABoard *testBoard = [[IABoard alloc] initWithNumCols:2 numRows:2];
    STAssertNotNil(testBoard, @"testBoard is nil");
    STAssertEquals(testBoard.numCols, 3u, @"Default numCols is wrong");
    STAssertEquals(testBoard.numRows, 3u, @"Default numRows is wrong");
    [testBoard release];
}

- (void)testInitWithNegativeNumColsNumRows
{
    IABoard *testBoard = [[IABoard alloc] initWithNumCols:-1 numRows:-1];
    STAssertNotNil(testBoard, @"testBoard is nil");
    STAssertEquals(testBoard.numCols, 3u, @"Default numCols is wrong");
    STAssertEquals(testBoard.numRows, 3u, @"Default numRows is wrong");
    [testBoard release];
}

@end
