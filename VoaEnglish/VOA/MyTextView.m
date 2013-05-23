//
//  MyTextView.m
//  VOA
//
//  Created by zhao song on 13-1-17.
//  Copyright (c) 2013年 buaa. All rights reserved.
//

#import "MyTextView.h"

@implementation MyTextView
@synthesize myDelegate;

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
    @try {
        if ([myDelegate respondsToSelector:@selector(catchTouches:myTextView:)]) {
            [myDelegate catchTouches:touches myTextView:self];
        }
        if (self.tag > 199) {
            PlayViewController *player = [PlayViewController sharedPlayer];
            player.wordTouches = touches;
            if (player.nowTextView.tag != self.tag) {
                player.nowTextView = self;
            }

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
