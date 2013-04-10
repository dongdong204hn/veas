//
//  TextScrollViewDelegate.m
//  VOA
//
//  Created by song zhao on 12-2-19.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "TextScrollView.h"

@implementation TextScrollView

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event{ 
    if(!self.dragging) 
    { 
        [[self nextResponder]touchesBegan:touches withEvent:event]; 
    } 
    [super touchesBegan:touches withEvent:event]; 
} 

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event 
{ 
    if(!self.dragging) 
    { 
        [[self nextResponder]touchesEnded:touches withEvent:event]; 
    } 
    [super touchesEnded:touches withEvent:event]; 
} 

@end
