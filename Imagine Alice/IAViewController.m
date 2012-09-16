//
//  IAViewController.m
//  Imagine Alice
//
//  Created by Sergey Dunets on 8/6/12.
//  Copyright (c) 2012 imagine-alice.org. All rights reserved.
//

#import "IAViewController.h"
#import "IARuleEngine.h"
#import "DDLog.h"

#ifdef DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_ERROR;
#endif

@interface IAViewController()

@property (retain, nonatomic) IAAbsolutePosition *alicePosition;
@property (assign, nonatomic) BOOL aliceCanGo;
@property (assign, nonatomic) NSUInteger boardWidth;
@property (assign, nonatomic) NSUInteger boardHeight;
@property (retain, nonatomic) IARuleEngine *ruleEngine;
@property (retain, nonatomic) IBOutlet UILabel *screen;
@property (retain, nonatomic) IBOutlet UIButton *theNewGameButton;

@end


@implementation IAViewController

@synthesize alicePosition = _alicePosition;
@synthesize aliceCanGo = _aliceCanGo;
@synthesize boardWidth = _boardWidth;
@synthesize boardHeight = _boardHeight;
@synthesize screen = _screen;
@synthesize theNewGameButton = _theNewGameButton;
@synthesize ruleEngine = _ruleEngine;

- (IARuleEngine *)ruleEngine
{
    if (nil == _ruleEngine)
    {
        _ruleEngine = [[IARuleEngine alloc] init];
    }
    
    return _ruleEngine;
}

- (IAAbsolutePosition *)alicePosition
{
    if (nil == _alicePosition)
    {
        _alicePosition = [[IAAbsolutePosition alloc] init];
    }
    
    return _alicePosition;
}

- (void)resetGame
{
    self.boardWidth = 3;
    self.boardHeight = 3;
    self.alicePosition.x = self.boardWidth / 2;
    self.alicePosition.y = self.boardHeight / 2;
    [self.screen setText:[NSString stringWithFormat:@"Let's play! Alice is at (%d, %d)", self.alicePosition.x, self.alicePosition.y]];
    DDLogInfo(@"%@", [NSString stringWithFormat:@"Let's play! Alice is at (%d, %d)", self.alicePosition.x, self.alicePosition.y]);
    self.aliceCanGo = YES;
}

- (IBAction)directionButtonPressed:(UIButton *)sender 
{
    if (self.aliceCanGo)
    {
        [self.theNewGameButton setHidden:YES];
        if ([[sender currentTitle] isEqualToString:@"Up"])
            self.alicePosition.y++;
        else if ([[sender currentTitle] isEqualToString:@"Down"])
            self.alicePosition.y--;
        else if ([[sender currentTitle] isEqualToString:@"Right"])
            self.alicePosition.x++;
        else if ([[sender currentTitle] isEqualToString:@"Left"])
            self.alicePosition.x--;
        
        // If Alice is inside the board
        if ([self.ruleEngine isPosition:self.alicePosition insideTheBoardWithWidth:self.boardWidth height:self.boardHeight])
        {
            // Show Alice position 
            // [self.screen setText:[NSString stringWithFormat:@"Alice position is (%d, %d)", self.alicePosition.x, self.alicePosition.y]];
            DDLogInfo(@"%@", [NSString stringWithFormat:@"Alice position is (%d, %d)", self.alicePosition.x, self.alicePosition.y]);
            
            // Let the computer make his move
            IAAbsolutePosition *nextAlicePosition = [self.ruleEngine makeRandomMoveFromPosition:self.alicePosition onTheBoardWithWidth:self.boardWidth height:self.boardHeight];
            [self.screen setText:[NSString stringWithFormat:@"iPhone moves Alice by (%d, %d)", nextAlicePosition.x - self.alicePosition.x, nextAlicePosition.y - self.alicePosition.y]];
            self.alicePosition = nextAlicePosition;             
            DDLogInfo(@"%@", [NSString stringWithFormat:@"iPhone moves Alice to (%d, %d)", self.alicePosition.x, self.alicePosition.y]);
        }
        else
        {
            [self.screen setText:[NSString stringWithFormat:@"Game over! Alice position is (%d, %d)", self.alicePosition.x, self.alicePosition.y]];
            DDLogInfo(@"%@", [NSString stringWithFormat:@"Game over! Alice position is (%d, %d)", self.alicePosition.x, self.alicePosition.y]);
            self.aliceCanGo = NO;
            [self.theNewGameButton setHidden:NO];
        }
    }
}

- (IBAction)theNewGameButtonPressed:(id)sender
{
    [self resetGame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self resetGame];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setScreen:nil];
    [self setTheNewGameButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [_alicePosition release];
    [_screen release];
    [_ruleEngine release];
    [_theNewGameButton release];
    [super dealloc];
}
@end
