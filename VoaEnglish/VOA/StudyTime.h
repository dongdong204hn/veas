//
//  StudyTime.h
//  VOA
//  记录用户学习时间的数据类
//  Created by zhao song on 13-1-26.
//  Copyright (c) 2013年 buaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "favdatabase.h"

@interface StudyTime : NSObject

@property (nonatomic) NSInteger timeId; //实例编号id 主键
@property (nonatomic) NSInteger userId;
@property (nonatomic) NSInteger seconds; //秒数时长
@property (nonatomic, retain) NSString *date; //日期 **-**-**
@property (nonatomic, retain) NSString *beginTime; //开始时间 **:**:**
@property (nonatomic, retain) NSString *endTime; //结束时间 **:**:**

- (id) initWithTimeId:(NSInteger) timeId userId:(NSInteger) userId seconds:(NSInteger) seconds date:(NSString *) date beginTime:(NSString *) beginTime endTime:(NSString *) endTime;

- (BOOL) insert;

+ (NSInteger) findLastId;

+ (NSInteger)avgStudyTime:(NSString *) date;

+ (NSInteger)findSecsByDate:(NSString *) date;
@end
