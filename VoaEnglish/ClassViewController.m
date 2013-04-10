//
//  ClassViewController.m
//  VOA
//
//  Created by song zhao on 12-2-2.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "ClassViewController.h"

@implementation ClassViewController

@synthesize ae;
@synthesize at;
@synthesize ay;
@synthesize en;
@synthesize bs;
@synthesize hh;
@synthesize sy;
@synthesize ua;
@synthesize wd;
@synthesize myMove;
@synthesize cPg;
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

#pragma mark - My action
- (IBAction)buttonPressed:(UIButton *) sender
{
//    NSLog(@"%d",sender.tag);
//    NSLog(@"%@",sender.currentTitle);
    DetailViewController *detail = [DetailViewController alloc];
    detail.category = sender.tag;//整型转变为NSString
    
//    NSLog(@"%@",detail.category);
    [self.navigationController pushViewController:detail animated:YES];
    [detail release], detail = nil;
}


//- (BOOL)isPad {
//	BOOL isPad = NO;
//#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
//	isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
//#endif
//	return isPad;
//}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    kNetTest;
    isiPhone = ![Constants isPad];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"nowClassNumber"];
    self.title = kClassOne;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.at = nil;
    self.ay = nil;
    self.en = nil;
    self.ae = nil;
    self.bs = nil;
    self.hh = nil;
    self.sy = nil;
    self.wd = nil;
    self.ua = nil;
    self.myMove = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [self.at release], at = nil;
    [self.ay release], ay = nil;
    [self.en release], en = nil;
    [self.ae release], ae = nil;
    [self.bs release], bs = nil;
    [self.hh release], hh = nil;
    [self.sy release], sy = nil;
    [self.wd release], wd = nil;
    [self.ua release], ua = nil;
    [self.myMove release], myMove = nil;
    [super dealloc];
}

#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //设置动画效果
	[UIView beginAnimations:@"classAniThree" context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationCurve:UIViewAnimationOptionCurveEaseInOut];
    //设置你要运行的代码
    UITouch *touch = [touches anyObject];    
    CGPoint touchPoint = [touch locationInView:self.view];
    float x = touchPoint.x;
    float y = touchPoint.y;
//    NSLog(@"触摸开始:%f,%f", x, y);
    [at setAlpha:0];
    [ay setAlpha:0];
    [ae setAlpha:0];
    [en setAlpha:0];
    [bs setAlpha:0];
    [hh setAlpha:0];
    [sy setAlpha:0];
    [wd setAlpha:0];
    [ua setAlpha:0];
    [myMove setFrame:CGRectMake(x-100, y-100, 200, 200)];
    [myMove setAlpha:1];
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    myMove.layer.anchorPoint = CGPointMake(0.5, 0.5);
    myMove.layer.position = CGPointMake(myMove.frame.origin.x + 0.5 * myMove.frame.size.width, myMove.frame.origin.y + 0.5 * myMove.frame.size.height);
    [CATransaction commit];
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
    [CATransaction setValue:[NSNumber numberWithFloat:120.0] forKey:kCATransactionAnimationDuration];
    
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:120 * M_PI];
    animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    animation.delegate = self;
    [myMove.layer addAnimation:animation forKey:@"rotationAnimation"];
    [CATransaction commit];
    [UIView commitAnimations];    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //设置动画效果
	[UIView beginAnimations:@"classAniTwo" context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationOptionCurveEaseInOut];
    //设置你要运行的代码
    UITouch *touch = [touches anyObject];    
    CGPoint touchPoint = [touch locationInView:self.view];
    float x = touchPoint.x;
    float y = touchPoint.y;
//    NSLog(@"拖动:%f,%f", x, y);
    [myMove setFrame:CGRectMake(x-100, y-100, 200, 200)];
    
    [UIView commitAnimations];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    //设置动画效果
	[UIView beginAnimations:@"classAniOne" context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationCurve:UIViewAnimationOptionCurveEaseInOut];
    //设置你要运行的代码
    [myMove.layer removeAllAnimations]; 
    [myMove setAlpha:0];
    NSInteger nowClass = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowClassNumber"] integerValue];
    

//    //Get the CGContext from this view
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(context);
//    //Set the stroke (pen) color
//    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
//    //Set the width of the pen mark
//    CGContextSetLineWidth(context, 1.0);
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetLineWidth(context, 1.0);
//    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
//    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
//    
//    CGRect currentRect = CGRectMake(80.0, 40.0, 100.0, 7.0);
//    
//    CGContextAddRect(context, currentRect);
//    CGContextDrawPath(context, kCGPathFillStroke);
    
    if (nowClass == 1) {//  O
        if (isiPhone) {
            [at setFrame:CGRectMake(125, 20, 70, 70)];
            [ay setFrame:CGRectMake(32, 65, 70, 70)];
            [ae setFrame:CGRectMake(215, 65, 70, 70)];
            [en setFrame:CGRectMake(0, 140, 70, 70)];
            [bs setFrame:CGRectMake(125, 140, 70, 70)];
            [hh setFrame:CGRectMake(250, 140, 70, 70)];
            [sy setFrame:CGRectMake(32, 215, 70, 70)];
            [wd setFrame:CGRectMake(218, 215, 70, 70)];
            [ua setFrame:CGRectMake(125, 260, 70, 70)];
        }else{
            [at setFrame:CGRectMake(194, 130, 140, 140)];
            [ay setFrame:CGRectMake(434, 130, 140, 140)];
            [ae setFrame:CGRectMake(604, 300, 140, 140)];
            [en setFrame:CGRectMake(604, 534, 140, 140)];
            [bs setFrame:CGRectMake(194, 710, 140, 140)];
            [hh setFrame:CGRectMake(434, 710, 140, 140)];
            [sy setFrame:CGRectMake(24, 300, 140, 140)];
            [wd setFrame:CGRectMake(24, 534, 140, 140)];
            [ua setFrame:CGRectMake(334, 440, 100, 100)];
        }
        
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:2] forKey:@"nowClassNumber"];
    }
    else if (nowClass == 2) {// A
        if (isiPhone) {
            [wd setFrame:CGRectMake(0, 260, 70, 70)];
            [bs setFrame:CGRectMake(30, 180, 70, 70)];
            [ae setFrame:CGRectMake(60, 100, 70, 70)];
            [at setFrame:CGRectMake(90, 20, 70, 70)];
            [ay setFrame:CGRectMake(160, 20, 70, 70)];
            [en setFrame:CGRectMake(190, 100, 70, 70)];
            [sy setFrame:CGRectMake(220, 180, 70, 70)];
            [ua setFrame:CGRectMake(250, 260, 70, 70)];
            [hh setFrame:CGRectMake(125, 180, 70, 70)];

        }else {
            [wd setFrame:CGRectMake(234, 150, 140, 140)];
            [bs setFrame:CGRectMake(394, 150, 140, 140)];
            [ae setFrame:CGRectMake(164, 330, 140, 140)];
            [at setFrame:CGRectMake(464, 330, 140, 140)];
            [ay setFrame:CGRectMake(94, 510, 140, 140)];
            [en setFrame:CGRectMake(314, 510, 140, 140)];
            [sy setFrame:CGRectMake(534, 510, 140, 140)];
            [ua setFrame:CGRectMake(24, 690, 140, 140)];
            [hh setFrame:CGRectMake(604, 690, 140, 140)];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:3] forKey:@"nowClassNumber"];
        
    }
    else if (nowClass == 3) { //V
        if (isiPhone) {
            [at setFrame:CGRectMake(0, 20, 70, 70)];
            [ay setFrame:CGRectMake(250, 20, 70, 70)];
            [ae setFrame:CGRectMake(220, 80, 70, 70)];
            [en setFrame:CGRectMake(30, 80, 70, 70)];
            [bs setFrame:CGRectMake(60, 140, 70, 70)];
            [hh setFrame:CGRectMake(190, 140, 70, 70)];
            [sy setFrame:CGRectMake(90, 200, 70, 70)];
            [wd setFrame:CGRectMake(160, 200, 70, 70)];
            [ua setFrame:CGRectMake(125, 260, 70, 70)];
        }else {
            [at setFrame:CGRectMake(314, 780, 140, 140)];
            [ay setFrame:CGRectMake(244, 600, 140, 140)];
            [ae setFrame:CGRectMake(384, 600, 140, 140)];
            [en setFrame:CGRectMake(174, 420, 140, 140)];
            [bs setFrame:CGRectMake(454, 420, 140, 140)];
            [hh setFrame:CGRectMake(104, 240, 140, 140)];
            [sy setFrame:CGRectMake(524, 240, 140, 140)];
            [wd setFrame:CGRectMake(34, 60, 140, 140)];
            [ua setFrame:CGRectMake(594, 60, 140, 140)];
        }
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"nowClassNumber"];
    }
    [at setAlpha:1];
    [ay setAlpha:1];
    [ae setAlpha:1];
    [en setAlpha:1];
    [bs setAlpha:1];
    [hh setAlpha:1];
    [sy setAlpha:1];
    [wd setAlpha:1];
    [ua setAlpha:1];
    [UIView commitAnimations];
}

@end
