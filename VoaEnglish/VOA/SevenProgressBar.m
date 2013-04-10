//
//  SevenProgressBar.m
//  FinalTest
//
//  Created by Seven Lee on 12-1-31.
//  Copyright (c) 2012年 iyuba. All rights reserved.
//

#import "SevenProgressBar.h"

@implementation SevenProgressBar

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}
-(id)initWithFrame:(CGRect)frame andbackImg:(UIImage*)img frontimg:(UIImage *)fimg{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        backImg.image = img;
        [self addSubview:backImg];
        [backImg release];
        
        frontImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, frame.size.height)];
        frontImg.image = fimg;
        //        frontImg.contentMode = UIViewContentModeLeft;
        //        frontImg.clipsToBounds = YES;
        [self addSubview:frontImg];
        [frontImg release];
    }
    return self;
}
-(void)setProgress:(float)progress
{
	progress=progress<0?0:progress;
	progress=progress>1?1:progress;
	frontImg.frame=CGRectMake(0, 0, progress*(self.frame.size.width), self.frame.size.height);
}
//-(void)dealloc{
//    [backImg removeFromSuperview];
//    [frontImg removeFromSuperview];
//    [super dealloc];
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
