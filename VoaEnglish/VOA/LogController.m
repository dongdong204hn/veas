//
//  LogViewController.m
//  VOA
//
//  Created by song zhao on 12-3-14.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "LogController.h"
//#import "Constants.h"

@implementation LogController
@synthesize logTable;
@synthesize registBtnTwo;
@synthesize nowUser;
@synthesize logBtnTwo;
@synthesize logOutBtn;
@synthesize remCode;
@synthesize remCodeL;
@synthesize afterLog;
@synthesize yubNumBtn;
@synthesize yubBtn;
@synthesize userF;
@synthesize userL;
@synthesize codeF;
@synthesize codeL;
@synthesize isiPhone;
@synthesize userImg;
//@synthesize isExisitNet;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    isiPhone = ![Constants isPad];
    //    NSLog(@"%@");
	if (isiPhone) {
        self = [super initWithNibName:@"LogController" bundle:nibBundleOrNil];
	}else {
        self = [super initWithNibName:@"LogController-iPad" bundle:nibBundleOrNil];
    }
    if (self) {
        //        NSLog(@"%@",nibNameOrNil);
        
    }
    return self;
}

- (id)init
{
    return [self initWithNibName:@"LogController" bundle:nil];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

//- (BOOL)isPad {
//	BOOL isPad = NO;
//#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
//	isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
//#endif
//	return isPad;
//}


#pragma mark - My action
- (IBAction) doRem:(UIButton *)sender{
    NSInteger rem = [[[NSUserDefaults standardUserDefaults] objectForKey:@"remCode"] integerValue];
    if (rem==1) {
        [remCode setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"rememCodeNot" ofType:@"png"]] forState:0];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:0] forKey:@"remCode"];
    }else
    {
        [remCode setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"rememCode" ofType:@"png"]] forState:0];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"remCode"];
    }
}

- (IBAction) doRegist:(UIButton *)sender
{
    //    [self catchNetA];
    //    if ([self isExistenceNetwork:1]) {
    RegistViewController *myRegist = [[RegistViewController  alloc]init];
    [self.navigationController pushViewController:myRegist animated:YES];
    //        [self presentModalViewController:myRegist animated:YES];
    [myRegist release], myRegist = nil;
    //    }
}

- (IBAction) doCatchYub:(UIButton *)sender {
    int nowUserID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    //    NSLog(@"yub:%d",nowUserID);
    if ([self isExistenceNetwork:1]&& (nowUserID > 0)) {
        [self catchYub:[NSString stringWithFormat:@"%d",nowUserID]];
    }
}

- (IBAction) doLog:(UIButton *)sender
{
    //    NSString *code =[MyUser findCodeByName:[userF text]];
    //    if ([code isEqualToString:[codeF text]]) {
    ////        NSLog(@"本地已有");
    //        int userId = [MyUser findIdByName:[userF text]];
    //        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:userId] forKey:@"nowUser"];
    //        [self catchYub:[NSString stringWithFormat:@"%d",userId]];
    //        [userF resignFirstResponder];
    //        [codeF resignFirstResponder];
    //        [nowUser setText:[NSString stringWithFormat:@"%@%@",kLogOne,userF.text]];
    //        [userImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://voa.iyuba.com/iyubaApi/account/image.jsp?uid=%d", userId]] placeholderImage:[UIImage imageNamed:@"acquiesceBBC.png"]];
    //        [userImg setHidden:NO];
    //        [nowUser setHidden:NO];
    //        [afterLog setHidden:NO];
    //        [logOutBtn setHidden:NO];
    //        [yubBtn setHidden:NO];
    //        [yubNumBtn setHidden:NO];
    //        [logBtnTwo setHidden:YES];
    //        [logTable setHidden:YES];
    //        [remCodeL setHidden:YES];
    //        [remCode setHidden:YES];
    //
    //        NSInteger rem = [[[NSUserDefaults standardUserDefaults] objectForKey:@"remCode"] integerValue];
    //        if (rem==1) {
    //            [MyUser acceptRem:userF.text];
    //        }else
    //        {
    //            [MyUser cancelRem:userF.text];
    //        }
    //
    //        alert = [[UIAlertView alloc] initWithTitle:kLogTwo message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    //
    //        [alert setBackgroundColor:[UIColor clearColor]];
    //
    //        [alert setContentMode:UIViewContentModeScaleAspectFit];
    //
    //        [alert show];
    //
    //        UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //
    //        active.center = CGPointMake(alert.bounds.size.width/2, alert.bounds.size.height-40);
    //
    //        [alert addSubview:active];
    //
    //        [active startAnimating];
    //
    //        [active release];
    //
    //        NSTimer *timer = nil;
    //        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(c) userInfo:nil repeats:NO];
    //    }else
    //    {
    //        NSLog(@"联网登录");
    if ([self isExistenceNetwork:1] && userF.text.length > 0 && codeF.text.length > 0 && userF.textColor == [UIColor blackColor] && codeF.textColor == [UIColor blackColor]) {
        [userF resignFirstResponder];
        [codeF resignFirstResponder];
        [self catchLogs];
    }
    //    }
    
    
    
}

- (IBAction) doLogout:(UIButton *)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:0] forKey:@"nowUser"];
    [nowUser setHidden:YES];
    [userImg setHidden:YES];
    [afterLog setHidden:YES];
    [logOutBtn setHidden:YES];
    [yubBtn setHidden:YES];
    [yubNumBtn setHidden:YES];
    [logBtnTwo setHidden:NO];
    [logTable setHidden:NO];
    [remCodeL setHidden:NO];
    [remCode setHidden:NO];
    [userF setText:@""];
    [codeF setText:@""];
//    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:kBePro];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isVip"];
}


#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    //    [self catchNetA];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        kNetTest;
    });
    self.navigationController.navigationBarHidden = NO;
    
    NSInteger userId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    //    NSLog(@"生词本添加用户：%d",userId);
    if (userId>0) {
        [nowUser setHidden:NO];
        [userImg setHidden:NO];
        [afterLog setHidden:NO];
        [nowUser setText:[NSString stringWithFormat:@"%@%@",kLogOne,[MyUser findNameById:userId]]];
        //        [userImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://voa.iyuba.com/iyubaApi/account/image.jsp?uid=%d", userId]] placeholderImage:[UIImage imageNamed:@"acquiesceBBC.png"]];
        NSString *photoPath=[NSString stringWithFormat:@"http://apis.iyuba.com/account/image.jsp?uid=%d&size=small",userId];
        NSURL *url = [NSURL URLWithString:photoPath];
        [userImg setImageWithURL:url placeholderImage:[UIImage imageNamed:@"acquiesceBBC.png"]];
        [userImg setHidden:NO];
        [logOutBtn setHidden:NO];
        [yubNumBtn setHidden:NO];
        [yubBtn  setHidden:NO];
        [logBtnTwo setHidden:YES];
        [logTable setHidden:YES];
        [remCodeL setHidden:YES];
        [remCode setHidden:YES];
    }
    else
    {
        [userImg setHidden:YES];
        [nowUser setHidden:YES];
        [afterLog setHidden:YES];
        [yubNumBtn setHidden:YES];
        [yubBtn  setHidden:YES];
        [logBtnTwo setHidden:NO];
        [logTable setHidden:NO];
        [remCodeL setHidden:NO];
        [remCode setHidden:NO];
        [logOutBtn setHidden:YES];
    }
    int nowUserID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    //    NSLog(@"yub:%d",nowUserID);
    if (nowUserID > 0) {
        [self catchYub:[NSString stringWithFormat:@"%d",nowUserID]];
    }
}

- (void)viewDidLoad
{
    [self.navigationItem setTitle:kLogFour];
    //    [userImg setImageWithURL:url placeholderImage:[UIImage imageNamed:@"acquiesceBBC.png"]];
    //    isExisitNet = NO;
    NSInteger rem = [[[NSUserDefaults standardUserDefaults] objectForKey:@"remCode"] integerValue];
    if (rem==1) {
        [remCode setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"rememCode" ofType:@"png"]] forState:0];
    }else
    {
        [remCode setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"rememCodeNot" ofType:@"png"]] forState:0];
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.logTable = nil;
    self.registBtnTwo = nil;
    self.logBtnTwo = nil;
    self.logOutBtn = nil;
    self.nowUser = nil;
    self.remCode = nil;
    self.remCodeL = nil;
    self.yubBtn = nil;
    self.yubNumBtn = nil;
    self.afterLog = nil;
    self.userImg = nil;
    [userL release], userL = nil;
    [codeL release], codeL = nil;
    [userF release], userF = nil;
    [codeF release], codeF = nil;
}
*/
 
- (void) dealloc
{
    logTable.dataSource = nil;
    logTable.delegate = nil;
    [logTable release];
    [registBtnTwo release];
    [logBtnTwo release];
    [logOutBtn release];
    [nowUser release];
    [remCode release];
    [remCodeL release];
    [yubBtn release];
    [yubNumBtn release];
    [afterLog release];
    [userImg release];
//    [userL release];
//    [codeL release];
//    [userF release];
//    [codeF release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma mark Table Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView //明确cell数目
 numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    NSString *identifier = [NSString stringWithFormat:@"LogCell%d",[indexPath row]];
    cell = [logTable dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        //        cell = [[UITableViewCell alloc]init];
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] autorelease];
        //        UIImageView *backgroundView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
        //        UIImageView *lineView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 39, 300, 1)];
        
        switch ([indexPath row]) {
            case 0:
                //                [backgroundView setImage:[UIImage imageNamed:@"cellBgOne.png"]];
                //                [cell addSubview:backgroundView];
                //                [cell sendSubviewToBack:backgroundView];
                //                [backgroundView release];
                //                [lineView setImage:[UIImage imageNamed:@"lineSep.png"]];
                //                [cell addSubview:lineView];
                //                [cell sendSubviewToBack:lineView];
                //                [lineView release];
                if (isiPhone) {
                    userL = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 60, 30)];
                    [userL setFont:[UIFont fontWithName:@"Arial" size:18]];
                    
                } else {
                    userL = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 60)];
                    [userL setFont:[UIFont fontWithName:@"Arial" size:30]];
                }
                [userL setBackgroundColor:[UIColor clearColor]];
                [userL setTextAlignment:UITextAlignmentLeft];
                [userL setText:kLogFive];
                [userL setTextColor:[UIColor colorWithRed:41.0/255 green:80.0/255 blue:145.0/255 alpha:1]];
                [cell addSubview:userL];
                [userL release];
                
                if (isiPhone) {
                    userF = [[UITextField alloc]initWithFrame:CGRectMake(90, 5, 220, 30)];
                    [userF setFont:[UIFont fontWithName:@"Arial" size:18]];
                } else {
                    userF = [[UITextField alloc]initWithFrame:CGRectMake(150, 10, 418, 60)];
                    [userF setFont:[UIFont fontWithName:@"Arial" size:30]];
                }
                
                [userF setBackgroundColor:[UIColor whiteColor]];
                [userF setTextAlignment:UITextAlignmentLeft];
                [userF setPlaceholder:kLogSix];
                [codeF setTag:0];
                userF.autocapitalizationType = UITextAutocapitalizationTypeNone;
                [userF setDelegate:self];
                [cell addSubview:userF];
                [userF release];
                break;
            case 1:
                //                [backgroundView setImage:[UIImage imageNamed:@"cellBgLast.png"]];
                //                [cell addSubview:backgroundView];
                //                [cell sendSubviewToBack:backgroundView];
                if (isiPhone) {
                    codeL = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 60, 30)];
                    [codeL setFont:[UIFont fontWithName:@"Arial" size:18]];
                } else {
                    codeL = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 60)];
                    [codeL setFont:[UIFont fontWithName:@"Arial" size:30]];
                }
                
                [codeL setBackgroundColor:[UIColor clearColor]];
                [codeL setTextAlignment:UITextAlignmentLeft];
                [codeL setText:kLogSeven];
                [codeL setTextColor:[UIColor colorWithRed:41.0/255 green:80.0/255 blue:145.0/255 alpha:1]];
                [cell addSubview:codeL];
                [codeL release];
                
                if (isiPhone) {
                    codeF = [[UITextField alloc]initWithFrame:CGRectMake(90, 5, 220, 30)];
                    [codeF setFont:[UIFont fontWithName:@"Arial" size:18]];
                } else {
                    codeF = [[UITextField alloc]initWithFrame:CGRectMake(150, 10, 418 , 60)];
                    [codeF setFont:[UIFont fontWithName:@"Arial" size:30]];
                }
                
                [codeF setBackgroundColor:[UIColor whiteColor]];
                [codeF setTextAlignment:UITextAlignmentLeft];
                [codeF setPlaceholder:kLogEight];
                [codeF setSecureTextEntry:YES];
                [codeF setTag:1];
                codeF.autocapitalizationType = UITextAutocapitalizationTypeNone;
                [codeF setDelegate:self];
                [cell addSubview:codeF];
                [codeF release];
                break;
            default:
                break;
        }
    }else
    {
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}


#pragma mark -
#pragma mark Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (isiPhone?40.0f:80.0f);
}

#pragma mark - Http connect
//-(BOOL) isExistenceNetwork:(NSInteger)choose
//{
//	BOOL isExistenceNetwork;
//	Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
//    switch ([r currentReachabilityStatus]) {
//        case NotReachable:
//			isExistenceNetwork=FALSE;
//            break;
//        case ReachableViaWWAN:
//			isExistenceNetwork=TRUE;
//            break;
//        case ReachableViaWiFi:
//			isExistenceNetwork=TRUE;
//            break;
//    }
//	if (!isExistenceNetwork) {
//        UIAlertView *myalert = nil;
//        switch (choose) {
//            case 0:
//                break;
//            case 1:
//                myalert = [[UIAlertView alloc] initWithTitle:kInfoTwo message:kFeedbackFour delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil,nil];
//                [myalert show];
//                [myalert release];
//                break;
//            default:
//                break;
//        }
//	}
//	return isExistenceNetwork;
//}
-(BOOL) isExistenceNetwork:(NSInteger)choose
{
    UIAlertView *myalert = nil;
   
    switch (choose) {
        case 0:
            
            break;
        case 1:
            if (kNetIsExist) {
                
            }else {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    kNetTest;
                });
                myalert = [[UIAlertView alloc] initWithTitle:kInfoTwo message:kFeedbackFour delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil,nil];
                [myalert show];
                [myalert release];
            }
            break;
        default:
            break;
    }
	return kNetIsExist;
}

//- (void)catchNetA
//{
//    NSString *url = @"http://www.baidu.com";
////    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
//    request.delegate = self;
//    [request setUsername:@"catchnet"];
//    [request startAsynchronous];
//
//}

- (void)catchYub:(NSString  *)userID
{
    NSString *url = [NSString stringWithFormat:@"http://app.iyuba.com/pay/checkApi.jsp?userId=%@",userID];
    //    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    request.delegate = self;
    [request setUsername:@"yub"];
    [request startAsynchronous];
}

- (void)catchLogs
{
//    NSString *url = [NSString stringWithFormat:@"http://api.iyuba.com/mobile/ios/voa/login.xml?username=%s&password=%s&md5status=0",userF.text.UTF8String,codeF.text.UTF8String];
    //    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    //    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    //    [request setPostValue:@"0"   forKey:@"md5status"];
    //    NSLog(@"request: %@", request );
    //    [request setRequestMethod:@"POST"];
    NSString *url = [NSString stringWithFormat:@"http://apis.iyuba.com/v2/api.iyuba?protocol=10001"];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [request setPostValue:[ROUtility encodeString:userF.text urlEncode:NSUTF8StringEncoding] forKey:@"username"];
    NSString *password = [ROUtility md5HexDigest:codeF.text];
    [request setPostValue:password   forKey:@"password"];
    [request setPostValue:@"xml" forKey:@"format"];
    NSString *sign = [ROUtility md5HexDigest:[NSString stringWithFormat:@"10001%@%@iyubaV2",userF.text,password]];
    [request setPostValue:sign forKey:@"sign"];
//    NSLog(@"sign:%@   %@", sign, [NSString stringWithFormat:@"10001%@%@iyubaV2",userF.text,password]);
    request.delegate = self;
    [request setUsername:@"log"];
    [request startSynchronous];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    //    kNetDisable;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        kNetTest;
    });
    if ([request.username isEqualToString:@"log" ]) {
        alert = [[UIAlertView alloc] initWithTitle:kVoaWordOne message:kLogNine delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    kNetEnable;
    if ([request.username isEqualToString:@"catchnet"]) {
        //        NSLog(@"有网络");
        //        isExisitNet = YES;
        return;
    }
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];
    if ([request.username isEqualToString:@"log" ]) {
        NSArray *items = [doc nodesForXPath:@"response" error:nil];
        if (items) {
            for (DDXMLElement *obj in items) {
                NSString *status = [[obj elementForName:@"result"] stringValue];
//                NSLog(@"status:%@",status);
                if ([status isEqualToString:@"101"]) {
                    MyUser *user = [[MyUser alloc]init];
                    user._userName = [userF text];
                    user._code = [codeF text];
                    
                    NSString *msg = [[obj elementForName:@"imgSrc"] stringValue] ;
//                    NSLog(@"msg:%@",msg);
                    NSInteger userId = [[[obj elementForName:@"uid"] stringValue] integerValue] ;
//                    NSLog(@"userId:%d",userId);
                    user._userId = userId;
                    [userImg setImageWithURL:[NSURL URLWithString:msg] placeholderImage:[UIImage imageNamed:@"acquiesceBBC.png"]];
                    [userImg setHidden:NO];
//                    NSString *vipStatus = [[obj elementForName:@"vipStatus"]stringValue];
//                    NSLog(@"vip:%@",vipStatus);
                    NSString *expireTime = [[obj elementForName:@"expireTime"]stringValue];
//                    NSLog(@"expireTime:%@",expireTime);
                    NSDate *vipDate = [NSDate dateWithTimeIntervalSince1970: expireTime.doubleValue];
                    [[NSUserDefaults standardUserDefaults] setObject:vipDate forKey:@"vipDate"]; //vip到期时间
                    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:userId] forKey:@"nowUser"];
                    if ([vipDate compare:[NSDate date]] == NSOrderedDescending) {
//                        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:kBePro];
                        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isVip"];
//                        NSLog(@"paid");
                    } else {
//                        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:kBePro];
                        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isVip"];
//                        NSLog(@"free");
                    }
                    
                    [user insert];
                    [user release],user = nil;
                    [nowUser setText:[NSString stringWithFormat:@"%@%@",kLogOne,[MyUser findNameById:userId]]];
                    [nowUser setHidden:NO];
                    [afterLog setHidden:NO];
                    [logOutBtn setHidden:NO];
                    [yubBtn setHidden:NO];
                    [yubNumBtn setHidden:NO];
                    [logBtnTwo setHidden:YES];
                    [logTable setHidden:YES];
                    [remCodeL setHidden:YES];
                    [remCode setHidden:YES];
                    
                    NSInteger rem = [[[NSUserDefaults standardUserDefaults] objectForKey:@"remCode"] integerValue];
                    if (rem==1) {
                        [MyUser acceptRem:userF.text];
                    }else
                    {
                        [MyUser cancelRem:userF.text];
                    }
                    
                    alert = [[UIAlertView alloc] initWithTitle:kLogTwo message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    
                    [alert setBackgroundColor:[UIColor clearColor]];
                    
                    [alert setContentMode:UIViewContentModeScaleAspectFit];
                    
                    [alert show];
                    
                    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                    
                    active.center = CGPointMake(alert.bounds.size.width/2, alert.bounds.size.height-40);
                    
                    [alert addSubview:active];
                    
                    [active startAnimating];
                    
                    [active release];
                    
                    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(c) userInfo:nil repeats:NO];
                    
                }else 
                {
                    NSString *msg = nil;
                    if ([status isEqualToString:@"102"]) {
                        msg = kLogTwe;
                    } else if([status isEqualToString:@"103"]){
                        msg = kLogThrt;
                    } else {
                        msg = kLogFort;
                    }
//                    NSString *msg = [[obj elementForName:@"message"] stringValue] ;
                    //                    NSLog(@"msg:%@",msg);
                    alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@%@",kLogTen,msg] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    
                    [alert setBackgroundColor:[UIColor clearColor]];
                    
                    [alert setContentMode:UIViewContentModeScaleAspectFit];
                    
                    [alert show];
                    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                    
                    active.center = CGPointMake(alert.bounds.size.width/2, alert.bounds.size.height-40);
                    
                    [alert addSubview:active];
                    
                    [active startAnimating];
                    
                    [active release];
                    
                    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(c) userInfo:nil repeats:NO];
                }
            }
        }
    } else {
        if ([request.username isEqualToString:@"yub" ]) {
            NSArray *items = [doc nodesForXPath:@"response" error:nil];
            if (items) {
                for (DDXMLElement *obj in items) {
                    NSString *amount = [[obj elementForName:@"amount"] stringValue];
                    [yubNumBtn setTitle:amount forState:UIControlStateNormal];
                }
            }
        }
    }
    [doc release],doc = nil;
}

-(void)c
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    [alert release];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [textField setTextColor:[UIColor blackColor]];
    [textField setText:@""];
    if (textField.tag == 1) {
        
        NSString *code = [MyUser findCodeByName:userF.text];
        [textField setSecureTextEntry:YES];
        //        NSLog(@"自动密码kai:%@",code);
        if (code) {
            [codeF setText:code];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
            if (textField.text.length <3) {
                [textField setText:kLogEleven];
                [textField setTextColor:[UIColor redColor]];
            }else{
                [textField setTextColor:[UIColor blackColor]];
                NSString *code = [MyUser findCodeByName:textField.text];
                //                NSLog(@"自动密码wan:%@",code);
                if (code) {
                    [codeF setText:code];
                }
            }
            break;
        case 1:
            if (textField.text.length == 0) {
                [textField setSecureTextEntry:NO];
                [textField setText:kLogEight];
                [textField setTextColor:[UIColor redColor]];
            }else{
                [textField setSecureTextEntry:YES];
            }
            break;
        default:
            break;
    }
}

@end
