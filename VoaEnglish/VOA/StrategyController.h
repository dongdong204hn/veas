//
//  StrategyController.h
//  VOA
//
//  Created by zhao song on 13-5-24.
//  Copyright (c) 2013年 buaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollapseClick.h"

@interface StrategyController : UIViewController <CollapseClickDelegate>

@property (nonatomic, retain) IBOutlet UIView *          oneView;
@property (nonatomic, retain) IBOutlet UIView *          twoView;
@property (nonatomic, retain) IBOutlet UIView *          threeView;
@property (nonatomic, retain) IBOutlet UIView *          fourView;
@property (nonatomic, retain) IBOutlet UIView *          fiveView;
@property (nonatomic, retain) IBOutlet UIView *          sixView;
@property (nonatomic, retain) IBOutlet CollapseClick *          myCollapseClick;

@end
