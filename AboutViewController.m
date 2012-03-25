//
//  AboutViewController.m
//  EvaDots
//
//  Created by Joseph Constan on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"


@implementation AboutViewController

@synthesize delegate;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (IBAction)showCodevsHomepage {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://codevs.com/"]];
}

- (IBAction)showCollinsHomepage {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.zacktheweb.com/"]];
}

- (IBAction)contactUsPressed {
	if ([MFMailComposeViewController canSendMail]) {
		MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
		[mailViewController setToRecipients:[NSArray arrayWithObjects:@"jcon5294@gmail.com", @"zeepage@gmail.com", nil]];
		[mailViewController setSubject:@"Dotsy"];
		mailViewController.mailComposeDelegate = self;
		[self presentModalViewController:mailViewController animated:YES];
	}
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self dismissModalViewControllerAnimated:YES];
	[controller release];
}

- (IBAction) dismissView {
	[delegate dismissMVC];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
