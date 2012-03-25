//
//  EvaDotsViewController.h
//  EvaDots
//
//  Created by Joseph Constan on 3/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "GameViewController.h"
#import "EvaDotsAppDelegate.h"
#import "AboutViewController.h"
#import "HighScoresViewController.h"
#import "SettingsViewController.h"
#import "GameCenterManager.h"
#import "GameViewController.h"

#define kStandardLeaderboard @"DotsyHS100"

@class GameViewController;

@interface EvaDotsViewController : UIViewController <GameCenterManagerDelegate, GKLeaderboardViewControllerDelegate, ADBannerViewDelegate> {

	GameCenterManager *gcManager;
	GameViewController *gvController;
}
@property (nonatomic, retain) GameCenterManager *gcManager;
@property (nonatomic, retain) IBOutlet ADBannerView *adBanner;

- (IBAction) dismissMVC;

- (IBAction) startButtonPressed;
- (IBAction) aboutButtonPressed;
- (IBAction) settingsButtonPressed;
- (IBAction) highScoresButtonPressed;

@end

