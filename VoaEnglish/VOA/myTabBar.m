//
//  myTabBar.m
//  VOA
//
//  Created by song zhao on 12-3-8.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "myTabBar.h"

@implementation myTabBar

- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"tabbarOne.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end
