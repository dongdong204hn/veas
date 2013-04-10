//
//  timeSwitchClass.h
//  JPTListeningLevel-3
//  
//  Created by song zhao on 12-2-6.
//  Copyright (c) 2012年 buaa. All rights reserved.
//
//  v1.0
//　1.将传过来都浮点型都秒时间转化成00：00的形式
//  2.timeToSwitch:有待改进，因为会比正常音频时间少1秒，因为强制类型转换
//  3.timeToSwitchAdvance:已经完美实现

#define ONE_MINUTE 60

@interface timeSwitchClass : NSObject {

}

- (NSMutableString *)timeToSwitch:(double)preTime;
+ (NSString *)timeToSwitchAdvance:(double)preTime;

@end
