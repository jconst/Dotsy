//
//  GameViewController.m
//  EvaDots
//
//  Created by Joseph Constan on 3/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"

#define kMenuButtonFrame CGRectMake(248, 3, 72, 37)
#define kMenuButtonOffscreenFrame CGRectMake(320, 3, 72, 37)
#define kArrowViewFrame CGRectMake(277, 10, 23, 23)
#define kArrowViewShiftedFrame CGRectMake(220, 10, 23, 23)
#define IN YES
#define OUT NO

@implementation GameViewController

@synthesize evaDotsViewController, scoreLabel, arrowView, pauseButton, gameRunning, menuButton, dots;

- (void) showAlertWithTitle: (NSString*) title message: (NSString*) message
{
	UIAlertView* alert= [[[UIAlertView alloc] initWithTitle: title message: message 
												   delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL] autorelease];
	[alert show];
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if ((gameRunning && canSpawn && [[touches anyObject] locationInView:self.view].y > 40) ||
		([dots count] <= 0)) {
		
		//create array of dot colors to pick from randomly
		NSArray *dotColors = [[NSArray alloc] initWithObjects:@"GreenDot.png", 
															  @"BlueDot.png", 
															  @"PurpleDot.png", 
															  @"OrangeDot.png", 
															  @"YellowDot.png", nil];
		NSUInteger rnum = arc4random() % 5;
		
		UIImageView *dot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[dotColors objectAtIndex:rnum]]];
		dot.center = [[touches anyObject] locationInView:self.view];
		[self.view insertSubview:dot atIndex:1];
		[dots addObject:dot];
		[dot release];
		[directions addObject:[NSNumber numberWithUnsignedInt:arrowDirection]];
	
		[self incrementScore];
	
		arrowDirection = arc4random() % 4;
		arrowView.transform = CGAffineTransformMakeRotation((M_PI/2) * arrowDirection);
		
		canSpawn = NO;
		spawnTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerFired:) userInfo:nil repeats:NO];
		
		[dotColors release];
	}
}

- (void)incrementScore {
	score += 100;
	scoreLabel.text = [NSString stringWithFormat:@"Score: %d", score];
	if (score % 500 == 0) {
		dotSpeed += 2;
	}
	else if (score == 100) {
		[self slideMenuButton:OUT];
	}
}

- (void)timerFired:(NSTimer *)timer {
	canSpawn = YES;
}

- (void)moveDots {
	for (int i = 0; i < [dots count]; i++) {
		UIImageView *dot = [dots objectAtIndex:i];
		ArrowDirection dir = [[directions objectAtIndex:i] unsignedIntValue];
		
		//NSUInteger radius = dot.frame.size.width / 2;
		float yrate = (self.view.frame.size.height) / 40.0;
		float xrate = (self.view.frame.size.width) / 40.0;
		
		CGPoint lastCenter = dot.center;
		CGPoint newCenter = CGPointMake(lastCenter.x + cos((M_PI/2)*(dir))*xrate, lastCenter.y + sin((M_PI/2)*(dir))*yrate);
		BOOL didChangeSides = NO;
		
		if (newCenter.x > self.view.frame.size.width) {
			newCenter.x -= self.view.frame.size.width; //+ radius;
			didChangeSides = YES;
		} else if (newCenter.x < 0) {
			newCenter.x += self.view.frame.size.width; //+ radius;
			didChangeSides = YES;
		}
		if (newCenter.y > self.view.frame.size.height) {
			newCenter.y -= self.view.frame.size.height; //+ radius;
			didChangeSides = YES;
		} else if (newCenter.y < 20) {
			newCenter.y += self.view.frame.size.height;// + radius;
			didChangeSides = YES;
		}
		if (didChangeSides) {
			dot.center = newCenter;
		} else {
			[UIView beginAnimations:@"MoveDot" context:nil];
			[UIView setAnimationDuration:1/dotSpeed];
			[UIView setAnimationCurve:UIViewAnimationCurveLinear];
			dot.center = newCenter;
			[UIView commitAnimations];
		}
	}
}

- (IBAction)menuButtonPressed {
	[evaDotsViewController dismissMVC];
}

- (IBAction)pauseOrPlay {
	if (gameRunning && [dots count] <= 0)
		return;
	if (gameRunning) {
		[pauseButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
	} else {
		[pauseButton setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
	}
	[self slideMenuButton:gameRunning];
	gameRunning = !gameRunning;
}

- (void)slideMenuButton:(BOOL)inOrOut {
	//in = YES, out = NO
	menuButton.frame = inOrOut ? kMenuButtonOffscreenFrame : kMenuButtonFrame;
	menuButton.hidden = NO;
	[UIView beginAnimations:@"slideMenuButton" context:nil];
	[UIView setAnimationDuration:0.4];
	arrowView.frame = inOrOut ? kArrowViewShiftedFrame : kArrowViewFrame;
	menuButton.frame = inOrOut ? kMenuButtonFrame : kMenuButtonOffscreenFrame;
	[UIView commitAnimations];
}

- (void)checkCollisions {
	for (int i = 0; i < [dots count]; i++) {
		for (int j = 0; j < [dots count]; j++) {
			if (CGRectIntersectsRect([[dots objectAtIndex:i] frame], [[dots objectAtIndex:j] frame]) &&
				[dots objectAtIndex:i] != [dots objectAtIndex:j] &&
				gameRunning) {
				gameRunning = NO;
				
				[[dots objectAtIndex:i] setImage:[UIImage imageNamed:@"RedDot.png"]];
				[[dots objectAtIndex:j] setImage:[UIImage imageNamed:@"RedDot.png"]];
				
				NSInteger highScore;
				if (score > [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScore"])
					highScore = score;
				else
					highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScore"];
				[[NSUserDefaults standardUserDefaults] setInteger:highScore forKey:@"HighScore"];

				UIAlertView *gameOverAlert = [[UIAlertView alloc] initWithTitle:@"Game Over" 
																		message:[NSString stringWithFormat:@"Score: %d", score]
																	   delegate:self 
															  cancelButtonTitle:@"Restart" 
															  otherButtonTitles:@"Submit Score", nil];
				gameOverAlert.delegate = self;
				[gameOverAlert show];
				[gameOverAlert release];
			}
		}
	}
}

- (void)gameLoop {
	if (gameRunning) {
		[self moveDots];
		[self checkCollisions];
	}
}

- (void)restartGame {
	for (int i = 0; i < [dots count]; i++) {
		[[dots objectAtIndex:i] removeFromSuperview];
	}
	[dots removeAllObjects];
	[directions removeAllObjects];
	
	arrowDirection = rand() % 4;
	arrowView.transform = CGAffineTransformMakeRotation((M_PI/2) * arrowDirection);

	score = 0;
    dotSpeed = 20;
	scoreLabel.text = [NSString stringWithFormat:@"Score: %d", score];
	gameRunning = YES;
	[self slideMenuButton:IN];
}

- (void) scoreReported: (NSError*) error;
{
	if(error == NULL)
	{
		[evaDotsViewController.gcManager reloadHighScoresForCategory:kStandardLeaderboard];
		[self showAlertWithTitle: @"High Score Reported!"
						 message: [NSString stringWithFormat: @"", [error localizedDescription]]];
	}
	else
	{
		[self showAlertWithTitle: @"Score Report Failed!"
						 message: [NSString stringWithFormat: @"Reason: %@", [error localizedDescription]]];
	}
}

#pragma mark -
#pragma mark UIAlertView Delegate Method

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if ([alertView.title isEqualToString:@"Game Over"]) {
		if (buttonIndex == 1)
			[evaDotsViewController.gcManager reportScore:score forCategory:kStandardLeaderboard];
		[self restartGame];
	}
}

#pragma mark -
#pragma mark View Lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	evaDotsViewController.gcManager.delegate = self;
	
	canSpawn = YES;
	dots = [[NSMutableArray alloc] init];
	directions = [[NSMutableArray alloc] init];
	dotSpeed = 20;
	
	gameRunning = YES;
	[NSTimer scheduledTimerWithTimeInterval:1/dotSpeed target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
	arrowDirection = arc4random() % 4;
	arrowView.transform = CGAffineTransformMakeRotation((M_PI/2) * arrowDirection);
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return NO;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.arrowView = nil;
	self.pauseButton = nil;
	self.scoreLabel = nil;
}


- (void)dealloc {
	//initialized objects
	[dots release];
	[directions release];
	
    [super dealloc];
}


@end
