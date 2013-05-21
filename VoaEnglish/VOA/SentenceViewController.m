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
    self.title = [NSString stringWithFormat:@"第%d/%d句",row + 1,[sentences count]];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [SenEn whenTapped:^{
        NSLog(@"juzi diandian");
        [self screenTouchWord: SenEn];
    }];
    
    explainView = [[MyLabel alloc]init];
    
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

/**
 *  屏幕取词
 */
-(void)screenTouchWord:(UITextView *)mylabel{
    int lineHeight = [@"a" sizeWithFont:mylabel.font].height;
    int LineStartlocation = 0;
    if (mylabel.tag == 2000) {
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
    UITouch *touch = [wordTouches anyObject];
    CGPoint point = [touch locationInView:self.textScroll];
    int tagetline = ceilf((point.y- mylabel.frame.origin.y)/lineHeight);
    CGSize maxSize = CGSizeMake(textScroll.frame.size.width-(isiPhone? 16: 18), CGFLOAT_MAX);
    if (readRecord) {
        point = [touch locationInView:self.myScroll];
        if (isiPhone) {
            tagetline = ceilf((point.y- 20)/lineHeight);
            maxSize = CGSizeMake(260, CGFLOAT_MAX);
        } else {
            tagetline = ceilf((point.y- 50)/lineHeight);
            maxSize = CGSizeMake(568, CGFLOAT_MAX);
        }
        
    }
    //    NSLog(@"x:%f,y:%f",point.x,point.y);
    //    int fontSize = [[NSUserDefaults standardUserDefaults] integerForKey:@"nowValueFont"];
    //    NSLog(@"nowValueFont:%d",fontSize);
    //    UIFont *Courier = [UIFont fontWithName:@"Courier" size:fontSize];
    
    //    int numberoflines = self.frame.size.height / lineHeight;
    //    int tagetline = ceilf((point.y- mylabel.frame.origin.y)/lineHeight);
    NSString * sepratorString = @", ，。.?!:\"“”-()'‘";
    //    NSString * text = @"...idowrhu wpe gre dddd.. 'eow.ei, we u";
    NSCharacterSet * sepratorSet = [NSCharacterSet characterSetWithCharactersInString:sepratorString];
    NSArray * splitStr = [mylabel.text componentsSeparatedByCharactersInSet:sepratorSet];
    //    NSArray * splitStr = [self.text componentsSeparatedByString:@" "];
    int WordIndex = 0;
    int count = [splitStr count];
    BOOL WordFound = NO;
    NSString * string = @"";
    NSString * string2 = @"";
    
    for (int i = 0; i < count && !WordFound; i++) {
        @try {//??
            string = [string stringByAppendingString:[NSString stringWithFormat:@"%@.",[splitStr objectAtIndex:i]]];
            
            NSString * substr = [mylabel.text substringWithRange:NSMakeRange(LineStartlocation, [string length])];
            CGSize mysize = [substr sizeWithFont:mylabel.font constrainedToSize:maxSize];
            
            if (mysize.height/lineHeight == tagetline && !WordFound) {
                LineStartlocation = [string length] - [[splitStr objectAtIndex:i] length] - 1;
                for (; i < count; i++) {
                    
                    string2 = [string2 stringByAppendingString:[NSString stringWithFormat:@"%@.",[splitStr objectAtIndex:i]]];
                    NSString * substr2 = nil;
                    @try {
                        substr2 = [mylabel.text substringWithRange:NSMakeRange(LineStartlocation, [string2 length])];
                    }
                    @catch (NSException *exception) {
                        
                        return;
                    }
                    
                    
                    CGSize thissize = [substr2 sizeWithFont:mylabel.font constrainedToSize:maxSize];
                    if (thissize.height/lineHeight > 1) {
                        return;
                    }
                    
                    if (thissize.width > (readRecord? (isiPhone? point.x-670:point.x-1636):point.x)) {
                        
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
        CGFloat width = [[splitStr objectAtIndex:WordIndex] sizeWithFont:mylabel.font].width;
        
        NSRange Range1 = [string2 rangeOfString:[splitStr objectAtIndex:WordIndex] options:NSBackwardsSearch];
        
        
        NSString * str = [string2 substringToIndex:Range1.location];
        int i = 0;
        while ([[str substringToIndex:i] isEqual:@"."]) {
            str = [str substringFromIndex:i+1];
            i++;
            
        }
        
        CGFloat pointX = [str sizeWithFont:mylabel.font].width;
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
        
        if (readRecord) {
            [myHighLightWord setFrame:CGRectMake(pointX, pointY, width, lineHeight)];
            [myHighLightWord setHidden:NO];
        }else {
            [myHighLightWord setFrame:CGRectMake(pointX + 7, mylabel.frame.origin.y + pointY, width, lineHeight)];
        }
        [myHighLightWord setAlpha:0.5];
        [myHighLightWord setHighlighted:YES];
        [myHighLightWord setHighlightedTextColor:[UIColor whiteColor]];
        [myHighLightWord setBackgroundColor:[UIColor colorWithRed:1.0/255 green:151.0/255 blue:211.0/255 alpha:1]];
        if (readRecord) {
            [mylabel addSubview:myHighLightWord];
        }else {
            [textScroll addSubview:myHighLightWord];
        }
        
        //        [myHighLightWord setHidden:NO];
        
        //        wordBack = [[UIView alloc] initWithFrame:CGRectMake(pointX, pointY, width, lineHeight)];
        //        wordBack.backgroundColor = [UIColor colorWithRed:1.0 green:0.651 blue:0.098 alpha:0.5];
        //        [self insertSubview:wordBack atIndex:0];
        //        [self GetExplain:WordIFind];
    }
}

- (void)viewDidUnload {
    self.SenEn = nil;
    self.SenCn = nil;
    self.myImageView = nil;
    [sentences release], sentences = nil;
    [super viewDidUnload];
}

- (void)dealloc
{
    [SenEn release];
    [SenCn release];
    [myImageView release];
    [sentences release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma MyAction

/**
 *  切换前一句
 */
- (IBAction)preSen:(id)sender
{
    if (row<=0) {
        
    }
    else{
        row--;
        VOASentence  *voaSen = [sentences objectAtIndex:row];
        SenEn.text = voaSen.Sentence;
        SenCn.text = voaSen.Sentence_cn;
        VOAView *voa = [VOAView find:voaSen.VoaId];
        NSURL *url = [NSURL URLWithString: voa._pic];
        [myImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"acquiesce.png"]];
        self.title = [NSString stringWithFormat:@"第%d/%d句",row + 1,[sentences count]];
        
    }
}

/**
 *  切换后一句
 */
- (IBAction)nextSen:(id)sender
{
    if (row>=[sentences count]-1) {
        
    } else {
        row ++;
        VOASentence  *voaSen = [sentences objectAtIndex:row];
        
        SenEn.text = voaSen.Sentence;
        SenCn.text = voaSen.Sentence_cn;
        VOAView *voa = [VOAView find:voaSen.VoaId];
        NSURL *url = [NSURL URLWithString: voa._pic];
        [myImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"acquiesce.png"]];
        
        self.title = [NSString stringWithFormat:@"第%d/%d句",row + 1,[sentences count]];
        
    }
}

@end
