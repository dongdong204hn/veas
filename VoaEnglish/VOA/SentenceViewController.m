//
//  SentenceViewController.m
//  VOA
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
