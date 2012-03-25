//
//  GameViewController.h
//  EvaDots
//
//  Created by Joseph Constan on 3/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EvaDotsViewController.h"
#import "GameCenterManager.h"

@class EvaDotsViewController;

typedef enum {
	ArrowDirectionRight = 0,
	ArrowDirectionUp,
	ArrowDirectionLeft,
	ArrowDirectionDown
} ArrowDirection;

@interface GameViewController : UIViewController <UIAlertViewDelegate, GameCenterManagerDelegate> {
	
	EvaDotsViewController *evaDotsViewController;
	
	ArrowDirection arrowDirection;
	BOOL gameRunning;
	NSUInteger score;
	float dotSpeed;
	
	NSMutableArray *dots;
	NSMutableArray *directions;
	
	NSTimer *spawnTimer;
	BOOL canSpawn;
	
	UIImageView *arrowView;
	UILabel *scoreLabel;
	UIButton *pauseButton;
	UIButton *menuButton;
}
@property (nonatomic, retain) EvaDotsViewController *evaDotsViewController;
@property (nonatomic, retain) NSMutableArray *dots;
@property (nonatomic, retain) IBOutlet UILabel *scoreLabel;
@property (nonatomic, retain) IBOutlet UIImageView *arrowView;
@property (nonatomic, retain) IBOutlet UIButton *pauseButton;
@property (nonatomic, retain) IBOutlet UIButton *menuButton;
@property (nonatomic) BOOL gameRunning;

- (void)slideMenuButton:(BOOL)inOrOut;
- (void) showAlertWithTitle: (NSString*) title message: (NSString*) message;
- (void) scoreReported: (NSError*) error;
- (void)incrementScore;
- (IBAction)menuButtonPressed;
- (IBAction)pauseOrPlay;
- (void)timerFired:(NSTimer *)timer;
- (void)moveDots;
- (void)checkCollisions;
- (void)restartGame;
- (void)gameLoop;
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
