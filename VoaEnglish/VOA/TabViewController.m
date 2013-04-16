//
//  TabViewController.m
//  IyuMusic
//
//  Created by iyuba on 12-8-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TabViewController.h"

#define TabBarBackgroundImageViewTag 11111

@implementation TabViewController

@synthesize tabBarBackgroundImage                       = _tabBarBackgroundImage;
@synthesize unSelectedImageArray                        = _unSelectedImageArray;
@synthesize selectedImageArray                          = _selectedImageArray;
@synthesize itemBgImageViewArray                        = _itemBgImageViewArray;
@synthesize lastSelectedIndex                           = _lastSelectedIndex;
@synthesize hiddenIndex                                 = _hiddenIndex;

- (void)dealloc
{   
    self.tabBarBackgroundImage = nil;
    self.unSelectedImageArray = nil;
    self.selectedImageArray = nil;
    self.itemBgImageViewArray = nil;
    [super dealloc];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
    self.tabBarBackgroundImage = nil;
    
}

- (id)initWithTabBarBackgroundImage:(UIImage *)barBackgroundImage 
               unSelectedImageArray:(NSMutableArray *)unImageArray
                 selectedImageArray:(NSMutableArray *)imageArray {
    self = [super init];
    if (self) {
        
		self.tabBarBackgroundImage = barBackgroundImage;
        self.unSelectedImageArray = unImageArray;
        self.selectedImageArray = imageArray;
        
        self.itemBgImageViewArray = [NSMutableArray array];
        _lastSelectedIndex = 0;
        _hiddenIndex = -1;
    }
    return self;
}
#if 0 //未使用
- (id)init {
    self = [super init];
    if (self) {
        
        self.tabBarBackgroundImage = [UIImage imageNamed:@"tabbarOne.png"];
        
        NSMutableArray *aunSelectedImageArray = [[NSMutableArray alloc] initWithObjects:
												 [UIImage imageNamed:@"最新2.png"],
                                                 [UIImage imageNamed:@"local.png"],
                                                 [UIImage imageNamed:@"word.png"],
                                                 [UIImage imageNamed:@"set.png"],
                                                 /*[UIImage imageNamed:@"isImage1.png"],*/ nil];
        self.unSelectedImageArray = aunSelectedImageArray;
        [aunSelectedImageArray release];
        
        NSMutableArray *aselectedImageArray = [[NSMutableArray alloc] initWithObjects:
											   [UIImage imageNamed:@"最新2.png"],
                                               [UIImage imageNamed:@"local.png"],
                                               [UIImage imageNamed:@"word.png"],
                                               [UIImage imageNamed:@"set.png"], 
                                               /*[UIImage imageNamed:@"isImage1.png"], */nil];
        self.selectedImageArray = aselectedImageArray;
        [aselectedImageArray release];
        
        self.itemBgImageViewArray = [NSMutableArray array];
        _lastSelectedIndex = 0;
        _hiddenIndex = -1;
        
    }
    return self;
}
#endif

#pragma mark - itemIndex methods

- (void)setLastSelectedIndex:(int)lastSelectedIndex {
    if (_lastSelectedIndex != lastSelectedIndex) {
        //将上次的选中效果取消
        UIImageView *lastSelectedImageView = (UIImageView *)[_itemBgImageViewArray objectAtIndex:_lastSelectedIndex];;
        lastSelectedImageView.image = [_unSelectedImageArray objectAtIndex:_lastSelectedIndex];
        
        _lastSelectedIndex = lastSelectedIndex;
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    //将上次的选中效果取消
    self.lastSelectedIndex = selectedIndex;
    //将本次的选中效果显示
    UIImageView *selectedImageView = (UIImageView *)[_itemBgImageViewArray objectAtIndex:selectedIndex];
    selectedImageView.image = [_selectedImageArray objectAtIndex:selectedIndex];
	
}

//隐藏某个tabBarItem的图片
- (void)hiddeItemImageView:(int)index {
    if (_hiddenIndex != index) {
        _hiddenIndex = index;
        
        UIImageView *hiddenImageView = (UIImageView *)[_itemBgImageViewArray objectAtIndex:_hiddenIndex];
        hiddenImageView.hidden = YES;
    }
}

//显示某个tabBarItem的图片
- (void)showItemImageView:(int)index {
    if (_hiddenIndex == index) {
        
        UIImageView *hiddenImageView = (UIImageView *)[_itemBgImageViewArray objectAtIndex:_hiddenIndex];
        hiddenImageView.hidden = NO;
        
        _hiddenIndex = -1;
    }
}

#pragma mark - View lifecycle

#if 1
/**
 *  Implement loadView to create a view hierarchy programmatically, without using a nib.
 */
- (void)loadView 
{
    [super loadView];
	if ([Constants isPad]) {
        self.tabBarBackgroundImage = [UIImage imageNamed:@"tabbarOne-iPad.png"];
        NSMutableArray *aunSelectedImageArray = [[NSMutableArray alloc] initWithObjects:
                                                 [UIImage imageNamed:@"new-ipad.png"],
                                                 [UIImage imageNamed:@"local-ipad.png"],
                                                 [UIImage imageNamed:@"word-ipad.png"],
                                                 [UIImage imageNamed:@"infor-ipad.png"],
                                                 [UIImage imageNamed:@"set-ipad.png"],
                                                 /* [UIImage imageNamed:@"isImage1.png"], */nil];
        self.unSelectedImageArray = aunSelectedImageArray;
        [aunSelectedImageArray release];
        
        NSMutableArray *aselectedImageArray = [[NSMutableArray alloc] initWithObjects:
                                               [UIImage imageNamed:@"newDown-ipad.png"],
                                               [UIImage imageNamed:@"localDown-ipad.png"],
                                               [UIImage imageNamed:@"wordDown-ipad.png"],
                                               [UIImage imageNamed:@"inforDown-ipad.png"],
                                               [UIImage imageNamed:@"setDown-ipad.png"], 
                                               /*[UIImage imageNamed:@"isImage1.png"],*/ nil];
        self.selectedImageArray = aselectedImageArray;
        [aselectedImageArray release];
    } else {
        self.tabBarBackgroundImage = [UIImage imageNamed:@"tabbarOne.png"];
        NSMutableArray *aunSelectedImageArray = [[NSMutableArray alloc] initWithObjects:
                                                 [UIImage imageNamed:@"new.png"],
                                                 [UIImage imageNamed:@"local.png"],
                                                 [UIImage imageNamed:@"word.png"],
                                                 [UIImage imageNamed:@"infor.png"],
                                                 [UIImage imageNamed:@"set.png"],
                                                 /* [UIImage imageNamed:@"isImage1.png"], */nil];
        self.unSelectedImageArray = aunSelectedImageArray;
        [aunSelectedImageArray release];
        
        NSMutableArray *aselectedImageArray = [[NSMutableArray alloc] initWithObjects:
                                               [UIImage imageNamed:@"newDown.png"],
                                               [UIImage imageNamed:@"localDown.png"],
                                               [UIImage imageNamed:@"wordDown.png"],
                                               [UIImage imageNamed:@"inforDown.png"],
                                               [UIImage imageNamed:@"setDown.png"], 
                                               /*[UIImage imageNamed:@"isImage1.png"],*/ nil];
        self.selectedImageArray = aselectedImageArray;
        [aselectedImageArray release];
    }
    
//    NSMutableArray *aunSelectedImageArray = [[NSMutableArray alloc] initWithObjects:
//                                             [UIImage imageNamed:@"new-ipad.png"],
//                                             [UIImage imageNamed:@"local-ipad.png"],
//                                             [UIImage imageNamed:@"word-ipad.png"],
//                                             [UIImage imageNamed:@"infor-ipad.png"],
//                                             [UIImage imageNamed:@"set-ipad.png"],
//                                             /* [UIImage imageNamed:@"isImage1.png"], */nil];
//    self.unSelectedImageArray = aunSelectedImageArray;
//    [aunSelectedImageArray release];
//    
//    NSMutableArray *aselectedImageArray = [[NSMutableArray alloc] initWithObjects:
//                                           [UIImage imageNamed:@"newDown-ipad.png"],
//                                           [UIImage imageNamed:@"localDown-ipad.png"],
//                                           [UIImage imageNamed:@"wordDown-ipad.png"],
//                                           [UIImage imageNamed:@"inforDown-ipad.png"],
//                                           [UIImage imageNamed:@"setDown-ipad.png"],
//                                           /*[UIImage imageNamed:@"isImage1.png"],*/ nil];
//    self.selectedImageArray = aselectedImageArray;
//    [aselectedImageArray release];

    
    self.itemBgImageViewArray = [NSMutableArray array];
    _lastSelectedIndex = 0;
    _hiddenIndex = -1;
}
#endif

//iPhone设置
#define ItemWidth 35//50
#define ItemHeight 38//49
#define SideMarginY 4//0.5
//#define SideMarginX 22////7
//#define Spacing 45
#define SideMarginX 14////7
#define Spacing 29

//iPad设置
#define ItemWidthP 75  //item的宽度
#define ItemHeightP 38//49 item的高度
#define SideMarginYP 4//0.5 item与上沿的距离
//#define SideMarginXP 182////7
//#define SpacingP 35
#define SideMarginXP 102////7 两边item与边沿距离
#define SpacingP 51 //item之间的距离


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *tabBarBackgroundImageView ;
    if ([Constants isPad]) {
        tabBarBackgroundImageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.tabBar.frame.size.width, self.tabBar.frame.size.height +5)];
//        NSLog(@"origin:%f,tabbarwidth:%f,tabbarheight:%f",tabBarBackgroundImageView.frame.origin.x,self.tabBar.frame.size.width, self.tabBar.frame.size.height +5);
    } else {
        tabBarBackgroundImageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.tabBar.frame.size.width, self.tabBar.frame.size.height +5)];
    }
    
    tabBarBackgroundImageView.tag = TabBarBackgroundImageViewTag;
    tabBarBackgroundImageView.contentMode = UIViewContentModeScaleToFill;
    tabBarBackgroundImageView.image = _tabBarBackgroundImage;
    //[self.tabBar insertSubview:tabBarBackgroundImageView atIndex:0];
	UITabBar *image = nil;

	for (int i = 0; i < [self.view.subviews count]; i++) {
		if ([[self.view.subviews objectAtIndex:i] isKindOfClass:[UITabBar class]]) {
			image = [self.view.subviews objectAtIndex:i];
		}
	}
	[self.tabBar insertSubview:tabBarBackgroundImageView belowSubview:image];
	//- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview
    //	for (int i = 0; i < [self.view.subviews count]; i++) {
    //		if ([[self.view.subviews objectAtIndex:i] isKindOfClass:[UIView class]]) {
    //			UIView *image = [self.view.subviews objectAtIndex:i];
    //			NSLog(@"i = %d,width is %f", i, image.frame.size.width);
    //		}
    //	}
	//[self.tabBar addSubview:tabBarBackgroundImageView];
    [tabBarBackgroundImageView release];
	for (int i = 0; i < 5; i++) {////////////5--4
        if ([Constants isPad]) {
            UIImageView *itemBg  = [[UIImageView alloc] initWithFrame:CGRectMake(SideMarginXP +ItemWidthP * i + SpacingP * i, SideMarginYP, ItemWidthP, ItemHeightP)];
            itemBg.contentMode = UIViewContentModeScaleAspectFit;
            itemBg.image = [_unSelectedImageArray objectAtIndex:i];
            //[self.tabBar insertSubview:itemBg atIndex:5];
            [self.tabBar insertSubview:itemBg aboveSubview:self.tabBar];
            //        [self.tabBar addSubview:itemBg];
            [_itemBgImageViewArray addObject:itemBg];
            [itemBg release];
        } else {
            UIImageView *itemBg  = [[UIImageView alloc] initWithFrame:CGRectMake(SideMarginX +ItemWidth * i + Spacing * i, SideMarginY, ItemWidth, ItemHeight)];
            itemBg.contentMode = UIViewContentModeScaleAspectFit;
            itemBg.image = [_unSelectedImageArray objectAtIndex:i];
            //[self.tabBar insertSubview:itemBg atIndex:5];
            [self.tabBar insertSubview:itemBg aboveSubview:self.tabBar];
            //        [self.tabBar addSubview:itemBg];
            [_itemBgImageViewArray addObject:itemBg];
            [itemBg release];
        }
	}
    self.selectedIndex = 0;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [_tabBarBackgroundImage release], _tabBarBackgroundImage = nil;
    [_unSelectedImageArray release], _unSelectedImageArray = nil;
    [_selectedImageArray release], _selectedImageArray = nil;
    [_itemBgImageViewArray release], _itemBgImageViewArray = nil;
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    self.selectedIndex = [tabBar.items indexOfObject:item];
}


@end
