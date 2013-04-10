//
//  MyLabel.m
//  VOA
//
//  Created by song zhao on 12-2-20.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "MyLabel.h"

@implementation MyLabel

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame])
    {
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [delegate touchUpInside :touches mylabel:self ];
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //    [delegate touchUpInside :touches mylabel:self ];
    touchTime = 0;
    turnOff = NO;
    myTouches = touches;
    touchTimer = [NSTimer scheduledTimerWithTimeInterval:0.5f
                                                  target:self
                                                selector:@selector(handleTimer)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)handleTimer {
    touchTime++;
    if (touchTime>0) {
        [delegate touchUpInsideLong:myTouches mylabel:self ];
        [touchTimer invalidate];
        touchTimer = nil;
        turnOff = YES;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!turnOff && touchTime == 0) {
        [touchTimer invalidate];
        touchTimer = nil;
        [delegate touchUpInside:touches mylabel:self] ;
    }
}

- (void)dealloc {
    self.delegate = nil;
    [super dealloc];
}

@end
