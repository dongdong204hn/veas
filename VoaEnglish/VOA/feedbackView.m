//
//  feedbackView.m
//  FinalTest
//
//  Created by Seven Lee on 12-2-1.
//  Copyright (c) 2012年 iyuba. All rights reserved.
//

#import "feedbackView.h"

@implementation feedbackView

@synthesize feedback = _feedback;
@synthesize mail =  _mail;
@synthesize alert = _alert;
@synthesize isiPhone;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = kFeedbackOne;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
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

- (void)viewWillAppear:(BOOL)animated
{
    kNetTest;
    NSInteger nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    if (nowUserId > 0) {
        [_mail setHidden:YES];
    }
    else
    {
        [_mail setHidden:NO];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isiPhone = ![Constants isPad];
    if (!isiPhone) {
        [self.view setFrame:CGRectMake(0, 0, 768, 1024)];
        [self.feedback setFrame:CGRectMake(104, 20, 560, 250)];
        [self.mail setFrame:CGRectMake(104, 300, 560, 160)];
    }
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem * sendButton = [[UIBarButtonItem alloc] initWithTitle:kFeedbacksix style:UIBarButtonItemStyleBordered target:self action:@selector(sendFeedback)];
    self.navigationItem.rightBarButtonItem = sendButton;
    [sendButton release], sendButton = nil;
    [_feedback becomeFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.feedback = nil;
    self.mail = nil;
}

- (void)dealloc
{
    [self.feedback release], _feedback = nil;
    [self.mail release], _mail = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - http connect

- (void)sendFeedback{
    if ([self isExistenceNetwork]) {
        ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://api.iyuba.com/mobile/ios/voa/feedback.xml"]];
        request.delegate = self;
        NSInteger nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
        NSString * decodedText = [[NSString alloc] initWithUTF8String:[_feedback.text UTF8String]];
        if (nowUserId > 0) {
            [request setPostValue:[NSString stringWithFormat:@"%d",nowUserId] forKey:@"uid"];
        }
        else
        {
            [request setPostValue:_mail.text forKey:@"email"];
        }
        [request setPostValue:decodedText forKey:@"content"];
        [decodedText release];
        [request startAsynchronous];
    }
}

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders{
    if ([request responseStatusCode] >= 400) {
        UIAlertView *alertOne = [[UIAlertView alloc] initWithTitle:kSearchEleven message:[NSString stringWithFormat:@"%@,%@",kSearchEleven,kSearchTwelve] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertOne show];
        [alertOne release];
    }
//    NSLog(@"httpCode:%d",[request responseStatusCode]);
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];
    /////解析
    NSArray *items = [doc nodesForXPath:@"response" error:nil];
    if (items) {
        for (DDXMLElement *obj in items) {
            NSString *status = [[obj elementForName:@"status"] stringValue];
//            NSLog(@"status:%@",status);
            if ([status isEqualToString:@"OK"]) {
//                NSLog(@"反馈成功");
                _alert = [[UIAlertView alloc] initWithTitle:kFeedbackTwo message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                
                [_alert setBackgroundColor:[UIColor clearColor]];
                
                [_alert setContentMode:UIViewContentModeScaleAspectFit];
                
                [_alert show];
                
                //            UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                //            
                //            active.center = CGPointMake(alert.bounds.size.width/2, alert.bounds.size.height-40);
                //            
                //            [alert addSubview:active];
                //            
                //            [active startAnimating];
                
                NSTimer *timer = nil;
                timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(c) userInfo:nil repeats:NO];
            }else
            {
//                NSLog(@"反馈失败");
                NSString *msg = [[obj elementForName:@"msg"] stringValue] ;
//                NSLog(@"msg:%@",msg);
                UIAlertView * alertOne = [[UIAlertView alloc] initWithTitle:kFeedbackThree message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertOne show];
                [alertOne release];
            }
        }
    }    
    [doc release],doc = nil;
}

/**
 *  对网路情况进行判断，若无网络弹出提示框
 */
-(BOOL) isExistenceNetwork
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
        myalert = [[UIAlertView alloc] initWithTitle:kFeedbackThree message:kFeedbackFour delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil,nil];
        [myalert show];
        [myalert release];    
	}
	return isExistenceNetwork;
}

-(void)c
{
    [_alert dismissWithClickedButtonIndex:0 animated:YES];
    [_alert release];
}


#pragma mark - UiTextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [textView setText:@""];
    return YES;
}

@end
