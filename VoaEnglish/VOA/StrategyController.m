//
//  StrategyController.m
//  VOA
//
//  Created by zhao song on 13-5-24.
//  Copyright (c) 2013年 buaa. All rights reserved.
//

#import "StrategyController.h"

@interface StrategyController ()

@end

@implementation StrategyController
@synthesize oneView;
@synthesize twoView;
@synthesize threeView;
@synthesize fourView;
@synthesize fiveView;
@synthesize sixView;
@synthesize  myCollapseClick;

- (id)init
{
    return [self initWithNibName:@"StrategyController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //    NSLog(@"%@");
	if ([Constants isPad]) {
        self = [super initWithNibName:@"StrategyController-iPad" bundle:nibBundleOrNil];
	}else {
        self = [super initWithNibName:@"StrategyController" bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = NO;
    self.title = kStraOne;
    
    myCollapseClick.CollapseClickDelegate = self;
    [myCollapseClick reloadCollapseClick];
    
    
    // If you want a cell open on load, run this method:
    [myCollapseClick openCollapseClickCellAtIndex:0 animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collapse Click Delegate

// Required Methods
-(int)numberOfCellsForCollapseClick {
    return 6;
}

-(NSString *)titleForCollapseClickAtIndex:(int)index {
    switch (index) {
        case 0:
            return @"最新版块";
            break;
        case 1:
            return @"本地版块";
            break;
        case 2:
            return @"生词本版块";
            break;
        case 3:
            return @"信息版块";
            break;
        case 4:
            return @"设置版块";
            break;
        case 5:
            return @"播放版块";
            break;
        default:
            return @"最新版块";
            break;
    }
}

-(UIView *)viewForCollapseClickContentViewAtIndex:(int)index {
    switch (index) {
        case 0:
            return oneView;
            break;
        case 1:
            return twoView;
            break;
        case 2:
            return threeView;
            break;
        case 3:
            return fourView;
            break;
        case 4:
            return fiveView;
            break;
        case 5:
            return sixView;
            break;
        default:
            return oneView;
            break;
    }
}


// Optional Methods

-(UIColor *)colorForCollapseClickTitleViewAtIndex:(int)index {
//    return [UIColor colorWithRed:7.0/255 green:169.0/255 blue:217.0/255 alpha:1];
    return [UIColor colorWithRed:1.0/255 green:151.0/255 blue:211.0/255 alpha:1];
//    return [UIColor colorWithRed:223/255.0f green:47/255.0f blue:51/255.0f alpha:1.0];
}


-(UIColor *)colorForTitleLabelAtIndex:(int)index {
    return [UIColor colorWithWhite:1.0 alpha:0.85];
}

-(UIColor *)colorForTitleArrowAtIndex:(int)index {
    return [UIColor colorWithWhite:0.0 alpha:0.25];
}

-(void)didClickCollapseClickCellAtIndex:(int)index isNowOpen:(BOOL)open {
    NSLog(@"%d and it's open:%@", index, (open ? @"YES" : @"NO"));
}

@end
