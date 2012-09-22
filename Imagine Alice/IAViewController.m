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

//@property (retain, nonatomic) IAAbsolutePosition *alicePosition;
//@property (assign, nonatomic) BOOL aliceCanGo;
//@property (assign, nonatomic) NSUInteger boardWidth;
//@property (assign, nonatomic) NSUInteger boardHeight;
@property (retain, nonatomic) IARuleEngine *ruleEngine;
@property (retain, nonatomic) IBOutlet UILabel *screen;
@property (retain, nonatomic) IBOutlet UIButton *theNewGameButton;

@end


@implementation IAViewController

//@synthesize alicePosition = _alicePosition;
//@synthesize aliceCanGo = _aliceCanGo;
//@synthesize boardWidth = _boardWidth;
//@synthesize boardHeight = _boardHeight;
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

- (IBAction)directionButtonPressed:(UIButton *)sender 
{
    [self.ruleEngine moveAliceToDirection:[sender currentTitle]];
}

- (IBAction)theNewGameButtonPressed:(id)sender
{
    if (self.ruleEngine)
        [self.ruleEngine release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    //[self.ruleEngine release];
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
//    [_alicePosition release];
    [_screen release];
    [_ruleEngine release];
    [_theNewGameButton release];
    [super dealloc];
}
@end
