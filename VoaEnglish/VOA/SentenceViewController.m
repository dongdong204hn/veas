//
//  SentenceViewController.m
//  VOA
//
//  Created by iyuba on 12-11-21.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "SentenceViewController.h"
#import "JMWhenTapped.h"

@interface SentenceViewController ()

@end

@implementation SentenceViewController
@synthesize row;
@synthesize SenEn;
@synthesize SenCn;
@synthesize HUD;
@synthesize nowUserId;
@synthesize sentences;
@synthesize myImageView;
@synthesize explainView;
@synthesize isiPhone;
@synthesize myHighLightWord;
@synthesize myWord;
@synthesize wordPlayer;

#pragma mark - View lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
	if ([Constants isPad]) {
        self = [super initWithNibName:@"SentenceViewController-iPad" bundle:nibBundleOrNil];
	}else {
        self = [super initWithNibName:@"SentenceViewController" bundle:nibBundleOrNil];
    }

    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        kNetTest;
    });
    self.navigationController.navigationBarHidden=NO;
    nowUserId = 0;
    nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    sentences = [[VOASentence findSentences:nowUserId] retain];
    VOASentence *voaSen = [sentences objectAtIndex:row];
    VOAView *voa = [VOAView find:voaSen.VoaId];
   
    NSURL *url = [NSURL URLWithString: voa._pic];
    [myImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"acquiesce.png"]];
    SenEn.text = voaSen.Sentence;
    SenCn.text = voaSen.Sentence_cn;
    self.title = [NSString stringWithFormat:@"%@%d/%d%@",kSentenceThree ,row + 1,[sentences count], kSentenceFour];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [SenEn whenTapped:^{
//        NSLog(@"juzi diandian");
//        [self screenTouchWord: SenEn];
//    }];
    
    isiPhone = ![Constants isPad];
    
    SenEn.myDelegate = self;
    
    explainView = [[MyLabel alloc]init];
    myHighLightWord = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    myWord = [[VOAWord alloc]init];
    
    explainView.tag = 2000;
//    explainView.delegate = self;
    if (isiPhone) {
        [explainView setFrame:CGRectMake(0, 100, 320, 240)];
    }else {
        [explainView setFrame:CGRectMake(144, 220, 480, 360)];
        explainView.layer.cornerRadius = 20.0;
    }
    
    [explainView setHidden:YES];
    [self.view addSubview:explainView];
    [explainView release];
    
    [myHighLightWord setHidden:YES];
    [myHighLightWord setTag:1000];
    [myHighLightWord setAlpha:0.5];
}

- (void)viewDidUnload {
    self.SenEn = nil;
    self.SenCn = nil;
    self.myImageView = nil;
    
    [sentences release], sentences = nil;
//    [explainView release], explainView = nil;
    [myWord release], myWord = nil;
    [myHighLightWord release], myHighLightWord = nil;
    [super viewDidUnload];
}

- (void)dealloc
{
    SenEn.myDelegate = nil;
    [SenEn release];
    [SenCn release];
    [myImageView release];
    [sentences release];
//    [explainView release];
    [myWord release];
    [myHighLightWord release];
    
    for (UIView *sView in [explainView subviews]) {
        if (![sView isKindOfClass:[UIImageView class]]) {
            [sView removeFromSuperview];
        }
    }
    [SentenceViewController releaseSharedQueue];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark MyTextViewDelegate
- (void)catchTouches:(NSSet *)touches myTextView:(MyTextView *)myTextView {
    int lineHeight = [@"a" sizeWithFont:myTextView.font].height;
    int LineStartlocation = 0;
    if (myTextView.tag == 2000) {
        [explainView setHidden:YES];
        [myHighLightWord setHidden:YES];
        return;
    }
    if (![explainView isHidden]) {
        [explainView setHidden:YES];
        [myHighLightWord setHidden:YES];
    }
    //    NSLog(@"取词:%@",mylabel.text);
    NSString * WordIFind = nil;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    int tagetline =0;
    CGSize maxSize = CGSizeZero;
    if (isiPhone) {
        tagetline = ceilf((point.y- 124 - 8)/lineHeight);
    } else {
        tagetline = ceilf((point.y- 225 - 8)/lineHeight);
    }
    maxSize = CGSizeMake(myTextView.frame.size.width - 20, CGFLOAT_MAX);
    
    //    NSLog(@"x:%f,y:%f",point.x,point.y);
    //    int fontSize = [[NSUserDefaults standardUserDefaults] integerForKey:@"nowValueFont"];
    //    NSLog(@"nowValueFont:%d",fontSize);
    //    UIFont *Courier = [UIFont fontWithName:@"Courier" size:fontSize];
    
    //    int numberoflines = self.frame.size.height / lineHeight;
    //    int tagetline = ceilf((point.y- mylabel.frame.origin.y)/lineHeight);
    NSString * sepratorString = @", ，。.?!:\"“”-()'‘";
    //    NSString * text = @"...idowrhu wpe gre dddd.. 'eow.ei, we u";
    NSCharacterSet * sepratorSet = [NSCharacterSet characterSetWithCharactersInString:sepratorString];
    NSArray * splitStr = [myTextView.text componentsSeparatedByCharactersInSet:sepratorSet];
    //    NSArray * splitStr = [self.text componentsSeparatedByString:@" "];
    int WordIndex = 0;
    int count = [splitStr count];
    BOOL WordFound = NO;
    NSString * string = @"";
    NSString * string2 = @"";
    
    for (int i = 0; i < count && !WordFound; i++) {
        @try {//??
            string = [string stringByAppendingString:[NSString stringWithFormat:@"%@.",[splitStr objectAtIndex:i]]];
            
            NSString * substr = [myTextView.text substringWithRange:NSMakeRange(LineStartlocation, [string length])];
            CGSize mysize = [substr sizeWithFont:myTextView.font constrainedToSize:maxSize];
            
            if (mysize.height/lineHeight == tagetline && !WordFound) {
                LineStartlocation = [string length] - [[splitStr objectAtIndex:i] length] - 1;
                for (; i < count; i++) {
                    
                    string2 = [string2 stringByAppendingString:[NSString stringWithFormat:@"%@.",[splitStr objectAtIndex:i]]];
                    NSString * substr2 = nil;
                    @try {
                        substr2 = [myTextView.text substringWithRange:NSMakeRange(LineStartlocation, [string2 length])];
                    }
                    @catch (NSException *exception) {
                        
                        return;
                    }
                    
                    
                    CGSize thissize = [substr2 sizeWithFont:myTextView.font constrainedToSize:maxSize];
                    if (thissize.height/lineHeight > 1) {
                        return;
                    }
                    
                    if (thissize.width > (isiPhone? point.x-43:point.x-80)) {
                        
                        WordIndex = i;
                        WordFound = YES;
                        break;
                    }
                }
            }
        }
        @catch (NSException *exception) {
        }
    }
    if (WordFound) {
        WordIFind = [splitStr objectAtIndex:WordIndex];
        if ([WordIFind isEqualToString:@""] || WordIFind == nil) {//??
            return ;
        }
        CGFloat pointY = (tagetline -1 ) * lineHeight;
        CGFloat width = [[splitStr objectAtIndex:WordIndex] sizeWithFont:myTextView.font].width;
        
        NSRange Range1 = [string2 rangeOfString:[splitStr objectAtIndex:WordIndex] options:NSBackwardsSearch];
        
        
        NSString * str = [string2 substringToIndex:Range1.location];
        int i = 0;
        while ([[str substringToIndex:i] isEqual:@"."]) {
            str = [str substringFromIndex:i+1];
            i++;
            
        }
        
        CGFloat pointX = [str sizeWithFont:myTextView.font].width;
        //        if (readRecord) {
        //            pointX = [str sizeWithFont:mylabel.font].width;
        //        }
        
        //        if (wordBack) {
        //            [wordBack removeFromSuperview];
        //            wordBack = nil;
        //        }
        LocalWord *word = [LocalWord findByKey:WordIFind];
        myWord.wordId = [VOAWord findLastId] + 1;
        nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
        myWord.userId = nowUserId;
        //        NSLog(@"%@", WordIFind);
        
        if (kNetIsExist) {
            //            NSLog(@"有网");
            [self catchWords:WordIFind];
        } else {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                kNetTest;
            });
            if (([[NSUserDefaults standardUserDefaults] boolForKey:kBePro] || [[NSUserDefaults standardUserDefaults] boolForKey:@"isVip"])  && word) {
                //        if (word) {
                //            if (word) {
                //            myWord.wordId = [VOAWord findLastId] + 1;
                myWord.key = word.key;
                myWord.audio = word.audio;
                myWord.pron = [NSString stringWithFormat:@"%@",word.pron] ;
                if (myWord.pron == nil) {
                    myWord.pron = @" ";
                }
                myWord.def = [[word.def stringByReplacingOccurrencesOfRegex:@"\\s+" withString:@""]stringByReplacingOccurrencesOfString:@"null" withString:@""];
                //                [word release];
                [self wordExistDisplay];
                //            }
            } else {
                myWord.key = WordIFind;
                myWord.audio = @"";
                myWord.pron = @" ";
                myWord.def = @"";
                [self wordNoDisplay];
            }
        }
        
        //        [self catchWords:WordIFind];
        
        [myHighLightWord setFrame:CGRectMake(pointX + 8, pointY + 8, width+2, lineHeight)];
        [myHighLightWord setHidden:NO];
        [myHighLightWord setAlpha:0.5];
        [myHighLightWord setHighlighted:YES];
        [myHighLightWord setHighlightedTextColor:[UIColor whiteColor]];
        [myHighLightWord setBackgroundColor:[UIColor colorWithRed:1.0/255 green:151.0/255 blue:211.0/255 alpha:1]];
        
        [myTextView addSubview:myHighLightWord];
        
        //        [myHighLightWord setHidden:NO];
        
        //        wordBack = [[UIView alloc] initWithFrame:CGRectMake(pointX, pointY, width, lineHeight)];
        //        wordBack.backgroundColor = [UIColor colorWithRed:1.0 green:0.651 blue:0.098 alpha:0.5];
        //        [self insertSubview:wordBack atIndex:0];
        //        [self GetExplain:WordIFind];
    }
}

#pragma mark - Touch screen
/**
 *  点击主视图
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![explainView isHidden]) {
        [explainView setHidden:YES];
        [myHighLightWord setHidden:YES];
    }
}

#pragma mark - Actions
/**
 *  切换前一句
 */
- (IBAction)preSen:(id)sender
{
    if (![explainView isHidden]) {
        [explainView setHidden:YES];
        [myHighLightWord setHidden:YES];
    }
    if (row<=0) {
        row = [sentences count]-1;
    }
    else{
        row--;
    }
    VOASentence  *voaSen = [sentences objectAtIndex:row];
    SenEn.text = voaSen.Sentence;
    SenCn.text = voaSen.Sentence_cn;
    VOAView *voa = [VOAView find:voaSen.VoaId];
    NSURL *url = [NSURL URLWithString: voa._pic];
    [myImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"acquiesce.png"]];
    self.title = [NSString stringWithFormat:@"%@%d/%d%@",kSentenceThree, row + 1,[sentences count], kSentenceFour];
}

/**
 *  切换后一句
 */
- (IBAction)nextSen:(id)sender
{
    if (![explainView isHidden]) {
        [explainView setHidden:YES];
        [myHighLightWord setHidden:YES];
    }
    if (row>=[sentences count]-1) {
        row = 0;
    } else {
        row ++;        
    }
    VOASentence  *voaSen = [sentences objectAtIndex:row];
    
    SenEn.text = voaSen.Sentence;
    SenCn.text = voaSen.Sentence_cn;
    VOAView *voa = [VOAView find:voaSen.VoaId];
    NSURL *url = [NSURL URLWithString: voa._pic];
    [myImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"acquiesce.png"]];
    
    self.title = [NSString stringWithFormat:@"%@%d/%d%@",kSentenceThree, row + 1,[sentences count], kSentenceFour];
}


#pragma mark - Http Methods
/**
 *  获取下载队列
 */
+ (NSOperationQueue *)sharedQueue
{
    static NSOperationQueue *sharedSingleQueue;
    
    @synchronized(self)
    {
        if (!sharedSingleQueue){
            sharedSingleQueue = [[NSOperationQueue alloc] init];
            [sharedSingleQueue setMaxConcurrentOperationCount:1];
        }
        return sharedSingleQueue;
    }
}

/**
 *  释放下载队列
 */
+ (void)releaseSharedQueue
{
    static NSOperationQueue *sharedSingleQueue;
    
    @synchronized(self)
    {
        if (sharedSingleQueue){
             [sharedSingleQueue release], sharedSingleQueue = nil;
        }
    }
}

/**
 *  联网查词
 */
- (void)catchWords:(NSString *) word
{
    //    NSString *url = [NSString stringWithFormat:@"http://word.iyuba.com/words/apiWord.jsp?q=%@",word];
    //    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    //    request.delegate = self;
    //    [request setUsername:word];
    //    [request startAsynchronous];
    
    NSOperationQueue *myQueue = [SentenceViewController sharedQueue];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://word.iyuba.com/words/apiWord.jsp?q=%@",[ROUtility encodeString:word urlEncode:NSUTF8StringEncoding]]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request setUsername:word];
    //    [request setDidStartSelector:@selector(requestStarted:)];
    [request setDidFinishSelector:@selector(requestDone:)];
    [request setDidFailSelector:@selector(requestWentWrong:)];
    [myQueue addOperation:request]; //queue is an NSOperationQueue
}

/**
 *  查词出错
 */
- (void)requestWentWrong:(ASIHTTPRequest *)request
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        kNetTest;
    });
    if ([request.username isEqualToString:@"catchnet"]) {
        //        NSLog(@"有网络");
        //        isExisitNet = NO;
        return;
    }
    [myWord init];
    LocalWord *word = [LocalWord findByKey:request.username];
    myWord.wordId = [VOAWord findLastId] + 1;
    if (([[NSUserDefaults standardUserDefaults] boolForKey:kBePro] || [[NSUserDefaults standardUserDefaults] boolForKey:@"isVip"])  && word) {
        //        if (word) {
        //            if (word) {
        //            myWord.wordId = [VOAWord findLastId] + 1;
        myWord.key = word.key;
        myWord.audio = word.audio;
        myWord.pron = [NSString stringWithFormat:@"%@",word.pron] ;
        if (myWord.pron == nil) {
            myWord.pron = @" ";
        }
        myWord.def = [[word.def stringByReplacingOccurrencesOfRegex:@"\\s+" withString:@""]stringByReplacingOccurrencesOfString:@"null" withString:@""];
        //        [word release];
        [self wordExistDisplay];
        //            }
    } else {
        myWord.key = request.username;
        myWord.audio = @"";
        myWord.pron = @" ";
        myWord.def = @"";
        [self wordNoDisplay];
    }
}

/**
 *  查词成功
 */
- (void)requestDone:(ASIHTTPRequest *)request{
    kNetEnable;
    if ([request.username isEqualToString:@"catchnet"]) {
        //        NSLog(@"有网络");
        //        isExisitNet = YES;
        return;
    }
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];;
    [myWord init];
    int result = 0;
    NSArray *items = [doc nodesForXPath:@"data" error:nil];
    if (items) {
        for (DDXMLElement *obj in items) {
            NSMutableArray *eng = [[NSMutableArray alloc] init];
            NSMutableArray *chi = [[NSMutableArray alloc] init];
            myWord.wordId = [VOAWord findLastId]+1;
            myWord.checks = 0;
            myWord.remember = 0;
            myWord.userId = nowUserId;
            result = [[obj elementForName:@"result"] stringValue].intValue;
            if (result) {
                myWord.key = [[obj elementForName:@"key"] stringValue];
                myWord.audio = [[obj elementForName:@"audio"] stringValue];
                myWord.pron = [[obj elementForName:@"pron"] stringValue];
                if (myWord.pron == nil) {
                    myWord.pron = @" ";
                }
                myWord.def = [[[[obj elementForName:@"def"] stringValue] stringByReplacingOccurrencesOfRegex:@"\\s+" withString:@""]stringByReplacingOccurrencesOfString:@"null" withString:@""];
                NSArray *itemsOne = [doc nodesForXPath:@"data/sent" error:nil];
                if (itemsOne) {
                    //                        NSLog(@"4");
                    for (DDXMLElement *objOne in itemsOne) {
                        NSString *orig = [[[[[objOne elementForName:@"orig"] stringValue]stringByReplacingOccurrencesOfString:@"<em>" withString:@""] stringByReplacingOccurrencesOfString:@"</em>" withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                        //                        NSString * decodedText = [[NSString alloc] initWithUTF8String:[_feedback.text UTF8String]];
                        [eng addObject:orig.URLDecodedString];
                        NSString *trans = [[[objOne elementForName:@"trans"] stringValue] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                        [chi addObject:trans];
                        //                            NSLog(@"orig:%@", orig);
                        //                            NSLog(@"trans:%@", trans);
                    }
                }
                myWord.engArray = eng;
                
                myWord.chnArray = chi;
                
                [self wordExistDisplay];
                
            }else
            {
                [myWord init];
                LocalWord *word = [LocalWord findByKey:request.username];
                myWord.wordId = [VOAWord findLastId] + 1;
                if (([[NSUserDefaults standardUserDefaults] boolForKey:kBePro] || [[NSUserDefaults standardUserDefaults] boolForKey:@"isVip"])  && word) {
                    //        if (word) {
                    //            if (word) {
                    //            myWord.wordId = [VOAWord findLastId] + 1;
                    myWord.key = word.key;
                    myWord.audio = word.audio;
                    myWord.pron = [NSString stringWithFormat:@"%@",word.pron] ;
                    if (myWord.pron == nil) {
                        myWord.pron = @" ";
                    }
                    myWord.def = [[word.def stringByReplacingOccurrencesOfRegex:@"\\s+" withString:@""]stringByReplacingOccurrencesOfString:@"null" withString:@""];
                    //                    [word release];
                    [self wordExistDisplay];
                    //            }
                } else {
                    myWord.key = request.username;
                    myWord.audio = @"";
                    myWord.pron = @" ";
                    myWord.def = @"";
                    [self wordNoDisplay];
                }
            }
            [eng release], eng = nil;
            [chi release], chi = nil;
        }
    }
    [doc release];
}




#pragma mark - AlertDelegate
/**
 *  点击提示对话框各按钮响应事件
 */
- (void)modalView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {//点击确定下载为0，取消为1
        LogController *myLog = [[LogController alloc]init];
        [self.navigationController pushViewController:myLog animated:YES];
        [myLog release], myLog = nil;
    } 
    [alertView release];
}

#pragma mark - Word Display

/**
 *  关闭单词翻译标签
 */
- (void)closeExplaView {
    [explainView setHidden:YES];
    [myHighLightWord setHidden:YES];
}

/**
 *  添加生词本按钮响应事件
 */
- (void) addWordPressed:(UIButton *)sender
{
    nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    //    NSLog(@"生词本添加用户：%d",nowUserId);
    myWord.userId = nowUserId;
    if ([sender isSelected]) {
        [VOAWord deleteWord:myWord.key userId:nowUserId];
        
        if (isiPhone) {
            [sender setImage:[UIImage imageNamed:@"addWord.png"] forState:UIControlStateNormal];
        } else {
            [sender setImage:[UIImage imageNamed:@"addWord-iPad.png"] forState:UIControlStateNormal];
        }
        [sender setSelected:NO];
    } else {
        if (nowUserId>0) {
            if ([myWord alterCollect]) {
                if (isiPhone) {
                    [sender setImage:[UIImage imageNamed:@"addedWord.png"] forState:UIControlStateNormal];
                } else {
                    [sender setImage:[UIImage imageNamed:@"addedWord-iPad.png"] forState:UIControlStateNormal];
                }
                [sender setSelected:YES];
                
                //                alert = [[UIAlertView alloc] initWithTitle:kWordTwo message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                //
                //                [alert setBackgroundColor:[UIColor clearColor]];
                //
                //                [alert setContentMode:UIViewContentModeScaleAspectFit];
                //
                //                [alert show];
                //
                //                NSTimer *timer = nil;
                //                timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(c) userInfo:nil repeats:NO];
            }
        }else
        {
            UIAlertView *addAlert = [[UIAlertView alloc] initWithTitle:kColFour message:kWordThree delegate:self cancelButtonTitle:kWordFour otherButtonTitles:nil ,nil];
            [addAlert setTag:3];
            [addAlert show];
        }
        
    }
    
}

/**
 *  播放单词发音按钮响应事件
 */
- (void) playWord:(UIButton *)sender
{
    if (wordPlayer) {
        [wordPlayer release];
    }
    wordPlayer =[[AVPlayer alloc] initWithURL:[NSURL URLWithString:myWord.audio]];
    [wordPlayer play];
}

/**
 *  单词翻译界面句子按钮响应事件
 */
- (void)showSen:(UIButton *) sender {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"showSen"]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"showSen"];
        [sender setImage:[UIImage imageNamed:@"senClose.png"] forState:UIControlStateNormal];
        if (isiPhone) {
            [explainView setFrame:CGRectMake(0, 100, 320, 50 + sender.tag) ];
            
        } else {
            [explainView setFrame:CGRectMake(144, 220, 480, 70 + sender.tag) ];
            //            [sender setImage:[UIImage imageNamed:@"senClose-ipad.png"] forState:UIControlStateNormal];
        }
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"showSen"];
        [sender setImage:[UIImage imageNamed:@"senOpen.png"] forState:UIControlStateNormal];
        if (isiPhone) {
            [explainView setFrame:CGRectMake(0, 100, 320, 240)];
            
        } else {
            [explainView setFrame:CGRectMake(144, 220, 480, 360)];
            //            [sender setImage:[UIImage imageNamed:@"senOpen-ipad.png"] forState:UIControlStateNormal];
        }
    }
}

/**
 *  取词时查到该单词释义时响应事件
 */
- (void)wordExistDisplay {
    for (UIView *sView in [explainView subviews]) {
        if (![sView isKindOfClass:[UIImageView class]]) {
            [sView removeFromSuperview];
        }
    }
    
    NSString *totalString = [[NSString alloc] init];
    for (int i = 0; i<myWord.engArray.count; i++) {
        //        NSLog(@"retain1: %i", [totalString retainCount]);
        totalString = [totalString stringByAppendingFormat:@"%d:%@\n%@\n",i+1,[myWord.engArray objectAtIndex:i],[myWord.chnArray objectAtIndex:i]];
        //        NSLog(@"retain2: %i", [totalString retainCount]);
        //        totalNum += ([[myWord.engArray objectAtIndex:i] length]+2)/34 + 2 + [[myWord.chnArray objectAtIndex:i] length]/34;
    }
    
    UIFont *Courier = [UIFont fontWithName:@"Arial" size:20];
    UIFont *CourierT = [UIFont fontWithName:@"Arial" size:16];
    UIFont *CourierTh = [UIFont fontWithName:@"Arial" size:14];
    UIFont *CourierP = [UIFont fontWithName:@"Arial" size:23];
    UIFont *CourierTP = [UIFont fontWithName:@"Arial" size:19];
    UIFont *CourierThP = [UIFont fontWithName:@"Arial" size:17];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    if ([myWord isExisit]) {
        if (isiPhone) {
            [addButton setImage:[UIImage imageNamed:@"addedWord.png"] forState:UIControlStateNormal];
        } else {
            [addButton setImage:[UIImage imageNamed:@"addedWord-iPad.png"] forState:UIControlStateNormal];
        }
        [addButton setSelected:YES];
    } else {
        if (isiPhone) {
            [addButton setImage:[UIImage imageNamed:@"addWord.png"] forState:UIControlStateNormal];
        } else {
            [addButton setImage:[UIImage imageNamed:@"addWord-iPad.png"] forState:UIControlStateNormal];
        }
        [addButton setSelected:NO];
    }
    
    [addButton addTarget:self action:@selector(addWordPressed:) forControlEvents:UIControlEventTouchUpInside];
    if (isiPhone) {
        [addButton setFrame:CGRectMake(195, 0, 50, 50)];
    }else{
        [addButton setFrame:CGRectMake(315, 0, 50, 50)];
    }
    
    [explainView addSubview:addButton];
    
    UILabel *wordLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 180, 30)];
    [wordLabel setFont :isiPhone? Courier:CourierP];
    [wordLabel setTextAlignment:UITextAlignmentLeft];
    wordLabel.text = myWord.key;
    wordLabel.backgroundColor = [UIColor clearColor];
    [explainView addSubview:wordLabel];
    [wordLabel release];
    
    //    UILabel *pronLabel = [[UILabel alloc]initWithFrame:CGRectMake(40+[myWord.key sizeWithFont:Courier].width, 5, [[NSString stringWithFormat:@"[%@]", myWord.pron] sizeWithFont:Courier].width+10, 20)];
    UILabel *pronLabel = [[UILabel alloc]initWithFrame:CGRectMake(15,(isiPhone?30:40), 180, 20)];
    [pronLabel setFont :isiPhone ?CourierT:CourierTP];
    [pronLabel setTextAlignment:UITextAlignmentLeft];
    if ([myWord.pron isEqualToString:@" "] || [myWord.pron isEqualToString:@""]) {
        pronLabel.text = @"";
    }else
    {
        pronLabel.text = [NSString stringWithFormat:@"[%@]", myWord.pron];
    }
    pronLabel.backgroundColor = [UIColor clearColor];
    [explainView addSubview:pronLabel];
    [pronLabel release];
    
    if (wordPlayer) {
        [wordPlayer release];
    }
    wordPlayer =[[AVPlayer alloc]initWithURL:[NSURL URLWithString:myWord.audio]];
    [wordPlayer play];
    
    UIButton *audioButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    if (isiPhone) {
        [audioButton setImage:[UIImage imageNamed:@"wordSound.png"] forState:UIControlStateNormal];
    } else {
        [audioButton setImage:[UIImage imageNamed:@"wordSound-iPad.png"] forState:UIControlStateNormal];
    }
    [audioButton addTarget:self action:@selector(playWord:) forControlEvents:UIControlEventTouchUpInside];
    //    [audioButton setFrame:CGRectMake(250, 10, 30, 30)];
    if (isiPhone) {
        [audioButton setFrame:CGRectMake(250,5, 30, 30)];
        
    } else {
        [audioButton setFrame:CGRectMake(385,5, 40, 40)];
        
    }
    //    [audioButton setFrame:CGRectMake(50+[myWord.key sizeWithFont:Courier].width + [[NSString stringWithFormat:@"[%@]", myWord.pron] sizeWithFont:Courier].width, 5, 20, 20)];
    [explainView addSubview:audioButton];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    if (isiPhone) {
        [closeButton setImage:[UIImage imageNamed:@"wordClose.png"] forState:UIControlStateNormal];
    } else {
        [closeButton setImage:[UIImage imageNamed:@"wordClose-ipad.png"] forState:UIControlStateNormal];
    }
    [closeButton addTarget:self action:@selector(closeExplaView) forControlEvents:UIControlEventTouchUpInside];
    if (isiPhone) {
        [closeButton setFrame:CGRectMake(285, 5, 30, 30)];
        
    } else {
        [closeButton setFrame:CGRectMake(435, 5, 40, 40)];
        
    }
    [explainView addSubview:closeButton];
    
    UIButton *senButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    if (isiPhone) {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"showSen"]) {
        if (isiPhone) {
            [senButton setImage:[UIImage imageNamed:@"senOpen.png"] forState:UIControlStateNormal];
        } else {
            [senButton setImage:[UIImage imageNamed:@"senOpen-ipad.png"] forState:UIControlStateNormal];
        }
        
    } else {
        if (isiPhone) {
            [senButton setImage:[UIImage imageNamed:@"senClose.png"] forState:UIControlStateNormal];
            
        } else {
            [senButton setImage:[UIImage imageNamed:@"senClose-ipad.png"] forState:UIControlStateNormal];
            
        }
    }
    //    } else {
    //        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"showSen"]) {
    //            [senButton setImage:[UIImage imageNamed:@"senOpen-ipad.png"] forState:UIControlStateNormal];
    //        } else {
    //            [senButton setImage:[UIImage imageNamed:@"senClose-ipad.png"] forState:UIControlStateNormal];
    //        }
    //    }
    [senButton addTarget:self action:@selector(showSen:) forControlEvents:UIControlEventTouchUpInside];
    //    [senButton setFrame:CGRectMake(285, 30, 30, 30)];
    if (isiPhone) {
        [senButton setFrame:CGRectMake(288, 55, 25, 25)];
    } else {
        [senButton setFrame:CGRectMake(440, 55, 30, 30)];
    }
    
    [explainView addSubview:senButton];
    
    MyTextView *defTextView = [[MyTextView alloc] init];
    //    defTextView.delegate = self;
    if ([myWord.def isEqualToString:@" "]) {
        defTextView.text = kPlaySeven;
        [defTextView setFrame:CGRectMake(5,(isiPhone?50:70), explainView.frame.size.width-35, 20)];
        //        [defTextView setContentSize:CGSizeMake(explainView.frame.size.width-10, 20)];
        //                    NSLog(@"未联网无法查看释义!");
    }else{
        defTextView.text = myWord.def;
        CGSize enSize = [myWord.def sizeWithFont:(isiPhone?CourierTh:CourierThP) constrainedToSize:CGSizeMake(explainView.frame.size.width-50, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
        [defTextView setFrame:CGRectMake(5, (isiPhone?50:70), explainView.frame.size.width-35, (enSize.height+10 < 70? enSize.height+10: 70))];
        //        [defTextView setContentSize:CGSizeMake(explainView.frame.size.width-10, enSize.height)];
    }
    [defTextView setTag:arc4random()%1000];
    [defTextView setEditable:NO];
    [defTextView setFont:isiPhone? CourierTh:CourierThP];
    defTextView.backgroundColor = [UIColor clearColor];
    [defTextView setContentOffset:CGPointMake(0, 5)];
    [explainView addSubview:defTextView];
    [defTextView release];
    [senButton setTag:defTextView.frame.size.height];//***
    //    [explainView setAlpha:1];
    
    MyTextView *senTextView = [[MyTextView alloc] initWithFrame:CGRectMake(5,(isiPhone?50:70) + defTextView.frame.size.height, explainView.frame.size.width-10,   (isiPhone?190:290) - defTextView.frame.size.height)];
    //    defTextView.delegate = self;
    //    CGSize senSize = [totalString sizeWithFont:Courier constrainedToSize:CGSizeMake(explainView.frame.size.width-25, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    [senTextView setFrame:CGRectMake(5, (isiPhone?50:70) + defTextView.frame.size.height, explainView.frame.size.width-10, (isiPhone?190:290) - defTextView.frame.size.height)];
    //    int nNum = [VOAView numberOfMatch:totalString search:@"\n"] + 5;
    //    [senTextView setContentSize:CGSizeMake(explainView.frame.size.width-10, senSize.height + [@"赵松" sizeWithFont:CourierTh].height * nNum)];
    //    [senTextView setContentSize:CGSizeMake(explainView.frame.size.width-10, 500)];
    //    NSLog(@"nNum:%d height:%f totalheight:%f", nNum, [@"赵松" sizeWithFont:CourierTh].height, senSize.height + [@"赵松" sizeWithFont:CourierTh].height * nNum);
    senTextView.text = [totalString copy];
    [senTextView setTag:arc4random()%1000];
    [senTextView setEditable:NO];
    [senTextView setFont: isiPhone? CourierTh:CourierThP];
    senTextView.backgroundColor = [UIColor clearColor];
    [senTextView setContentOffset:CGPointMake(0, 10)];
    [explainView addSubview:senTextView];
    [totalString release];
    [senTextView release];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"showSen"]) {
        if (isiPhone) {
            [explainView setFrame:CGRectMake(0, 100, 320, 240)];
        } else {
            [explainView setFrame:CGRectMake(144, 220, 480, 360)];
        }
        
    } else {
        if (isiPhone) {
            [explainView setFrame:CGRectMake(0, 100, 320, 50 + defTextView.frame.size.height) ];
        } else {
            [explainView setFrame:CGRectMake(144, 220, 480, 70 + defTextView.frame.size.height) ];
        }
    }
    [explainView setHidden:NO];
}

/**
 *  取词时未查到该词时响应事件
 */
- (void)wordNoDisplay {
    myWord.audio = @"";
    myWord.pron = @" ";
    myWord.def = @"";
    for (UIView *sView in [explainView subviews]) {
        if (![sView isKindOfClass:[UIImageView class]]) {
            [sView removeFromSuperview];
        }
    }
    UIFont *Courier = [UIFont fontWithName:@"Arial" size:20];
    //    UIFont *CourierT = [UIFont fontWithName:@"Arial" size:16];
    UIFont *CourierTh = [UIFont fontWithName:@"Arial" size:14];
    UIFont *CourierP = [UIFont fontWithName:@"Arial" size:23];
    //    UIFont *CourierT = [UIFont fontWithName:@"Arial" size:16];
    UIFont *CourierThP = [UIFont fontWithName:@"Arial" size:17];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    if ([myWord isExisit]) {
        if (isiPhone) {
            [addButton setImage:[UIImage imageNamed:@"addedWord.png"] forState:UIControlStateNormal];
        } else {
            [addButton setImage:[UIImage imageNamed:@"addedWord-iPad.png"] forState:UIControlStateNormal];
        }
        [addButton setSelected:YES];
    } else {
        if (isiPhone) {
            [addButton setImage:[UIImage imageNamed:@"addWord.png"] forState:UIControlStateNormal];
        } else {
            [addButton setImage:[UIImage imageNamed:@"addWord-iPad.png"] forState:UIControlStateNormal];
        }
        [addButton setSelected:NO];
    }
    [addButton addTarget:self action:@selector(addWordPressed:) forControlEvents:UIControlEventTouchUpInside];
    if (isiPhone) {
        [addButton setFrame:CGRectMake(195, 0, 50, 50)];
    }else{
        [addButton setFrame:CGRectMake(315, 0, 50, 50)];
    }
    
    [explainView addSubview:addButton];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    if (isiPhone) {
        [closeButton setImage:[UIImage imageNamed:@"wordClose.png"] forState:UIControlStateNormal];
    } else {
        [closeButton setImage:[UIImage imageNamed:@"wordClose-ipad.png"] forState:UIControlStateNormal];
    }
    [closeButton addTarget:self action:@selector(closeExplaView) forControlEvents:UIControlEventTouchUpInside];
    if (isiPhone) {
        [closeButton setFrame:CGRectMake(285, 5, 30, 30)];
        
    } else {
        [closeButton setFrame:CGRectMake(435, 5, 40, 40)];
        
    }    [explainView addSubview:closeButton];
    
    UILabel *wordLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 180, 30)];
    [wordLabel setFont :isiPhone? Courier:CourierP];
    [wordLabel setTextAlignment:UITextAlignmentLeft];
    wordLabel.text = myWord.key;
    wordLabel.backgroundColor = [UIColor clearColor];
    [explainView addSubview:wordLabel];
    [wordLabel release];
    
    UILabel *defLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 50, explainView.frame.size.width-10, 20)];
    [defLabel setFont :isiPhone? CourierTh:CourierThP];
    defLabel.backgroundColor = [UIColor clearColor];
    [defLabel setLineBreakMode:UILineBreakModeWordWrap];
    [defLabel setNumberOfLines:1];
    defLabel.text = kWordEight;
    //                NSLog(@"无查找结果!");
    [explainView addSubview:defLabel];
    [defLabel release];
    //    [explainView setAlpha:1];
    
    if (isiPhone) {
        [explainView setFrame:CGRectMake(0, 100, 320, 70)];
    } else {
        [explainView setFrame:CGRectMake(144, 220, 480, 70)];
    }
    
    [explainView setHidden:NO];
    
}


@end
