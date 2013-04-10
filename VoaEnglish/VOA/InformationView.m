//
//  InformationView.m
//  FinalTest
//
//  Created by Seven Lee on 12-1-12.
//  Copyright (c) 2012年 iyuba. All rights reserved.
//

#import "InformationView.h"

@implementation InformationView

@synthesize isiPhone;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    isiPhone = ![Constants isPad];
	if (isiPhone) {
        self = [super initWithNibName:@"InformationView" bundle:nibBundleOrNil];
	}else {
        self = [super initWithNibName:@"InformationView-iPad" bundle:nibBundleOrNil];
    }
    if (self) {
        //        NSLog(@"%@",nibNameOrNil);
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)goUrl:(id)sender
{
    if ([self isExistenceNetwork:1]) {
        InforController *myInfor = [[InforController alloc]init];
        [self.navigationController pushViewController:myInfor animated:YES];
        [myInfor release], myInfor = nil;
    }
}
//
//- (BOOL)isPad {
//	BOOL isPad = NO;
//#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
//	isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
//#endif
//	return isPad;
//}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = kInfoOne;
    kNetTest;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL) isExistenceNetwork:(NSInteger)choose
{
	BOOL isExistenceNetwork;
	Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
			isExistenceNetwork=FALSE;
            break;
        case ReachableViaWWAN:
			isExistenceNetwork=TRUE;
            break;
        case ReachableViaWiFi:
			isExistenceNetwork=TRUE;     
            break;
    }
	if (!isExistenceNetwork) {
        UIAlertView *myalert = nil;
        switch (choose) {
            case 0:
                
                break;
            case 1:
                myalert = [[UIAlertView alloc] initWithTitle:kInfoTwo message:kInfoThree delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil,nil];
                [myalert show];
                [myalert release];
                break;
            default:
                break;
        }
	}
	return isExistenceNetwork;
}

@end
