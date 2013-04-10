//
//  InforController.m
//  VOA
//
//  Created by song zhao on 12-3-31.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "InforController.h"

@implementation InforController
@synthesize webView;
@synthesize isiPhone;

#pragma mark * Setup

- (void)_loadInfoContent
{
//    NSString *  	infoFilePath;
    NSURLRequest *  request;
    
//    infoFilePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"html"];
//    assert(infoFilePath != nil);
//    
//    request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:infoFilePath]];
//    assert(request != nil);
    
    request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://app.iyuba.com/ios/"]];
    assert(request != nil);
    
    [self.webView loadRequest:request];
}

#pragma mark - My Action
- (void)doSeg:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
        [_webView goBack];
    }else
    {
        [_webView reload];
    }
}

#pragma mark * View controller boilerplate
//
//- (BOOL)isPad {
//	BOOL isPad = NO;
//#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
//	isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
//#endif
//	return isPad;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    kNetTest;
    isiPhone = ![Constants isPad];
    if (!isiPhone) {
        [self.view setFrame:CGRectMake(0, 0, 768, 980)];
        [self.webView setFrame:CGRectMake(0, 0, 768, 980)];
    }
    assert(self.webView != nil);
    
    [self _loadInfoContent];
    UISegmentedControl *segmentedControl=[[UISegmentedControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f) ];
    [segmentedControl insertSegmentWithTitle:kInfoConOne atIndex:0 animated:YES];
    [segmentedControl insertSegmentWithTitle:kInfoConTwo atIndex:1 animated:YES];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.momentary = YES;
    segmentedControl.multipleTouchEnabled=NO;
    [segmentedControl addTarget:self action:@selector(doSeg:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *segButton = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
    [segmentedControl release], segmentedControl = nil;
    self.navigationItem.rightBarButtonItem = segButton;
    [segButton release], segButton = nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.webView = nil;
}

- (void)dealloc
{
    [self.webView release], _webView = nil;
    [super dealloc];
}

@end
