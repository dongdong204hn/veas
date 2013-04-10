//
//  MyPageControl.h
//  NewPageControl
//
//  Created by Miaohz on 11-8-31.
//  Copyright 2011 Etop. All rights reserved.
//

@interface MyPageControl : UIPageControl {
	UIImage *imagePageStateNormal;
	UIImage *imagePageStateHightlighted;
}

- (id) initWithFrame:(CGRect)frame;
- (void) updateAfterScroll;//滑动scrollView时调用此方法刷新图片

@property (nonatomic, retain) UIImage *imagePageStateNormal;
@property (nonatomic, retain) UIImage *imagePageStateHightlighted;

@end
