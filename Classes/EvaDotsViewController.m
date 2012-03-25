//
//  EvaDotsViewController.m
//  EvaDots
//
//  Created by Joseph Constan on 3/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EvaDotsViewController.h"

@implementation EvaDotsViewController

@synthesize gcManager, adBanner;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	if ([GameCenterManager isGameCenterAvailable]) {
		gcManager = [[GameCenterManager alloc] init];
		gcManager.delegate = self;
		[gcManager authenticateLocalUser];
	} else {
		gcManager = nil;
	}

}

- (IBAction)dismissMVC {
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)startButtonPressed {
	EvaDotsAppDelegate *delegate = (EvaDotsAppDelegate *)[[UIApplication sharedApplication] delegate];
	if (!gvController) {
		gvController = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil];
		gvController.evaDotsViewController = self;
		delegate.gvc = gvController;
	}
	if (!gvController.gameRunning && [gvController.dots count] <= 0) {
		[gvController pauseOrPlay];
	}
	[self presentModalViewController:gvController animated:YES];
}

- (IBAction)aboutButtonPressed {
	AboutViewController *aboutController = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
	aboutController.delegate = self;
	[self presentModalViewController:aboutController animated:YES];
	[aboutController release];
}

- (IBAction)settingsButtonPressed {
	SettingsViewController *settingsController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
	settingsController.delegate = self;
	[self presentModalViewController:settingsController animated:YES];
	[settingsController release];
}

- (IBAction)highScoresButtonPressed {
	if ([GameCenterManager isGameCenterAvailable]) {
		GKLeaderboardViewController *hsController = [[GKLeaderboardViewController alloc] init];
		hsController.category = kStandardLeaderboard;
		hsController.timeScope = GKLeaderboardTimeScopeAllTime;
		hsController.leaderboardDelegate = self;
		[self presentModalViewController:hsController animated:YES];
	} else {
		UIAlertView* alert= [[[UIAlertView alloc] initWithTitle:@"Game Center Required" message:@"You must enable game center functionality to view leaderboards." 
													   delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL] autorelease];
		[alert show];
	}
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController {
	[self dismissModalViewControllerAnimated:YES];
	[viewController release];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait) ||
    (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    
    self.adBanner = nil;
    self.gcManager = nil;
    
    [super dealloc];
}

@end
