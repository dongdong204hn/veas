//
//  timeSwitchClass.m
//  VOA
//
//  Created by song zhao on 12-2-6.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "timeSwitchClass.h"


@implementation timeSwitchClass


- (NSMutableString *)timeToSwitch:(double)preTime{
	
	int minute = (int)preTime / ONE_MINUTE;
	int second = (int)preTime % ONE_MINUTE;
	NSMutableString *timeStr = [NSMutableString stringWithFormat: @"%d:%d", minute, second];
	return (timeStr);
}

+ (NSString *)timeToSwitchAdvance:(double)preTime{
	NSInteger currTime=round(preTime);
    int value_m= currTime%(60*60)/60;
    int value_s= currTime%(60*60)%60%60;
    
    NSString *minString;
    NSString *secString;
    
    if (value_m<10){
        minString=[NSString stringWithFormat:@"0%d:",value_m];
    }
    else {
        minString=[NSString stringWithFormat:@"%d:",value_m];
    }
	
    if (value_s<10){
        secString=[NSString stringWithFormat:@"0%d",value_s];
    }
    else {
        secString=[NSString stringWithFormat:@"%d",value_s];
    }
    
    //当前播放时间字符串MM:SS
    NSString *nowCurrTime=[minString stringByAppendingString:secString];
	return (nowCurrTime);
}

@end
