//
//  HSCButton.m
//  AAAA
//
//  Created by zhangmh on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HSCButton.h"

@implementation HSCButton

@synthesize dragEnable;
@synthesize leftMargin;
@synthesize rightMargin;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!dragEnable) {
        return;
    }
    UITouch *touch = [touches anyObject];
    
    beginPoint = [touch locationInView:self];
    
    [delegate dragMove:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!dragEnable) {
        return;
    }
    UITouch *touch = [touches anyObject];
    
    CGPoint nowPoint = [touch locationInView:self];
    
    float offsetX = nowPoint.x - beginPoint.x;
//    float offsetY = nowPoint.y - beginPoint.y;
    self.center = CGPointMake(self.center.x + offsetX > (self.tag == 2? leftMargin + self.frame.size.width - 15: leftMargin)? (self.center.x + offsetX < (self.tag == 1? rightMargin - self.frame.size.width + 15: rightMargin)? self.center.x + offsetX: (self.tag == 1? rightMargin - self.frame.size.width + 15: rightMargin)): (self.tag == 2? leftMargin + self.frame.size.width - 15: leftMargin), self.center.y);
    
    [delegate dragMove:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [delegate dragEnd:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
