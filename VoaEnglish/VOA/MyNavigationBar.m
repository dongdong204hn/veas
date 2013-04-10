//
//  MyNavigationBar.m
//  VOA
//
//  Created by song zhao on 12-3-9.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "MyNavigationBar.h"

@implementation MyNavigationBar

- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"title.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end
