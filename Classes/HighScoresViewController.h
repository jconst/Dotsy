//
//  HighScoresViewController.h
//  EvaDots
//
//  Created by Joseph Constan on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "EvaDotsViewController.h"


@interface HighScoresViewController : UIViewController {
	EvaDotsViewController *delegate;
}
@property (nonatomic, retain) IBOutlet EvaDotsViewController *delegate;

- (IBAction) dismissView;

@end
