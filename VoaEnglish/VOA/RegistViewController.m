//
//  RegistViewController.m
//  VOA
//
//  Created by song zhao on 12-3-14.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "RegistViewController.h"

@implementation RegistViewController
@synthesize logTable;
@synthesize userF;
@synthesize userL;
@synthesize codeF;
@synthesize codeL;
@synthesize codeAgainF;
@synthesize codeAgainL;
@synthesize mailF;
@synthesize mailL;
@synthesize registBtn;
@synthesize alert;
@synthesize isiPhone;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

#pragma mark - My action
- (IBAction) goBack:(UIButton *)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void) doRegist
{
    if (userF.textColor == [UIColor blackColor] && codeF.textColor == [UIColor blackColor] && codeAgainF.textColor == [UIColor blackColor] && mailF.textColor == [UIColor blackColor]) {
        [self catchRegists];
    }
}


#pragma mark - View lifecycle
- (void)viewWillAppear:(BOOL)animated
{
    kNetTest;
    [registBtn setUserInteractionEnabled:NO];
    [self setTitle:@"注册"];
    UIImageView *logo = [[UIImageView alloc]init];
    if (isiPhone) {
         [logo setFrame:CGRectMake(30, 273, 261, 114)];
         [logo setImage:[UIImage imageNamed:@"logoIyuba.png"]];
    } else {
        [logo setFrame:CGRectMake(0, 650, 768,220)];
        [logo setImage:[UIImage imageNamed:@"logoiyuba-iPad.png"]];
    }
    [self.view addSubview:logo];
    [logo release];
   
}

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden = NO ;
    isiPhone = ![Constants isPad];
//    UIImageView *backgroundView = Nil;
    if (isiPhone) {
//        backgroundView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
    }else {
        [self.view setFrame:CGRectMake(0, 0, 768, 1024)];
        [self.logTable setFrame:CGRectMake(100, 100, 575, 500)];
//        backgroundView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
    }
//    [backgroundView setImage:[UIImage imageNamed:@"bgRg.png"]];
//    [logTable addSubview:backgroundView];
//    [logTable sendSubviewToBack:backgroundView];
//    [backgroundView release];
//    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.logTable = nil;
}

- (void)dealloc
{
    [self.logTable release], logTable = nil;
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    NSString *identifier = [NSString stringWithFormat:@"RegistCell%d",[indexPath row]];
    cell = [logTable dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] autorelease];
//        UIImageView *backgroundView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
//        UIImageView *lineView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 39, 300, 1)];
        switch ([indexPath row]) {
            case 0:
//                [backgroundView setImage:[UIImage imageNamed:@"cellBgOne.png"]];
//                [cell addSubview:backgroundView];
//                [cell sendSubviewToBack:backgroundView];
//                [lineView setImage:[UIImage imageNamed:@"lineSep.png"]];
//                [cell addSubview:lineView];
//                [cell sendSubviewToBack:lineView];
                if (isiPhone) {
                    userL = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 80, 30)];
                    [userL setFont:[UIFont boldSystemFontOfSize:18]];

                } else {
                    userL = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, 150, 60)];
                    [userL setFont:[UIFont boldSystemFontOfSize:30]];

                }
                [userL setTextColor:[UIColor colorWithRed:41.0/255 green:80.0/255 blue:145.0/255 alpha:1]];
                [userL setBackgroundColor:[UIColor clearColor]];
                [userL setTextAlignment:UITextAlignmentLeft];
                [userL setText:kLogFive];
                [cell addSubview:userL];
                [userL release];
                
                if (isiPhone) {
                    userF = [[UITextField alloc]initWithFrame:CGRectMake(90, 10, 220, 30)];
                    [userF setFont:[UIFont fontWithName:@"Arial" size:15]];
                } else {
                    userF = [[UITextField alloc]initWithFrame:CGRectMake(170, 10, 400, 60)];
                    [userF setFont:[UIFont fontWithName:@"Arial" size:30]];
                }
                
                [userF setBackgroundColor:[UIColor whiteColor]];
                [userF setTextAlignment:UITextAlignmentLeft];
                [userF setPlaceholder:kRegOne];
                [userF setDelegate:self];
                [userF setTag:0];
                userF.autocapitalizationType = UITextAutocapitalizationTypeNone;
                [cell addSubview:userF];
                [userF release];
                break;
                
            case 1: 
//                [backgroundView setImage:[UIImage imageNamed:@"cellBgTwo.png"]];
//                [cell addSubview:backgroundView];
//                [cell sendSubviewToBack:backgroundView];
//                [lineView setImage:[UIImage imageNamed:@"lineSep.png"]];
//                [cell addSubview:lineView];
//                [cell sendSubviewToBack:lineView];
                if (isiPhone) {
                    codeL = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 80, 30)];
                    [codeL setFont:[UIFont boldSystemFontOfSize:18]];

                } else {
                    codeL = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, 150, 60)];
                    [codeL setFont:[UIFont boldSystemFontOfSize:30]];

                }
                [codeL setBackgroundColor:[UIColor clearColor]];
                [codeL setTextAlignment:UITextAlignmentLeft];
                [codeL setText:kLogSeven];
                [codeL setTextColor:[UIColor colorWithRed:41.0/255 green:80.0/255 blue:145.0/255 alpha:1]];
                [cell addSubview:codeL];
                [codeL release];
                
                if (isiPhone) {
                    codeF = [[UITextField alloc]initWithFrame:CGRectMake(90, 10, 220, 30)];
                    [codeF setFont:[UIFont fontWithName:@"Arial" size:15]];
                } else {
                    codeF = [[UITextField alloc]initWithFrame:CGRectMake(170, 10, 400, 60)];
                    [codeF setFont:[UIFont fontWithName:@"Arial" size:30]];
                }
                
                [codeF setBackgroundColor:[UIColor whiteColor]];
                [codeF setTextAlignment:UITextAlignmentLeft];
                [codeF setPlaceholder:kLogEight];
                [codeF setSecureTextEntry:YES];
                [codeF setDelegate:self];
                [codeF setTag:1];
                codeF.autocapitalizationType = UITextAutocapitalizationTypeNone;
                [cell addSubview:codeF];
                [codeF release];
                break;
                
            case 2:
//                [backgroundView setImage:[UIImage imageNamed:@"cellBgThree.png"]];
//                [cell addSubview:backgroundView];
//                [cell sendSubviewToBack:backgroundView];
//                [lineView setImage:[UIImage imageNamed:@"lineSep.png"]];
//                [cell addSubview:lineView];
//                [cell sendSubviewToBack:lineView];
                if (isiPhone) {
                    codeAgainL = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 80, 30)];
                    [codeAgainL setFont:[UIFont boldSystemFontOfSize:18]];
                } else {
                    codeAgainL = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, 150, 60)];
                    [codeAgainL setFont:[UIFont boldSystemFontOfSize:30]];
                }
                
                [codeAgainL setBackgroundColor:[UIColor clearColor]];
                [codeAgainL setTextAlignment:UITextAlignmentLeft];
                [codeAgainL setText:kRegTwo];
                [codeAgainL setTextColor:[UIColor colorWithRed:41.0/255 green:80.0/255 blue:145.0/255 alpha:1]];
                [cell addSubview:codeAgainL];
                [codeAgainL release];
                
                if (isiPhone) {
                    codeAgainF = [[UITextField alloc]initWithFrame:CGRectMake(90, 10, 220, 30)];
                    [codeAgainF setFont:[UIFont fontWithName:@"Arial" size:15]];
                } else {
                    codeAgainF = [[UITextField alloc]initWithFrame:CGRectMake(170, 10, 400, 60)];
                    [codeAgainF setFont:[UIFont fontWithName:@"Arial" size:30]];
                }
                
                [codeAgainF setBackgroundColor:[UIColor whiteColor]];
                [codeAgainF setTextAlignment:UITextAlignmentLeft];
                [codeAgainF setPlaceholder:kRegThree];
                [codeAgainF setSecureTextEntry:YES];
                [codeAgainF setDelegate:self];
                [codeAgainF setTag:2];
                codeAgainF.autocapitalizationType = UITextAutocapitalizationTypeNone;
                [cell addSubview:codeAgainF];
                [codeAgainF release];
                break;
                
            case 3:
//                [backgroundView setImage:[UIImage imageNamed:@"cellBgLast.png"]];
//                [cell addSubview:backgroundView];
//                [cell sendSubviewToBack:backgroundView];
//                [lineView setImage:[UIImage imageNamed:@"lineSep.png"]];
//                [cell addSubview:lineView];
//                [cell sendSubviewToBack:lineView];
                if (isiPhone) {
                    mailL = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 80, 30)];
                    [mailL setFont:[UIFont boldSystemFontOfSize:18]];
                } else {
                    mailL = [[UILabel alloc]initWithFrame:CGRectMake(5, 10,150, 60)];
                    [mailL setFont:[UIFont boldSystemFontOfSize:30]];
                }
                
                [mailL setBackgroundColor:[UIColor clearColor]];
                [mailL setTextAlignment:UITextAlignmentLeft];
                [mailL setText:@"Email:"];
                [mailL setTextColor:[UIColor colorWithRed:41.0/255 green:80.0/255 blue:145.0/255 alpha:1]];
                [cell addSubview:mailL];
                [mailL release];
                
                if (isiPhone) {
                    mailF = [[UITextField alloc]initWithFrame:CGRectMake(90, 10, 220, 30)];
                    [mailF setFont:[UIFont fontWithName:@"Arial" size:15]];

                } else {
                    mailF = [[UITextField alloc]initWithFrame:CGRectMake(170, 10, 400,60)];
                    [mailF setFont:[UIFont fontWithName:@"Arial" size:30]];

                }
                [mailF setBackgroundColor:[UIColor whiteColor]];
                [mailF setTextAlignment:UITextAlignmentLeft];
                [mailF setPlaceholder:kRegFour];
                [mailF setDelegate:self];
                [mailF setTag:3];
                mailF.autocapitalizationType = UITextAutocapitalizationTypeNone;
                [cell addSubview:mailF];
                [mailF release];
                break;
                
            case 4:
                registBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
                [registBtn setTitle:@"提交" forState:UIControlStateNormal];
                [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [registBtn addTarget:self action:@selector(doRegist) forControlEvents:UIControlEventTouchUpInside];
                if (isiPhone) {
                    [registBtn setFrame:CGRectMake(220, 5, 80, 40)];
                    [registBtn setBackgroundImage: [UIImage imageNamed:@"logPressed.png"] forState:UIControlStateNormal];
                    [[registBtn titleLabel] setFont:[UIFont boldSystemFontOfSize:18]];
                } else {
                    [registBtn setFrame:CGRectMake(400 , 5, 150, 80)];
                    [registBtn setBackgroundImage: [UIImage imageNamed:@"logOut-iPad.png"] forState:UIControlStateNormal];
                    [[registBtn titleLabel] setFont:[UIFont boldSystemFontOfSize:32]];

                }
               
                [cell addSubview:registBtn];
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
- (void)catchRegists
{
    //    NSLog(@"mail：%s",[self.mailF.text UTF8String]);
//    NSString *url = [NSString stringWithFormat:@"http://api.iyuba.com/mobile/ios/voa/regist.xml?email=%s&username=%s&password=%s&md5status=0",mailF.text.UTF8String,userF.text.UTF8String,codeF.text.UTF8String];
    //    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSString *url = [NSString stringWithFormat:@"http://api.iyuba.com/mobile/ios/voa/regist.xml?"];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [request setPostValue:mailF.text forKey:@"email"];
    [request setPostValue:userF.text   forKey:@"username"];
    [request setPostValue:codeF.text   forKey:@"password"];
    [request setPostValue:@"0"   forKey:@"md5status"];
    request.delegate = self;
    [request setUsername:@"regist"];
    [request startSynchronous];
    
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
    kNetTest;
    alert = [[UIAlertView alloc] initWithTitle:kRegFive message:kRegSix delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    kNetEnable;
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];
    if ([request.username isEqualToString:@"regist" ]) {
        NSArray *items = [doc nodesForXPath:@"response" error:nil];
        if (items) {
            for (DDXMLElement *obj in items) {
                NSString *status = [[obj elementForName:@"status"] stringValue];
                //                NSLog(@"status:%@",status);
                if ([status isEqualToString:@"OK"]) {
                    MyUser *user = [[MyUser alloc]init];
                    user._userName = [userF text];
                    user._code = [codeF text];
                    user._mail = [mailF text];
                    //                    NSString *msg = [[obj elementForName:@"msg"] stringValue] ;
                    //                    NSLog(@"msg:%@",msg);
                    NSInteger userId = [[[obj elementForName:@"data"] stringValue] integerValue] ;
                    //                    NSLog(@"userId:%d",userId);
                    user._userId = userId;
                    [user insert];
                    [user release],user = nil;
                    alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@%@",kRegSeven,[userF text]] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    
                    [alert setBackgroundColor:[UIColor clearColor]];
                    
                    [alert setContentMode:UIViewContentModeScaleAspectFit];
                    
                    [alert show];
                    
                    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                    
                    active.center = CGPointMake(alert.bounds.size.width/2, alert.bounds.size.height-40);
                    
                    [alert addSubview:active];
                    
                    [active startAnimating];
                    
                    [active release];
                    
                    NSTimer *timer = nil;
                    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(c) userInfo:nil repeats:NO];
                    NSInteger nowId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
                    //    NSLog(@"生词本添加用户：%d",userId);
                    if (nowId<=0) {
                        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:userId] forKey:@"nowUser"];
                    }
                    [self dismissModalViewControllerAnimated:YES];
                }else
                {
                    NSString *msg = [[obj elementForName:@"msg"] stringValue] ;
                    //                    NSLog(@"msg:%@",msg);
                    alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@%@",kRegEight,msg] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    
                    [alert setBackgroundColor:[UIColor clearColor]];
                    
                    [alert setContentMode:UIViewContentModeScaleAspectFit];
                    
                    [alert show];
                    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                    
                    active.center = CGPointMake(alert.bounds.size.width/2, alert.bounds.size.height-40);
                    
                    [alert addSubview:active];
                    
                    [active startAnimating];
                    
                    [active release];
                    
                    NSTimer *timer = nil;
                    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(c) userInfo:nil repeats:NO];
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

//-(BOOL) isExistenceNetwork:(NSInteger)choose
//{
//	BOOL isExistenceNetwork;
//	Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
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
//                
//                break;
//            case 1:
//                myalert = [[UIAlertView alloc] initWithTitle:kInfoTwo message:kRegNine delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil,nil];
//                [myalert show];
//                [myalert release];
//                break;
//            default:
//                break;
//        }
//	}
//	return isExistenceNetwork;
//}


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
    if (textField.tag == 1 || textField.tag == 2) {
        [textField setSecureTextEntry:YES];
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
        case 2:
            if ([textField.text isEqualToString:codeF.text]) {
                [textField setSecureTextEntry:YES];
            }else{
                [textField setSecureTextEntry:NO];
                [textField setText:kRegTen];
                [textField setTextColor:[UIColor redColor]];
            }
             break;
        case 3:
//            if ([textField.text isMatchedByRegex:@"^(\\w+((-\\w+)|(\\.\\w+))*)\\+\\w+((-\\w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z0-9]+$"]){
            if ([textField.text isMatchedByRegex:@"^([a-zA-Z0-9_\\.\\-])+\\@(([a-zA-Z0-9\\-])+\\.)+([a-zA-Z0-9]{2,4})+$"]){    
            }else{
                [textField setText:kRegEleven];
                [textField setTextColor:[UIColor redColor]];
            }
        default:
            break;
    }
}

@end
