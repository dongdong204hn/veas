//
//  MyTextView.h
//  VOA
//
//  Created by zhao song on 13-1-17.
//  Copyright (c) 2013年 buaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayViewController.h"

@class MyTextView;

@protocol MyTextViewDelegate <NSObject>
@optional
- (void)catchTouches: (NSSet *)touches myTextView:(MyTextView *)myTextView ;
@end

/**
 *  custom UITextView that can distinguish if is touched
 */
@interface MyTextView : UITextView

@property (nonatomic, assign) id <MyTextViewDelegate> myDelegate;

@end
