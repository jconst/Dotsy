//
//  EvaDotsAppDelegate.h
//  EvaDots
//
//  Created by Joseph Constan on 3/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewController.h"

@class EvaDotsViewController, GameViewController;

@interface EvaDotsAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    EvaDotsViewController *viewController;
	GameViewController *gvc;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet EvaDotsViewController *viewController;
@property (nonatomic, retain) GameViewController *gvc;

@end

