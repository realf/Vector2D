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

@property (retain, nonatomic) IARuleEngine *ruleEngine;
@property (retain, nonatomic) IBOutlet UILabel *screen;
@property (retain, nonatomic) IBOutlet UIButton *theNewGameButton;

@end


@implementation IAViewController

@synthesize screen = _screen;
@synthesize theNewGameButton = _theNewGameButton;
@synthesize ruleEngine = _ruleEngine;

- (IBAction)directionButtonPressed:(UIButton *)sender 
{
    [self.ruleEngine moveAliceToDirection:[sender currentTitle]];
}

- (IBAction)theNewGameButtonPressed:(id)sender
{
    [self.ruleEngine startGame];
}

- (void)objectMoved:(NSNotification *)notification
{
    NSString *moveDescription = [[notification object] intDescription];
    if ([moveDescription isEqual:@"<-1, 0>"])
        self.screen.text = @"Computer goes left";
    if ([moveDescription isEqual:@"<1, 0>"])
        self.screen.text = @"Computer goes right";
    if ([moveDescription isEqual:@"<0, 1>"])
        self.screen.text = @"Computer goes up";
    if ([moveDescription isEqual:@"<0, -1>"])
        self.screen.text = @"Computer goes down";
}

- (void)gameStateChanged:(NSNotification *)notification
{
    self.screen.text = [notification object];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    _ruleEngine = [[IARuleEngine alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(objectMoved:) name:IAObjectMovedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameStateChanged:) name:IAGameStateChangedNotification object:nil];
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
    [_screen release];
    [_ruleEngine release];
    [_theNewGameButton release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
@end
