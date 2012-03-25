//
//  AboutViewController.h
//  EvaDots
//
//  Created by Joseph Constan on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "EvaDotsViewController.h"

@class EvaDotsViewController;

@interface AboutViewController : UIViewController <MFMailComposeViewControllerDelegate> {
	EvaDotsViewController *delegate;
}
@property (nonatomic, retain) IBOutlet EvaDotsViewController *delegate;

- (IBAction) contactUsPressed;
- (IBAction) showCodevsHomepage;
- (IBAction) showCollinsHomepage;
- (IBAction) dismissView;
@end
