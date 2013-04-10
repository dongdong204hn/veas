//
//  SentenceViewController.m
//  VOAAdvanced
//
//  Created by iyuba on 12-11-21.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "SentenceViewController.h"

@interface SentenceViewController ()

@end

@implementation SentenceViewController
@synthesize row;
@synthesize SenEn;
@synthesize SenCn;
//@synthesize OriText;
@synthesize HUD;
@synthesize nowUserId;
@synthesize sentences;
@synthesize myImageView;


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
    kNetTest;
    self.navigationController.navigationBarHidden=NO;
    nowUserId = 0;
    nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    sentences = [VOASentence findSentences:nowUserId];
    VOASentence *voaSen = [sentences objectAtIndex:row];
    VOAView *voa = [VOAView find:voaSen.VoaId];
   
    NSURL *url = [NSURL URLWithString: voa._pic];
    [myImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"acquiesce.png"]];
    [voa release];
    SenEn.text = voaSen.Sentence;
    SenCn.text = voaSen.Sentence_cn;
    self.title = [NSString stringWithFormat:@"第%d/%d句",row + 1,[sentences count]];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)dealloc
{
    [SenEn release];
    [SenCn release];
    [HUD release];
    [myImageView release];
//    [OriText release];
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

//- (IBAction)goOriText : (id)sender
//{
//    HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
//
//    HUD.dimBackground = YES;
//
//    HUD.labelText = @"connecting!";
//
//    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            VOASentence *voaSen = [sentences objectAtIndex:row];
//            VOAView *voa = [VOAView find:voaSen.VoaId];
//            [voaSen release];
//            PlayViewController *play = [PlayViewController sharedPlayer];//新建新界面的controller实例
//            if(play.voa._voaid == voa._voaid)
//            {
//                play.newFile = NO;
//            }else
//            {
//                play.newFile = YES;
//                play.voa = voa;
//            }
//            [voa release];
//            [play setHidesBottomBarWhenPushed:YES];//设置推到新界面时无bottomBar
//            if (play.contentMode != 2) {
//                play.flushList = YES;
//                play.contentMode = 2;
//            }
//            [self.navigationController pushViewController:play animated:NO];
//            [HUD hide:YES];
//        });
//    });
//
//}
@end
