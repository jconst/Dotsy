//
//  SettingsViewController.h
//  EvaDots
//
//  Created by Joseph Constan on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EvaDotsViewController.h"


@interface SettingsViewController : UIViewController {
	EvaDotsViewController *delegate;
}
@property (nonatomic, retain) IBOutlet EvaDotsViewController *delegate;

- (IBAction) dismissView;

@end
