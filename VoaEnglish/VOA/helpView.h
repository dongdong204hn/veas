//
//  helpView.h
//  VOA
//  用户帮助容器
//  Created by song zhao on 12-2-10.
//  Copyright (c) 2012年 iyuba. All rights reserved.
//

#import "Constants.h"

/**
 *
 */
@interface helpView : UIViewController<UIScrollViewDelegate>{
    UIScrollView * scrollView;
    UIPageControl * pageControl;
    NSUInteger numOfPages;
    BOOL showStartButton; //默认NO
    BOOL isiPhone;
}

@property (nonatomic, retain) IBOutlet UIScrollView * scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl * pageControl;
@property (nonatomic) NSUInteger numOfPages;
@property (nonatomic) BOOL showStartButton;
@property (nonatomic) BOOL isiPhone;

- (id) initWithNumber:(NSUInteger)pages showStart:(BOOL)start;
- (IBAction)changePage:(UIPageControl *)sender;

@end
