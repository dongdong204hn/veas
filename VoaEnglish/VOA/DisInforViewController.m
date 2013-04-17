//
//  DisInforViewController.m
//  VOA
//
//  Created by zhao song on 13-1-22.
//  Copyright (c) 2013年 buaa. All rights reserved.
//

#import "DisInforViewController.h"

@interface DisInforViewController ()

@end

@implementation DisInforViewController
@synthesize segmentedControl;
@synthesize inforScroll;
@synthesize isiPhone;
@synthesize msgTv;
@synthesize logBtn;
@synthesize disMsgLab;
@synthesize inforArray;
@synthesize toVoaid;
@synthesize HUD;
@synthesize rightCharacter;
@synthesize alertLab;
@synthesize editBtn;
@synthesize recordView;
@synthesize appView;
@synthesize appScroll;
@synthesize alert;
@synthesize avgOfDayStudyTLab;
@synthesize todayStudyTLab;
@synthesize countOfReadedLab;
@synthesize loveClassLab;
@synthesize countOfCollectVoaLab;
@synthesize countOfCollectSenLab;
@synthesize countOfCollectWordLab;
@synthesize avgOfRemWordLab;
@synthesize remWorstWord;
@synthesize img1;
@synthesize img2;
@synthesize img3;
@synthesize img4;
@synthesize img5;
@synthesize img6;
@synthesize img7;
@synthesize img8;
@synthesize img9;
@synthesize img10;
@synthesize img11;
@synthesize img12;
@synthesize img13;
@synthesize img14;
@synthesize img15;
@synthesize img16;
@synthesize img17;
@synthesize img18;
@synthesize img19;
@synthesize img20;
@synthesize img21;
@synthesize img22;
@synthesize img23;
@synthesize img24;
@synthesize img25;
@synthesize img26;
@synthesize img27;

//@synthesize nowPage;
//@synthesize totalPage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    isiPhone = ![Constants isPad];
	if (isiPhone) {
        self = [super initWithNibName:@"DisInforViewController" bundle:nibBundleOrNil];
	}else {
        self = [super initWithNibName:@"DisInforViewController-iPad" bundle:nibBundleOrNil];
    }
    if (self) {
        //        NSLog(@"%@",nibNameOrNil);
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addImgTapped {
    [img1 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/ai-yu-ba-ting-ge-xue-ying-yu/id555917167?ls=1&mt=8"]];
    }];
    
    [img2 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/ai-yu-ba-ting-ge-xue-ying/id598946101?ls=1&mt=8"]];
    }];
    [img3 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/bbc6fen-zhong-ying-yu-ying/id558115664?ls=1&mt=8"]];
    }];
    
    [img4 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/six-minutes-english/id568827548?ls=1&mt=8"]];
    }];
    [img5 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/voa-ying-yu-ban-lu-pro/id542107964?ls=1&mt=8"]];
    }];
    
    [img6 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/ai-yu-bavoa-ying-yu-ban-lu/id519013738?ls=1&mt=8"]];
    }];
    [img7 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/voa-chang-su-ying-yu-pro/id588659843?ls=1&mt=8"]];
    }];
    
    [img8 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/ai-yu-bavoa-chang-su-ying-yu/id553414030?ls=1&mt=8"]];
    }];
    [img9 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/voa-ying-yu-shi-pin-ban/id586520108?ls=1&mt=8"]];
    }];
    
    [img10 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/ai-yu-bavoa-ying-yu-shi-pin/id586521067?ls=1&mt=8"]];
    }];
    [img11 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/mei-yu-zen-me-shuo-shi-ting/id586164355?ls=1&mt=8"]];
    }];
    
    [img12 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/mei-yu-zen-me-shuo-shi-ting/id584717854?ls=1&mt=8"]];
    }];
    [img13 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/ying-yu-si-ji-ting-li/id523099688?ls=1&mt=8"]];
    }];
    
    [img14 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/ying-yu-si-ji-ting-lifree/id529455490?ls=1&mt=8"]];
    }];
    [img15 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/ying-yu-liu-ji-ting-li/id523105724?ls=1&mt=8"]];
    }];
    
    [img16 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/ying-yu-liu-ji-ting-lifree/id529453528?ls=1&mt=8"]];
    }];
    [img17 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/ri-yu1ji-ting-li/id531114297?ls=1&mt=8"]];
    }];
    
    [img18 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/ri-yu1ji-ting-lifree/id542281757?ls=1&mt=8"]];
    }];
    [img19 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/ri-yu2ji-ting-li/id533392105?ls=1&mt=8"]];
    }];
    
    [img20 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/ri-yu2ji-ting-lifree/id542283126?ls=1&mt=8"]];
    }];
    [img21 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/ri-yu3ji-ting-li/id518555576?ls=1&mt=8"]];
    }];
    
    [img22 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/ri-yu3ji-ting-lifree/id542283933?ls=1&mt=8"]];
    }];
    
    [img23 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/toeic-listening-700-questions/id550041392?ls=1&mt=8"]];
    }];
    
    [img24 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/toeichiaringu-700dian-ofurainbajon/id569041823?ls=1&mt=8"]];
    }];
    
    [img25 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/xue-wei-ying-yu-dan-ci-da/id550872310?ls=1&mt=8"]];
    }];
    [img26 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/zhi-hui-qiu-wan-ju-ying-yu/id590220714?mt=8"]];
    }];
    [img27 whenTapped:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/zhi-hui-qiu-wan-ju-ying-yu/id598272109?mt=8"]];
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = kDIOne;
    isiPhone = ![Constants isPad];
    //    nowPage = 1;
    //    totalPage = 1;
    inforArray = [[NSMutableArray alloc] init];
    [inforScroll setContentSize:CGSizeMake(inforScroll.frame.size.width * 3, inforScroll.frame.size.height)];
    [inforScroll setShowsHorizontalScrollIndicator:NO];
    [inforScroll setShowsVerticalScrollIndicator:NO];
    [inforScroll setScrollEnabled:NO];
    
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTapped:)];
//    singleTap.numberOfTapsRequired=1;
//    [imgOne addGestureRecognizer:singleTap];
    
    [self addImgTapped];
    
    if (isiPhone) {
        segmentedControl=[[UISegmentedControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 150.0f, 30.0f) ];
        
        UILabel *appLab = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, 100, 25)];
        [appLab setFont:[UIFont systemFontOfSize:18]];
        [appLab setTextColor:[UIColor blackColor]];
        [appLab setText:@"应用展示"];
        [appLab setBackgroundColor:[UIColor clearColor]];
        [appLab setTextAlignment:NSTextAlignmentCenter];
        [inforScroll addSubview:appLab];
        [appLab release];
        
        UILabel *noteLab = [[UILabel alloc] initWithFrame:CGRectMake(320 + 110, 5, 100, 25)];
        [noteLab setFont:[UIFont systemFontOfSize:18]];
        [noteLab setTextColor:[UIColor blackColor]];
        [noteLab setText:@"学习记录"];
        [noteLab setBackgroundColor:[UIColor clearColor]];
        [noteLab setTextAlignment:NSTextAlignmentCenter];
        [inforScroll addSubview:noteLab];
        [noteLab release];
        
        
        UILabel *messageLab = [[UILabel alloc] initWithFrame:CGRectMake(640 + 110, 5, 100, 25)];
        [messageLab setFont:[UIFont systemFontOfSize:18]];
        [messageLab setTextColor:[UIColor blackColor]];
        [messageLab setText:@"消息中心"];
        [messageLab setBackgroundColor:[UIColor clearColor]];
        [messageLab setTextAlignment:NSTextAlignmentCenter];
        [inforScroll addSubview:messageLab];
        [messageLab release];
        
        alertLab = [[UILabel alloc] initWithFrame:CGRectMake(640 + 40, 40, 240, 25)];
        [alertLab setFont:[UIFont systemFontOfSize:18]];
        [alertLab setTextColor:[UIColor blackColor]];
        [alertLab setText:kDIFive];
        [alertLab setBackgroundColor:[UIColor clearColor]];
        [alertLab setTextAlignment:NSTextAlignmentCenter];
        
        
        msgTv = [[UITableView alloc] initWithFrame:CGRectMake(640, 35, 320, 200 + kFiveAddHalf) style:UITableViewStylePlain];
        
        logBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [logBtn setFrame:CGRectMake(640 + 110, 40, 100, 30)];
        [logBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
//        [logBtn setBackgroundColor:[UIColor whiteColor]];
        [logBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
//        [logBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [logBtn setTitle:@"登录后查看" forState:UIControlStateNormal];
        [logBtn setImage:[UIImage imageNamed:@"VOANeedLog.png"] forState:UIControlStateNormal];
        //                    [reponseBtn setBackgroundColor:[UIColor whiteColor]];
        [logBtn addTarget:self action:@selector(doLog) forControlEvents:UIControlEventTouchUpInside];
        //        [reponseBtn setTag:4];
        
        editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [editBtn setFrame:CGRectMake(640 + 270, 9, 40, 18)];
        [editBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
//        [editBtn setBackgroundColor:[UIColor whiteColor]];
        [editBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
//        [editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [editBtn setTitle:kSearchTwo forState:UIControlStateNormal];
        [editBtn setImage:[UIImage imageNamed:@"messageDel"] forState:UIControlStateNormal];
        //                    [reponseBtn setBackgroundColor:[UIColor whiteColor]];
        [editBtn addTarget:self action:@selector(doEdit) forControlEvents:UIControlEventTouchUpInside];
        
        disMsgLab = [[STTweetLabel alloc] initWithFrame:CGRectMake(640, 240 + kFiveAddHalf, 320.0, 120 + kFiveAddHalf)];
        [disMsgLab setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0]];
        [disMsgLab setTextColor:[UIColor colorWithRed:71.0/255 green:71.0/255 blue:72.0/255 alpha:1.0f]];
        [disMsgLab setDelegate:self];
        [disMsgLab setBackgroundColor:[UIColor clearColor]];
        [disMsgLab setText:@"点击列表查看消息全部内容,点击头像可直接发消息"];
        
        [recordView setFrame:CGRectMake(320, 35, 320, 330)];
        
        [appScroll setContentSize:CGSizeMake(320, 660)];
        
    } else {
        segmentedControl=[[UISegmentedControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 38.0f) ];
        
        UILabel *appLab = [[UILabel alloc] initWithFrame:CGRectMake(294, 5, 180, 50)];
        [appLab setFont:[UIFont systemFontOfSize:20]];
        [appLab setTextColor:[UIColor blackColor]];
        [appLab setText:@"应用展示"];
        [appLab setBackgroundColor:[UIColor clearColor]];
        [appLab setTextAlignment:NSTextAlignmentCenter];
        [inforScroll addSubview:appLab];
        [appLab release];
        
        UILabel *noteLab = [[UILabel alloc] initWithFrame:CGRectMake(768 + 294, 5, 180, 50)];
        [noteLab setFont:[UIFont systemFontOfSize:20]];
        [noteLab setTextColor:[UIColor blackColor]];
        [noteLab setText:@"学习记录"];
        [noteLab setBackgroundColor:[UIColor clearColor]];
        [noteLab setTextAlignment:NSTextAlignmentCenter];
        [inforScroll addSubview:noteLab];
        [noteLab release];
        
        
        UILabel *messageLab = [[UILabel alloc] initWithFrame:CGRectMake(1536 + 294, 5, 180, 50)];
        [messageLab setFont:[UIFont systemFontOfSize:20]];
        [messageLab setTextColor:[UIColor blackColor]];
        [messageLab setText:@"消息中心"];
        [messageLab setBackgroundColor:[UIColor clearColor]];
        [messageLab setTextAlignment:NSTextAlignmentCenter];
        [inforScroll addSubview:messageLab];
        [messageLab release];
        
        alertLab = [[UILabel alloc] initWithFrame:CGRectMake(1536 + 184, 80, 400, 50)];
        [alertLab setFont:[UIFont systemFontOfSize:20]];
        [alertLab setTextColor:[UIColor blackColor]];
        [alertLab setText:kDIFive];
        [alertLab setBackgroundColor:[UIColor clearColor]];
        [alertLab setTextAlignment:NSTextAlignmentCenter];
        
        
        msgTv = [[UITableView alloc] initWithFrame:CGRectMake(1536, 70, 768, 500) style:UITableViewStylePlain];
        
        logBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [logBtn setFrame:CGRectMake(1536 + 294, 80, 180, 50)];
        [logBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
//        [logBtn setBackgroundColor:[UIColor whiteColor]];
        [logBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
//        [logBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [logBtn setImage:[UIImage imageNamed:@"VOANeedLog-ipad.png"] forState:UIControlStateNormal];
//        [logBtn setTitle:@"登录后查看" forState:UIControlStateNormal];
        //                    [reponseBtn setBackgroundColor:[UIColor whiteColor]];
        [logBtn addTarget:self action:@selector(doLog) forControlEvents:UIControlEventTouchUpInside];
        //        [reponseBtn setTag:4];
        
        editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [editBtn setFrame:CGRectMake(1536 + 688, 10, 60, 30)];
        [editBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
//        [editBtn setBackgroundColor:[UIColor whiteColor]];
        [editBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
//        [editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [editBtn setTitle:kSearchTwo forState:UIControlStateNormal];
        [editBtn setImage:[UIImage imageNamed:@"messageDel-ipad.png"] forState:UIControlStateNormal];
        //                    [reponseBtn setBackgroundColor:[UIColor whiteColor]];
        [editBtn addTarget:self action:@selector(doEdit) forControlEvents:UIControlEventTouchUpInside];
        
        disMsgLab = [[STTweetLabel alloc] initWithFrame:CGRectMake(1536, 590, 768, 300 + kFiveAddHalf)];
        [disMsgLab setFont:[UIFont fontWithName:@"HelveticaNeue" size:16.0]];
        [disMsgLab setTextColor:[UIColor colorWithRed:71.0/255 green:71.0/255 blue:72.0/255 alpha:1.0f]];
        [disMsgLab setDelegate:self];
        [disMsgLab setBackgroundColor:[UIColor clearColor]];
        [disMsgLab setText:@"点击列表查看消息全部内容,点击头像可直接发消息"];
        
        [recordView setFrame:CGRectMake(768, 50, 768, 866)];
        
//        [appView setFrame:CGRectMake(0, 50, 768, 866)];
        [appScroll setContentSize:CGSizeMake(768, 1584)];
    }
    
    [segmentedControl insertSegmentWithTitle:kDITwo atIndex:0 animated:YES];
    [segmentedControl insertSegmentWithTitle:kDIThr atIndex:1 animated:YES];
    [segmentedControl insertSegmentWithTitle:kDIFour atIndex:2 animated:YES];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    //    segmentedControl.momentary = YES;
    segmentedControl.multipleTouchEnabled=NO;
    [segmentedControl addTarget:self action:@selector(doSeg:) forControlEvents:UIControlEventValueChanged];
    [segmentedControl setSelectedSegmentIndex:0];
    //    UIBarButtonItem *segButton = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
    //    [segmentedControl release], segmentedControl = nil;
    self.navigationItem.titleView = segmentedControl;
    [segmentedControl release];
    
    //    [msgTv setBackgroundColor:[UIColor clearColor]];
    
    [inforScroll addSubview:recordView];
    [recordView release];
    
    [appScroll addSubview:appView];
    [appView release];
    
    [msgTv setSeparatorColor:[UIColor colorWithRed:76.0/255 green:137.0/255 blue:167.0/255 alpha:1.0f]];
    [msgTv setDelegate:self];
    [msgTv setDataSource:self];
    [inforScroll addSubview:alertLab];
    [alertLab release];
    [inforScroll addSubview:msgTv];
    [msgTv release];
    [inforScroll addSubview:logBtn];
    [logBtn release];
    [inforScroll addSubview:editBtn];
    [editBtn release];
    [inforScroll addSubview:disMsgLab];
    [disMsgLab release];
}

- (void)viewWillAppear:(BOOL)animated  {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        kNetTest;
    });
    self.navigationController.navigationBarHidden = NO;
    int nowUserID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
//    NSLog(@"%d", nowUserID);
    [editBtn setHidden:YES];
    [msgTv setHidden:YES];
    [disMsgLab setHidden:YES];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YY-MM-dd-a-hh-mm-ss"];
    NSString* locationString=[formatter stringFromDate: [NSDate date]];
    NSArray* timeArray=[locationString componentsSeparatedByString:@"-"];
    NSInteger value_Y= [[timeArray objectAtIndex:0]integerValue];
    NSInteger value_M= [[timeArray objectAtIndex:1]integerValue];
    NSInteger value_D= [[timeArray objectAtIndex:2]integerValue];
    NSString *am = [timeArray objectAtIndex:3];
    NSInteger value_h = 0;
    if ([am isEqualToString:@"PM"]) {
        value_h= [[timeArray objectAtIndex:4]integerValue] + 12;
    } else {
        value_h= [[timeArray objectAtIndex:4]integerValue];
    }
    NSInteger value_m= [[timeArray objectAtIndex:5]integerValue];
    NSInteger value_s= [[timeArray objectAtIndex:6]integerValue];
    NSInteger value_All = value_h*60*60 + value_m*60 + value_s;
    NSString *nowDate = [NSString stringWithFormat:@"%2i-%2i-%2i", value_Y, value_M, value_D];
    NSString *todayDate = [[NSUserDefaults standardUserDefaults] stringForKey:@"todayDate"];
    NSInteger seconds = [StudyTime findSecsByDate:nowDate];
    NSInteger avgTime = [StudyTime avgStudyTime:nowDate];
    if ([nowDate isEqualToString:todayDate]) {
        seconds += value_All - [[NSUserDefaults standardUserDefaults] integerForKey:@"nowSeconds"];
    } else {
        seconds += value_All;
    }
    [formatter release], formatter = nil;
    if (avgTime > 0) {
        int n = (avgTime%60)*5/3;
        if (n > 9) {
            [avgOfDayStudyTLab setText:[NSString stringWithFormat:@"%d.%d分", avgTime/60, n]];
        } else {
            [avgOfDayStudyTLab setText:[NSString stringWithFormat:@"%d.0%d分", avgTime/60, n]];
        }
    
    } else {
        [avgOfDayStudyTLab setText:@"今日开始统计"];
    }
    
    int n = (seconds%60)*5/3;
    if (n > 9) {
        [todayStudyTLab setText:[NSString stringWithFormat:@"%d.%d分", seconds/60, n]];
    } else {
        [todayStudyTLab setText:[NSString stringWithFormat:@"%d.0%d分", seconds/60, n]];
    }
    
    [countOfReadedLab setText:[NSString stringWithFormat:@"%d", [VOAView countOfReaded]]];
    switch ([VOAView findLoveClass]) {
        case 1:
            [loveClassLab setText:[NSString stringWithFormat:@"%@", kClassTwo]];
            break;
        case 2:
            [loveClassLab setText:[NSString stringWithFormat:@"%@", kClassThree]];
            break;
        case 3:
            [loveClassLab setText:[NSString stringWithFormat:@"%@", kClassFour]];
            break;
        case 4:
            [loveClassLab setText:[NSString stringWithFormat:@"%@", kClassFive]];
            break;
        case 5:
            [loveClassLab setText:[NSString stringWithFormat:@"%@", kClassSix]];
            break;
        case 6:
            [loveClassLab setText:[NSString stringWithFormat:@"%@", kClassSeven]];
            break;
        case 7:
            [loveClassLab setText:[NSString stringWithFormat:@"%@", kClassEight]];
            break;
        case 8:
            [loveClassLab setText:[NSString stringWithFormat:@"%@", kClassNine]];
            break;
        case 9:
            [loveClassLab setText:[NSString stringWithFormat:@"%@", kClassTen]];
            break;
        default:
            break;
    }
    [countOfCollectVoaLab setText:[NSString stringWithFormat:@"%d", [VOAFav countOfCollected]]];
    [countOfCollectSenLab setText:[NSString stringWithFormat:@"%d", [VOASentence countOfCollected]]];
    [countOfCollectWordLab setText:[NSString stringWithFormat:@"%d", [VOAWord countOfCollected]]];
    [avgOfRemWordLab setText:[NSString stringWithFormat:@"%.2f", [VOAWord countOfRemember]]];
    NSMutableArray *myArray = [[NSMutableArray alloc] init];
    [VOAWord findWorstWords:myArray];
    NSMutableString *worstWord =[NSMutableString stringWithString:@""];
    for (int i= 0; i < myArray.count; i++) {
        [worstWord appendString:[NSString stringWithFormat:@" %@", [myArray objectAtIndex:i]]];
    }
    [remWorstWord setText:[NSString stringWithFormat:@"%@", worstWord]];
    [myArray release];
    if (nowUserID > 0 ) {
        [logBtn setHidden:YES];
        if (kNetIsExist) {
            [self catchInfors:nowUserID];
            [alertLab setText:kDIFive];
            [alertLab setHidden:NO];
            
        } else {
            [UserMessage findAllByUserId:nowUserID infors:inforArray];
            [msgTv reloadData];
            if ([inforArray count] == 0) {
                [alertLab setText:kDISix];
                [alertLab setHidden:NO];
                [editBtn setHidden:YES];
                [msgTv setHidden:YES];
                [disMsgLab setHidden:YES];
            } else {
                [alertLab setHidden:YES];
                [editBtn setHidden:NO];
                [msgTv setHidden:NO];
                [disMsgLab setHidden:NO];
            }
            
        }
    } else {
        [logBtn setHidden:NO];
        [alertLab setHidden:YES];
    }
}

- (void)viewDidUnload {
    self.inforScroll = nil;
    self.appScroll = nil;
    self.recordView = nil;
    self.appView = nil;
    self.avgOfDayStudyTLab = nil;
    
    self.todayStudyTLab = nil;
    self.countOfReadedLab = nil;
    self.loveClassLab = nil;
    self.countOfCollectVoaLab = nil;
    self.countOfCollectSenLab = nil;
    self.countOfCollectWordLab = nil;
    self.avgOfRemWordLab = nil;
    self.remWorstWord = nil;
    
    self.img1 = nil;
    self.img2 = nil;
    self.img3 = nil;
    self.img4 = nil;
    self.img5 = nil;
    self.img6 = nil;
    self.img7 = nil;
    self.img8 = nil;
    self.img9 = nil;
    self.img10 = nil;
    self.img11 = nil;
    self.img12 = nil;
    self.img13 = nil;
    self.img14 = nil;
    self.img15 = nil;
    self.img16 = nil;
    self.img17 = nil;
    self.img18 = nil;
    self.img19 = nil;
    self.img20 = nil;
    self.img21 = nil;
    self.img22 = nil;
    self.img23 = nil;
    self.img24 = nil;
    self.img25 = nil;
    self.img26 = nil;
    self.img27 = nil;
    
    [segmentedControl release], segmentedControl = nil;
    [msgTv release], msgTv = nil;
    [disMsgLab release], disMsgLab = nil;
    [alertLab release], alertLab = nil;
    [inforArray release], inforArray = nil;
    [logBtn release], logBtn = nil;
    [editBtn release], editBtn = nil;
    
    [super viewDidUnload];
}

- (void)dealloc {
    [inforScroll release];
    [appScroll release];
    [recordView release];
    [appView release];
    [avgOfDayStudyTLab release];
    
    [todayStudyTLab release];
    [countOfReadedLab release];
    [loveClassLab release];
    [countOfCollectVoaLab release];
    [countOfCollectSenLab release];
    [countOfCollectWordLab release];
    [avgOfRemWordLab release];
    [remWorstWord release];
    
    [img1 release];
    [img2 release];
    [img3 release];
    [img4 release];
    [img5 release];
    [img6 release];
    [img7 release];
    [img8 release];
    [img9 release];
    [img10 release];
    [img11 release];
    [img12 release];
    [img13 release];
    [img14 release];
    [img15 release];
    [img16 release];
    [img17 release];
    [img18 release];
    [img19 release];
    [img20 release];
    [img21 release];
    [img22 release];
    [img23 release];
    [img24 release];
    [img25 release];
    [img26 release];
    [img27 release];
    
    [segmentedControl release];
    [msgTv release];
    [disMsgLab release];
    [alertLab release];
    [inforArray release];
    [logBtn release];
    [editBtn release];

    [super dealloc];
}

#pragma mark - My Action
- (void)photoTapped:(UIImageView *)sender
{
//    NSLog(@"111");
    switch (sender.tag) {
        case 1:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/ai-yu-ba-ting-ge-xue-ying-yu/id555917167?ls=1&mt=8"]];
            break;
        case 2:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/bright-ball-toys-english/id590220714?ls=1&mt=8"]];
            break;
            //                case 3:
            //                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=519013738"]];
            //                    break;
            //                case 4:
            //                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=519013738"]];
            //                    break;
            //                case 1:
            //                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=519013738"]];
            //                    break;
            //                case 1:
            //                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=519013738"]];
            //                    break;
            //                case 1:
            //                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=519013738"]];
            //                    break;
            //                case 1:
            //                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=519013738"]];
            //                    break;
            //                case 1:
            //                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=519013738"]];
            //                    break;
            //                case 1:
            //                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=519013738"]];
            //                    break;
            //                case 1:
            //                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=519013738"]];
            //                    break;
            //                case 1:
            //                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=519013738"]];
            //                    break;
            //                case 1:
            //                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=519013738"]];
            //                    break;
            //                case 1:
            //                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=519013738"]];
            //                    break;
        default:
            break;
    }
}

- (void)doSeg:(UISegmentedControl *)sender
{
    int page = sender.selectedSegmentIndex;
    CGRect frame = inforScroll.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [inforScroll scrollRectToVisible:frame animated:YES];
}

- (void)doLog {
    LogController *myLog = [[LogController alloc]init];
    [self.navigationController pushViewController:myLog animated:YES];
    [myLog release], myLog = nil;
}

- (void) doEdit{
    
	[msgTv setEditing:!msgTv.editing animated:YES];
    if (isiPhone) {
        if(msgTv.editing)
            [editBtn setImage:[UIImage imageNamed:@"messageDo.png"] forState:UIControlStateNormal];
        else
            [editBtn setImage:[UIImage imageNamed:@"messageDel.png"] forState:UIControlStateNormal];
    } else {
        if(msgTv.editing)
            [editBtn setImage:[UIImage imageNamed:@"messageDo-ipad.png"] forState:UIControlStateNormal];
        else
            [editBtn setImage:[UIImage imageNamed:@"messageDel-ipad.png"] forState:UIControlStateNormal];
    }
}

-(void)c
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    [alert release];
}

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
                myalert = [[UIAlertView alloc] initWithTitle:kInfoTwo message:kRegNine delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil,nil];
                [myalert show];
                [myalert release];
            }
            break;
        default:
            break;
    }
	return kNetIsExist;
}



#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView //明确cell数目
 numberOfRowsInSection:(NSInteger)section {
    return ([inforArray count] + 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    if (row == [inforArray count]) {
        static NSString *ThirdLevelCell= @"NewCellTwo";
        UITableViewCell *cellThree = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:ThirdLevelCell];
        if (!cellThree) {
            cellThree = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ThirdLevelCell] autorelease];
        }
        [cellThree setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cellThree setHidden:YES];
//        if (nowPage < totalPage) {
//            [self catchComments:++nowPage];
//        }
        return cellThree;
    } else {
//        UIFont *Courier = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:12];
//        UIFont *Courier = [UIFont systemFontOfSize:12];
        UIFont *CourierF = [UIFont systemFontOfSize:12];
        UIFont *CourierD = [UIFont systemFontOfSize:10];
//        UIFont *Couriera = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:15];
        UIFont *CourieraF = [UIFont systemFontOfSize:15];
        UIFont *CourieraD = [UIFont systemFontOfSize:12];
        static NSString *FirstLevelCell= @"CommentCell";
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:FirstLevelCell];
        if (!cell) {
            if (isiPhone) {
                cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FirstLevelCell] autorelease];
                
                UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 100, 25)];
                [nameLabel setBackgroundColor:[UIColor clearColor]];
                [nameLabel setFont:CourierF];
                [nameLabel setTag:1];
                [nameLabel setTextColor:[UIColor blackColor]];
                [nameLabel setNumberOfLines:2];
                [cell addSubview:nameLabel];
                [nameLabel release];
                
                UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(260, 0, 60, 25)];
                [dateLabel setBackgroundColor:[UIColor clearColor]];
                [dateLabel setFont:CourierD];
                [dateLabel setTag:2];
                [dateLabel setTextColor:[UIColor colorWithRed:71.0/255 green:71.0/255 blue:72.0/255 alpha:1.0f]];
                [dateLabel setNumberOfLines:2];
                [cell addSubview:dateLabel];
                [dateLabel release];
                
                UILabel *comLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 0, 135, 25)];
                [comLabel setBackgroundColor:[UIColor clearColor]];
                [comLabel setFont:CourierF];
                [comLabel setTag:3];
                [comLabel setTextColor:[UIColor colorWithRed:88.0/255 green:159.0/255 blue:210.0/255 alpha:1.0f]];
//                [comLabel setTextColor:[UIColor colorWithRed:0.28f green:0.28f blue:0.28f alpha:1.0f]];
                [comLabel setNumberOfLines:4];
                [comLabel setLineBreakMode:UILineBreakModeWordWrap];
                [cell addSubview:comLabel];
                [comLabel release];
                
                UIImageView *userImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
                [userImg setTag:4];
                [userImg whenTapped:^{
                    for (int i = 0; i < [inforArray count]; i++) {
                        UserMessage *userMsg = [inforArray objectAtIndex:i];
                        if (userMsg.msgId == userImg.superview.tag) {
                            SendMessageController *sendMsgController = [[SendMessageController alloc] init];
                            sendMsgController.userMsg = userMsg;
                            [self.navigationController pushViewController:sendMsgController animated:YES];
                            [sendMsgController release], sendMsgController = nil;
//                            NSLog(@"发信 %@", [NSString stringWithFormat:@"回复%@:", [inforArray objectAtIndex:i*8+1]]);
                        }
                    }
                }];
                [cell addSubview:userImg];
                [userImg release];
                
//                UIButton *reponseBtn = [[UIButton alloc] initWithFrame:CGRectMake(280, 20, 30, 20)];
//                [reponseBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
//                //                    [reponseBtn.titleLabel setTextColor:[UIColor blackColor]];
//                [reponseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//                [reponseBtn setTitle:kPlayNine forState:UIControlStateNormal];
//                //                    [reponseBtn setBackgroundColor:[UIColor whiteColor]];
//                [reponseBtn addTarget:self action:@selector(doResponse:) forControlEvents:UIControlEventTouchUpInside];
//                [reponseBtn setTag:4];
//                [cell addSubview:reponseBtn];
//                [reponseBtn release];
            }else {
                cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FirstLevelCell] autorelease];
                
                UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 120, 30)];
                [nameLabel setBackgroundColor:[UIColor clearColor]];
                [nameLabel setFont:CourieraF];
                [nameLabel setTag:1];
                [nameLabel setTextColor:[UIColor blackColor]];
                [nameLabel setNumberOfLines:2];
                [cell addSubview:nameLabel];
                [nameLabel release];
                
                UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(648, 10, 120, 30)];
                [dateLabel setBackgroundColor:[UIColor clearColor]];
                [dateLabel setFont:CourieraD];
                [dateLabel setTag:2];
                [dateLabel setTextColor:[UIColor colorWithRed:71.0/255 green:71.0/255 blue:72.0/255 alpha:1.0f]];
                [dateLabel setNumberOfLines:2];
                [cell addSubview:dateLabel];
                [dateLabel release];
                
                UILabel *comLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 10, 478, 30)];
                [comLabel setBackgroundColor:[UIColor clearColor]];
                [comLabel setFont:CourieraF];
                [comLabel setTextColor:[UIColor grayColor]];
                [comLabel setTag:3];
                [comLabel setTextColor:[UIColor colorWithRed:0.28f green:0.28f blue:0.28f alpha:1.0f]];
                [comLabel setNumberOfLines:4];
                [comLabel setLineBreakMode:UILineBreakModeWordWrap];
                [cell addSubview:comLabel];
                [comLabel release];
                
                UIImageView *userImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
                [userImg setTag:4];
                [userImg whenTapped:^{
                    for (int i = 0; i < [inforArray count]; i++) {
                        UserMessage *userMsg = [inforArray objectAtIndex:i];
                        if (userMsg.msgId == userImg.superview.tag) {
                            SendMessageController *sendMsgController = [[SendMessageController alloc] init];
                            sendMsgController.userMsg = userMsg;
                            [self.navigationController pushViewController:sendMsgController animated:YES];
                            [sendMsgController release], sendMsgController = nil;
                            //                            NSLog(@"发信 %@", [NSString stringWithFormat:@"回复%@:", [inforArray objectAtIndex:i*8+1]]);
                        }
                    }
                }];
                [cell addSubview:userImg];
                [userImg release];
            }
        }
        
        UserMessage *userMsg = [inforArray objectAtIndex:row];
        NSString *imgSrc = [NSString stringWithFormat:@"http://voa.iyuba.com/iyubaApi/account/image.jsp?uid=%d&size=small", userMsg.toUserId];
        for (UIView *nLabel in [cell subviews]) {
            if (nLabel.tag == 1) {
                [(UILabel*)nLabel setText:userMsg.toUserName];
            }
            if (nLabel.tag == 2) {
                [(UILabel*)nLabel setText:userMsg.createDate];
            }
            if (nLabel.tag == 3) {
                [(UILabel*)nLabel setText:userMsg.comment];
                if (userMsg.flag == 1) {
                    [(UILabel*)nLabel  setTextColor:[UIColor colorWithRed:88.0/255 green:159.0/255 blue:210.0/255 alpha:1.0f]];
                } else {
                    [(UILabel*)nLabel  setTextColor:[UIColor grayColor]];
                }
            }
            if (nLabel.tag == 4) {
                [(UIImageView*)nLabel setImageWithURL:[NSURL URLWithString:imgSrc] placeholderImage:[UIImage imageNamed:@"acquiesce.png"]];
                //                    NSLog(@"cell:%d", [[commArray objectAtIndex:row*5] integerValue]);
            }
        }
        
//        [cell.imageView setImageWithURL:[inforArray objectAtIndex:row*8+2] placeholderImage:[UIImage imageNamed:@"acquiesce.png"]];
        [cell setTag:userMsg.msgId];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    //    }
    
    return nil;
}

#pragma mark -
#pragma mark TableView Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ([indexPath row] < [inforArray count] ? (isiPhone?25.f:50.f) : 1);
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if ([keyCommFd isFirstResponder]) {
    [self.view endEditing:YES];
    UserMessage *userMsg = [inforArray objectAtIndex:indexPath.row];
    //    }
    [UserMessage readedById:userMsg.msgId];
    [self readInfors:userMsg.msgId];
    int voaid = userMsg.topicId;
//    NSLog(@"topicId:%i", voaid);
    if (voaid > 0) {
        toVoaid = voaid;
        [disMsgLab setText:[NSString stringWithFormat:@"%@ #进入文章 ", userMsg.comment]];
    } else {
        [disMsgLab setText:userMsg.comment];
    }
    [(UserMessage *)[inforArray objectAtIndex:indexPath.row] setFlag:0];
    [msgTv reloadData];
//    if (![explainView isHidden]) {
//        [explainView setHidden:YES];
//        [myHighLightWord setHidden:YES];
//    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserMessage *userMsg = [inforArray objectAtIndex:indexPath.row];
    [self deleteInfors:userMsg.msgId];
    [UserMessage deleteById:userMsg.msgId];
    [inforArray removeObjectAtIndex:indexPath.row];
	[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    if (isiPhone) { //动态改变表的大小，防止背景出现灰色
        if ([inforArray count]<(isiPhone5?8:10)) {
            [self.msgTv setFrame:CGRectMake(640, 35, 320, [inforArray count]*25.f)];
            //                NSLog(@"表高:%f", [commArray count]/4*kCommTableHeightPh);
        }
        else {
            [self.msgTv setFrame:CGRectMake(640, 35, 320, 200 + kFiveAddHalf)];
        }
    } else {
        if ([inforArray count]<10) {
            [self.msgTv setFrame:CGRectMake(1536, 70, 768, [inforArray count]*50.f)];
            //                NSLog(@"表高:%f", [commArray count]/4*kCommTableHeightPh);
        }
        else {
            [self.msgTv setFrame:CGRectMake(1536, 70, 768, 500)];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleDelete;
}

#pragma mark - Http connect
- (void)catchVoa:(NSInteger)voaid {
    NSString *url = [NSString stringWithFormat:@"http://voa.iyuba.com/voa/UnicomApi?protocol=20003&voaid=%i&version=1x&format=xml", voaid];
//    NSLog(@"url:%@", url);
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    //    [sendBtn setUserInteractionEnabled:NO];
    request.delegate = self;
    [request setUsername:@"voaTitle"];
    [request startSynchronous];
}

- (void)catchInfors:(NSInteger)userId {
    NSString *url = [NSString stringWithFormat:@"http://apps.iyuba.com/voa/updateMail.jsp?userId=%d&groupName=Iyuba&mod=select&topicId=0&pageCounts=9999", userId];
    //    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    NSLog(@"url:%@", url);
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
//    [sendBtn setUserInteractionEnabled:NO];
    request.delegate = self;
    [request setUsername:@"infor"];
    [request startAsynchronous];
}

- (void)readInfors:(NSInteger)msgId {
    int nowUserID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    NSString *url = [NSString stringWithFormat:@"http://apps.iyuba.com/voa/updateMail.jsp?userId=%i&groupName=Iyuba&mod=read&id=%i", nowUserID, msgId];
    //    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    NSLog(@"url:%@", url);
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    //    [sendBtn setUserInteractionEnabled:NO];
    request.delegate = self;
    request.tag = msgId;
    [request setUsername:@"rdInfor"];
    [request startAsynchronous];
}

- (void)deleteInfors:(NSInteger)msgId {
    int nowUserID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    NSString *url = [NSString stringWithFormat:@"http://apps.iyuba.com/voa/updateMail.jsp?userId=%i&groupName=Iyuba&mod=delete&id=%i", nowUserID, msgId];
    //    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    NSLog(@"url:%@", url);
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    //    [sendBtn setUserInteractionEnabled:NO];
    request.delegate = self;
    request.tag = msgId;
    [request setUsername:@"deInfor"];
    [request startAsynchronous];
}

- (void)catchDetails:(VOAView *) voaid
{
//    NSLog(@"获取内容-%d",voaid._voaid);
    NSString *url = [NSString stringWithFormat:@"http://apps.iyuba.com/voa/textApi.jsp?voaid=%d&format=xml",voaid._voaid];
    //    NSLog(@"catch:%d",voaid._voaid);
    //    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    request.delegate = self;
    [request setUsername:@"detail"];
    [request setTag:voaid._voaid];
    [request startSynchronous];
    //    [request release];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        kNetTest;
    });
    if ([request.username isEqualToString:@"infor"]) {
//        [sendBtn setUserInteractionEnabled:YES];
//        [self.commTableView setFrame:(isiPhone? CGRectMake(0, 0, 320, 0) : CGRectMake(0, 0, 768, 0))];
//        [alertLab setText:kNewSix];
//        [alertLab setHidden:NO];
        int nowUserID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
        [UserMessage findAllByUserId:nowUserID infors:inforArray];
        [msgTv reloadData];
        if ([inforArray count] == 0) {
            [alertLab setText:kDISix];
            [alertLab setHidden:NO];
            [editBtn setHidden:YES];
            [msgTv setHidden:YES];
            [disMsgLab setHidden:YES];
        } else {
            [alertLab setHidden:YES];
            [editBtn setHidden:NO];
            [msgTv setHidden:NO];
            [disMsgLab setHidden:NO];
        }
    }
    else if([request.username isEqualToString:@"rdInfor"]) {
        [UserMessage alterFlgReadedById:request.tag];
    }
    else if([request.username isEqualToString:@"deInfor"]) {
        [UserMessage alterFlgDeleteById:request.tag];
    }
    else if([request.username isEqualToString:@"detail"]) {
        UIAlertView * alertOne = [[UIAlertView alloc] initWithTitle:kColFour message:kNewSix delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertOne show];
        [alertOne release];
        [HUD hide:YES];
    }
    else if([request.username isEqualToString:@"voaTitle"]) {
        alert = [[UIAlertView alloc] initWithTitle:kDIEight message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        
        [alert setBackgroundColor:[UIColor clearColor]];
        
        [alert setContentMode:UIViewContentModeScaleAspectFit];
        
        [alert show];
        
        [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(c) userInfo:nil repeats:NO];
        return;
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    kNetEnable;
    rightCharacter = NO;
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];
    if ([request.username isEqualToString:@"infor"]) {
        /////解析
//        [sendBtn setUserInteractionEnabled:YES];
//        NSArray *items = [doc nodesForXPath:@"response" error:nil];
//        if (items) {
//            for (DDXMLElement *obj in items) {
//                nowPage = [[[obj elementForName:@"pageNumber"] stringValue] integerValue] ;
//                //                NSLog(@"pageNumber:%d",pageNumber);
//                
//                
//                if (nowPage == 1) {
//                    [commArray removeAllObjects];
//                    //                    NSInteger commcount = [[[obj elementForName:@"counts"] stringValue] integerValue] ;
//                    totalPage = [[[obj elementForName:@"totalPage"] stringValue] integerValue] ;
//                    //                    NSLog(@"commcount:%d",commcount);
//                    //                    commArray = [[NSMutableArray alloc]initWithCapacity:4*commcount];
//                    //                    struct comment comms[commNumber];
//                }
//            }
//        }
        NSArray *items = [doc nodesForXPath:@"response/row" error:nil];
        if (items) {
            int nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
            NSString *nowUserName = [MyUser findNameById:nowUserId];
            [inforArray removeAllObjects];
            for (DDXMLElement *obj in items) {
//                [inforArray addObject:[[obj elementForName:@"id"] stringValue]];
//                [inforArray addObject:[[obj elementForName:@"userName"] stringValue]];
//                [inforArray addObject:[[obj elementForName:@"imgSrc"] stringValue]];
//                [inforArray addObject:[[obj elementForName:@"shuoShuo"] stringValue]];
//                [inforArray addObject:[[obj elementForName:@"createDate"] stringValue]];
//                [inforArray addObject:[[obj elementForName:@"topicId"] stringValue]];
//                [inforArray addObject:[[obj elementForName:@"userId"] stringValue]];
//                [inforArray addObject:[[obj elementForName:@"flg"] stringValue]];
                UserMessage *userMsg = [[UserMessage alloc] initWithMsgId:[[obj elementForName:@"id"] stringValue].integerValue fromUserId:nowUserId fromUserName:nowUserName toUserId:[[obj elementForName:@"userId"] stringValue].integerValue toUserName:[[obj elementForName:@"userName"] stringValue] comment:[[obj elementForName:@"shuoShuo"] stringValue] createDate:[[obj elementForName:@"createDate"] stringValue] topicId:[[obj elementForName:@"topicId"] stringValue].integerValue flag:[[obj elementForName:@"flg"] stringValue].integerValue];
                [inforArray addObject:userMsg];
                if (![UserMessage isExist:userMsg.msgId]) {
                    [userMsg insert];
                }
                [userMsg release], userMsg = nil;
            }
        }
        //         NSLog(@"评论数：%i---表高:%f", [commArray count], [commArray count]*kCommTableHeightPh);
        if (isiPhone) { //动态改变表的大小，防止背景出现灰色
            if ([inforArray count]<(isiPhone5?8:10)) {
                [self.msgTv setFrame:CGRectMake(640, 35, 320, [inforArray count]*25.f)];
                //                NSLog(@"表高:%f", [commArray count]/4*kCommTableHeightPh);
            }
            else {
                [self.msgTv setFrame:CGRectMake(640, 35, 320, 200 + kFiveAddHalf)];
            }
        } else {
            if ([inforArray count]<10) {
                [self.msgTv setFrame:CGRectMake(1536, 70, 768, [inforArray count]*50.f)];
                //                NSLog(@"表高:%f", [commArray count]/4*kCommTableHeightPh);
            }
            else {
                [self.msgTv setFrame:CGRectMake(1536, 70, 768, 500)];
            }
        }
        
        [msgTv reloadData];
        [alertLab setHidden:YES];
        [editBtn setHidden:NO];
        [msgTv setHidden:NO];
        [disMsgLab setHidden:NO];
        
//        if (isNewComm) {
//            [self.commTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//            isNewComm = NO;
//        }
        //        int i = 0;
        //        NSLog(@"count：%i",[commArray count]);
        //        for (; i< [commArray count]; i++) {
        //            NSLog(@"%i:%@",i,[commArray objectAtIndex:i]);
        //        }
    }
    else if ([request.username isEqualToString:@"rdInfor" ]) {
        NSArray *items = [doc nodesForXPath:@"response" error:nil];
        if (items) {
            for (DDXMLElement *obj in items) {
                int result = [[[obj elementForName:@"result"] stringValue] integerValue] ;
                if (result != 1) {
                    [UserMessage alterFlgReadedById:request.tag];
                }
            }
        }
    }
    else if ([request.username isEqualToString:@"deInfor" ]) {
        NSArray *items = [doc nodesForXPath:@"response" error:nil];
        if (items) {
            for (DDXMLElement *obj in items) {
                int result = [[[obj elementForName:@"result"] stringValue] integerValue] ;
                if (result != 1) {
                    [UserMessage alterFlgDeleteById:request.tag];
                }
            }
        }
    }
    else if ([request.username isEqualToString:@"detail"]) {
        NSArray *items = [doc nodesForXPath:@"data/voatext" error:nil];
        if (items) {
            rightCharacter = YES;
            for (DDXMLElement *obj in items) {

                //                    NSLog(@"222");
                VOADetail *newVoaDetail = [[VOADetail alloc] init];
                newVoaDetail._voaid = request.tag ;
                //                    NSLog(@"id:%d",newVoaDetail._voaid);
                newVoaDetail._paraid = [[[obj elementForName:@"ParaId"] stringValue]integerValue];
                newVoaDetail._idIndex = [[[obj elementForName:@"IdIndex"] stringValue]integerValue];
                newVoaDetail._timing = [[[obj elementForName:@"Timing"] stringValue]integerValue];
                newVoaDetail._sentence = [[[[obj elementForName:@"Sentence"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"]stringByReplacingOccurrencesOfString:@"<b>" withString:@""];
                newVoaDetail._imgWords = [[[obj elementForName:@"ImgWords"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
                newVoaDetail._imgPath = [[obj elementForName:@"ImgPath"] stringValue];
                newVoaDetail._sentence_cn = [[[[[obj elementForName:@"sentence_cn"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"] stringByReplacingOccurrencesOfString:@"<b>" withString:@""] stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
                if ([newVoaDetail insert]) {
//                    NSLog(@"插入%d成功",newVoaDetail._voaid);
                }
                [newVoaDetail release],newVoaDetail = nil;
                
            }
            
        }
    } else if ([request.username isEqualToString:@"voaTitle" ]) {
        /////解析
        
//        NSArray *items = [doc nodesForXPath:@"data" error:nil];
        //        if (items) {
        //            for (DDXMLElement *obj in items) {
        //                NSInteger total = [[[obj elementForName:@"total"] stringValue] integerValue] ;
        //                NSLog(@"total:%d",total);
        //            }
        //        }
        NSArray *items = [doc nodesForXPath:@"voaTitle" error:nil];
        if (items) {
//            NSLog(@"come into");
            rightCharacter = YES;
//            BOOL flushList = NO;
            for (DDXMLElement *obj in items) {
                VOAView *newVoa = [[VOAView alloc] init];
                newVoa._voaid = [[[obj elementForName:@"Voaid"] stringValue] integerValue] ;
//                NSLog(@"newVoa._voaid:%i", newVoa._voaid);
                newVoa._title = [[obj elementForName:@"Title"] stringValue];
//                NSLog(@"newVoa._title:%@", newVoa._title);
                newVoa._descCn = [[[obj elementForName:@"DescCn"] stringValue] stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
                newVoa._title_Cn = [[[obj elementForName:@"Title_Cn"] stringValue] isEqualToString: @" null"] ? nil :[[obj elementForName:@"Title_Cn"] stringValue];
//                NSLog(@"Title_cn:%@", newVoa._title_Cn);
                newVoa._category = [[obj elementForName:@"Category"] stringValue];
                newVoa._sound = [[obj elementForName:@"Sound"] stringValue];
                newVoa._url = [[obj elementForName:@"Url"] stringValue];
                newVoa._pic = [[obj elementForName:@"Pic"] stringValue];
                newVoa._creatTime = [[obj elementForName:@"CreatTime"] stringValue];
                newVoa._publishTime = [[[obj elementForName:@"PublishTime"] stringValue] isEqualToString:@" null"]? nil :[[obj elementForName:@"PublishTime"] stringValue];
                newVoa._readCount = [[obj elementForName:@"ReadCount"] stringValue];
                newVoa._hotFlg = [[obj elementForName:@"Hotflg"] stringValue];
                newVoa._isRead = @"0";
                if ([VOAView isExist:newVoa._voaid] == NO) {
                    [newVoa insert];
                    //                    [self catchDetails:newVoa];
//                    flushList = YES;
//                    NSLog(@"插入%d成功",newVoa._voaid);
                }else {
                    if (newVoa._readCount.integerValue > [[VOAView find:newVoa._voaid] _readCount].integerValue) {
                        [VOAView alterReadCount:newVoa._voaid count:newVoa._readCount.integerValue];
                    }
                    
                    //                    NSLog(@"已有");
                }
                [newVoa release],newVoa = nil;
            }
        }
    }
    
    [doc release], doc = nil;
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    [HUD release];
	HUD = nil;
}

#pragma mark - AlertDelegate
- (void)modalView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {//点击确定下载为0，取消为1
        //        if (alertView.tag == 1) {
        //        }
        //        else if (alertView.tag == 2){
        //        }
        //        else if (alertView.tag == 3)
        //        {
        //            LogController *myLog = [[LogController alloc]init];
        //            [self.navigationController pushViewController:myLog animated:YES];
        //            [myLog release], myLog = nil;
        //        }
    } else if (buttonIndex == 1) {
        if (alertView.tag == 1){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://apps.iyuba.com/voa/showItem.jsp?voaId=%i", toVoaid]]];
        }
    }
    [alertView release];
}


#pragma mark -
#pragma mark STLink Protocol
//点击@开头空格结尾的字符串的响应事件
- (void)twitterAccountClicked:(NSString *)link {
    
}
//点击#开头空格结尾的字符串的响应事件
- (void)twitterHashtagClicked:(NSString *)link {
//    NSLog(@"toVoaid:%i", toVoaid);
    rightCharacter = YES;
    if (![VOAView isExist:toVoaid]) {
        rightCharacter = NO;
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:kColFour message:kDINine delegate:self cancelButtonTitle:kAppThree otherButtonTitles:kAppFive, nil ];
        [myAlert setTag:1];
        [myAlert show];
//        if (kNetIsExist) {
//            [self catchVoa:toVoaid];
//        } else {
//            alert = [[UIAlertView alloc] initWithTitle:kDISeven message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
//            
//            [alert setBackgroundColor:[UIColor clearColor]];
//            
//            [alert setContentMode:UIViewContentModeScaleAspectFit];
//            
//            [alert show];
//            
//            NSTimer *timer = nil;
//            timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(c) userInfo:nil repeats:NO];
//        }
    }
    if (!rightCharacter) {
        return;
    }
    VOAView *voa = [VOAView find:toVoaid];//!!!!!!
//    NSLog(@"voa._voaid:%i", voa._voaid);
    if ([voa._pic isEqualToString:@""] || [voa._pic isEqualToString:@"null"] || voa._pic == nil) {
        [VOAView deleteByVoaid:voa._voaid];
//    } else {
    }
    if ([VOADetail isExist:voa._voaid] || [self isExistenceNetwork:1]) {
        //            HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
        //            HUD.dimBackground = YES;
        //            HUD.labelText = @"connecting!";
        HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow ];
        [[UIApplication sharedApplication].keyWindow addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"Loading";
        HUD.dimBackground = YES;
        [HUD show:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                VOADetail *myDetail = [VOADetail find:voa._voaid];
                if (!myDetail) {
                    //  NSLog(@"内容不全-%d",voa._voaid);
                    
                    if (kNetIsExist) {
                        [VOADetail deleteByVoaid: voa._voaid];
                        //                                        NSLog(@"voaid:%i",voa._voaid);
                        [self catchDetails:voa];
                    }else {
                        
                        rightCharacter = NO;
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            kNetTest;
                        });
                    }
                }else {
                    //                        [myDetail release];
                    rightCharacter = YES;
                }//获取所选的cell的数据
                if (rightCharacter) {
                    //                                NSLog(@"内容完整-%d",voa._voaid);
                    //                                if ([VOADetail find:voa._voaid]) {
                    PlayViewController *play = [PlayViewController sharedPlayer];//新建新界面的controller实例
                    //                                                    play.isExisitNet = isExisitNet;
                    if(play.voa._voaid == voa._voaid)
                    {
                        play.newFile = NO;
                    }else
                    {
                        play.newFile = YES;
                        play.voa = voa;
                    }
                    voa._isRead = @"1";//保证界面上显示已读
                    if (!(play.contentMode == 1 && play.category == 0)) {
                        play.flushList = YES;
                        play.contentMode = 1;
                        play.category = 0;
                    }
                    play.isInforComm = YES;
                    [play setHidesBottomBarWhenPushed:YES];//设置推到新界面时无bottomBar
                    [self.navigationController pushViewController:play animated:NO];
                    [HUD hide:YES];
                    //                                }
                }else {
                    [HUD hide:YES];
                    UIAlertView *addAlert = [[UIAlertView alloc] initWithTitle:kColFour message:kNewFive delegate:self cancelButtonTitle:kWordFour otherButtonTitles:nil ,nil];
                    [addAlert show];
                    [addAlert release];
                }
            });
        });
    }
//    }
}
//点击网页链接的响应事件
- (void)websiteClicked:(NSString *)link {
    
}

@end
