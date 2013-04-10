//
//  DACircularProgressView.h
//  DACircularProgress
//
//  Created by Daniel Amitay on 2/6/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DACircularProgressView : UIView

@property(nonatomic, retain) UIColor *trackTintColor;
@property(nonatomic, retain) UIColor *progressTintColor;
@property (nonatomic) float progress;
@property (nonatomic) float preProgress;
@property (nonatomic, retain) UIImageView *statusImgView;

@property (nonatomic) BOOL isPlay;
- (void)setStatus;
- (void)setStatusToPlay;

@end
