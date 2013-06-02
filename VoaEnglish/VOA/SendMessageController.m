//
//  SendMessageController.m
//  VOA
//
//  Created by zhao song on 13-1-23.
//  Copyright (c) 2013年 buaa. All rights reserved.
//

#import "SendMessageController.h"

@interface SendMessageController ()

@end

@implementation SendMessageController
@synthesize nameLab;
@synthesize messageTv;
@synthesize sendBtn;
@synthesize userMsg; 
@synthesize sucAlert;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([Constants isPad]) {
        [sendBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messageSend-ipad" ofType:@"png"]] forState:UIControlStateNormal];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        kNetTest;
    });
    self.navigationController.navigationBarHidden = NO;
    [nameLab setText:[NSString stringWithFormat:@"%@\"%@\"", kSendTwo,userMsg.toUserName]];
}

- (void)viewDidUnload {
    self.nameLab = nil;
    self.messageTv = nil;
    self.sendBtn = nil;
    [userMsg release], userMsg = nil;
    [super viewDidUnload];
}

- (void)dealloc {
    [nameLab release];
    [messageTv release];
    [sendBtn release];
    [userMsg release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)c
{
    [sucAlert dismissWithClickedButtonIndex:0 animated:YES];
    [sucAlert release];
}

#pragma mark - Http connect
- (IBAction)sendComments:(UIButton *) sender{
    if ([messageTv.text length] != 0) {
        NSInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"nowUser"];
        //    NSLog(@"$$$:%d", uid);
        if (uid>0) {
            NSString *imgSrc = [NSString stringWithFormat:@"http://voa.iyuba.com/iyubaApi/account/image.jsp?uid=%d&size=small", userMsg.fromUserId];
            NSString *url = [NSString stringWithFormat:@"http://apps.iyuba.com/voa/updateMail.jsp?userId=%i&groupName=Iyuba&userName=%@&imgSrc=%@&toGroupName=Iyuba&toUserId=%i&comment=%@&mod=insert&topicId=%i",userMsg.fromUserId, userMsg.fromUserName, imgSrc, userMsg.toUserId, [messageTv.text URLEncodedString], userMsg.topicId];
            [sendBtn setUserInteractionEnabled:YES];
//            NSLog(@"sendurl :%@", url);
            //        ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
            ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
            request.delegate = self;
            [request setUsername:@"sendMsg"];
            [request startAsynchronous];
        } else {
            LogController *myLog = [[LogController alloc]init];
            [self.navigationController  pushViewController:myLog animated:YES];
            
            //        id nextResponder = [self.view nextResponder];
            //        UIView *test = [[UIView alloc] init];
            //        tes
            //        [[(UIView *)self.view firstViewController:self.view] presentModalViewController:myLog animated:YES];
            [myLog release];
            //        PlayViewController *player = [PlayViewController sharedPlayer];
            //        [player.navigationController pushViewController:myLog animated:YES];
        }
    } else {
        
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        kNetTest;
    });
    if([request.username isEqualToString:@"sendMsg"]) {
        [sendBtn setUserInteractionEnabled:YES];
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:kColFour message:kNewSix delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    kNetEnable;
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];
    if ([request.username isEqualToString:@"sendMsg"]) {
        [sendBtn setUserInteractionEnabled:YES];
        NSArray *items = [doc nodesForXPath:@"response" error:nil];
        if (items) {
            for (DDXMLElement *obj in items) {
                int result = [[[obj elementForName:@"result"] stringValue] integerValue] ;
                if (result == 1) {
                    sucAlert = [[UIAlertView alloc] initWithTitle:kSendOne message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    
                    [sucAlert setBackgroundColor:[UIColor clearColor]];
                    
                    [sucAlert setContentMode:UIViewContentModeScaleAspectFit];
                    
                    [sucAlert show];
                    
                    //            UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                    //
                    //            active.center = CGPointMake(alert.bounds.size.width/2, alert.bounds.size.height-40);
                    //
                    //            [alert addSubview:active];
                    //
                    //            [active startAnimating];
                    
                    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(c) userInfo:nil repeats:NO];
                } else {
                    NSString *msg = [[obj elementForName:@"msg"] stringValue] ;
                    //                NSLog(@"msg:%@",msg);
                    UIAlertView * alertOne = [[UIAlertView alloc] initWithTitle:kFeedbackThree message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alertOne show];
                    [alertOne release];
                }
            }
        }
    }
    [doc release], doc = nil;
}

@end
