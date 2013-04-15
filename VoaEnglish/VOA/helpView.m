//
//  helpView.m
//  FinalTest
//
//  Created by Seven Lee on 12-2-10.
//  Copyright (c) 2012年 iyuba. All rights reserved.
//

#import "helpView.h"

@implementation helpView
@synthesize pageControl;
@synthesize scrollView;
@synthesize numOfPages;
@synthesize showStartButton;
@synthesize isiPhone;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        numOfPages = 6;
        showStartButton = NO;
        pageControl.numberOfPages =6;
    }
    return self;
}

/**
 *  保留方法，未用
 */
- (id) initWithNumber:(NSUInteger)pages showStart:(BOOL)start{
    self = [super initWithNibName:@"helpView" bundle:nil];
    if (self) {
        numOfPages = pages;
        showStartButton = start;
        pageControl.numberOfPages = pages;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)changePage:(UIPageControl *)sender
{
    int page = pageControl.currentPage;
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];  
}
//
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
    [super viewDidLoad];
    isiPhone = ![Constants isPad];
    if (!isiPhone) {
        [self.view setFrame:CGRectMake(0, 0, 768, 956)]; 
        [self.pageControl setFrame:CGRectMake(350, -5, 68, 36)];
    }
    //    self.title = kHelpOne;
    self.title = NSLocalizedString(@"使用帮助", @"");
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollEnabled = YES;
    scrollView.clipsToBounds = YES;
    scrollView.delegate = self;
    if (showStartButton) {
        pageControl.frame = CGRectMake(pageControl.frame.origin.x, 20, pageControl.frame.size.width, pageControl.frame.size.height);
        if (!isiPhone) {
            scrollView.frame = CGRectMake(0, 0, 768, 956);
        } else {
            scrollView.frame = CGRectMake(0, 0, 320, 416 + (isiPhone5? 88: 0));
        }
    }
    if (isiPhone5) {
        scrollView.frame = CGRectMake(0, 0, 320, 416 + 88);
    }
    if (!isiPhone) {
        for (NSUInteger i = 1; i <= numOfPages; i++)
        {
            NSString *imageName = [NSString stringWithFormat:@"helpP%d.png", i];
            UIView * pageView = [[UIView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width * (i-1), 0, scrollView.frame.size.width, scrollView.frame.size.height+5)];
            UIImage *image = [UIImage imageNamed:imageName];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            // setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
            imageView.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height+5);
            pageView.tag = i;	// tag our images for later use when we place them in serial fashion
            [pageView addSubview:imageView];
            [scrollView addSubview:pageView];
            [imageView release];
            [pageView release];
            [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width * numOfPages, scrollView.frame.size.height)];
        }
    } else {
        for (NSUInteger i = 1; i <= numOfPages; i++)
        {
            NSString *imageName = [NSString stringWithFormat:@"help%d.png", i];
            UIView * pageView = [[UIView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width * (i-1), 0, scrollView.frame.size.width, scrollView.frame.size.height)];
            UIImage *image = [UIImage imageNamed:imageName];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            // setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
            imageView.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height);
            pageView.tag = i;	// tag our images for later use when we place them in serial fashion
            [pageView addSubview:imageView];
            [scrollView addSubview:pageView];
            [imageView release];
            [pageView release];
            [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width * numOfPages, scrollView.frame.size.height)];
        }
    }
//    isiPhone = ![Constants isPad];
//    if (!isiPhone) {
//        [self.view setFrame:CGRectMake(0, 0, 768, 980)]; 
//        [self.pageControl setFrame:CGRectMake(350, -5, 68, 36)];
//    }
//    self.title = kHelpOne;
//    scrollView.pagingEnabled = YES;
//    scrollView.showsVerticalScrollIndicator = NO;
//    scrollView.showsHorizontalScrollIndicator = NO;
//    scrollView.scrollEnabled = YES;
//    scrollView.clipsToBounds = YES;
//    scrollView.delegate = self;
//    if (showStartButton) {
//        scrollView.frame = CGRectMake(0, 0, 320, 460);
//        pageControl.frame = CGRectMake(pageControl.frame.origin.x, 20, pageControl.frame.size.width, pageControl.frame.size.height);
//    }
//    for (NSUInteger i = 1; i <= numOfPages; i++)
//	{
//		NSString *imageName = [NSString stringWithFormat:@"help%d.png", i];
//        UIView * pageView = [[UIView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width * (i-1), 0, scrollView.frame.size.width, scrollView.frame.size.height)];
//		UIImage *image = [UIImage imageNamed:imageName];
//		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//		// setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
//		imageView.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height);
//		pageView.tag = i;	// tag our images for later use when we place them in serial fashion
//        [pageView addSubview:imageView];
//		[scrollView addSubview:pageView];
//		[imageView release];
//        [pageView release];
//	}
//    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width * numOfPages, scrollView.frame.size.height)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.scrollView = nil;
    self.pageControl = nil;
}

- (void)dealloc
{
    [scrollView release], scrollView = nil;
    [pageControl release], pageControl = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.

	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;

    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

@end
