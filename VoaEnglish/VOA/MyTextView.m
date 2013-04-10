//
//  MyTextView.m
//  VOA
//
//  Created by zhao song on 13-1-17.
//  Copyright (c) 2013年 buaa. All rights reserved.
//

#import "MyTextView.h"

@implementation MyTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event{
//    if(!self.dragging)
//    {
//        [[self nextResponder]touchesBegan:touches withEvent:event];
//    }
    
//    NSLog(@"my text touch");
//    selectWord = [textViewOne.text substringWithRange:textViewOne.selectedRange];
//    [selectWord retain];
    @try {
        PlayViewController *player = [PlayViewController sharedPlayer];
////        [player.selectWord release];
//        player.selectWord = [self.text substringWithRange:self.selectedRange];
//        [player.selectWord retain];
//        NSLog(@"ca");
        player.wordTouches = touches;
        if (player.nowTextView.tag != self.tag) {
            player.nowTextView = self;
        }
        
//        NSLog(@"my text touch:%@", [self.text substringWithRange:self.selectedRange]);
    }
    @catch (NSException *exception) {
        NSLog(@"NSException");
    }
    @finally {
        [super touchesBegan:touches withEvent:event];
    }
    
}

@end
