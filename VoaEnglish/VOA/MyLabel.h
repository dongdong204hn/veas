//
//  MyLabel.h
//  VOA
//
//  Created by song zhao on 12-2-20.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

@class MyLabel;

@protocol MyLabelDelegate <NSObject>
@required
- (void)touchUpInside: (NSSet *)touches mylabel:(MyLabel *)mylabel ;
@optional
- (void)touchUpInsideLong: (NSSet *)touches mylabel:(MyLabel *)mylabel ;
@end

@interface MyLabel : UILabel {
    id <MyLabelDelegate> delegate;
    NSInteger touchTime;
    NSTimer		*touchTimer;
    NSSet *myTouches;
    BOOL turnOff;
}

@property (nonatomic, assign) id <MyLabelDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;

@end
