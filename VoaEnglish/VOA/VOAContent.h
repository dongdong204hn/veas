//
//  VOAContent.h
//  VOA
//  新闻关键字搜索结果类
//  Created by song zhao on 12-2-14.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VOAContent : NSObject
{
    NSInteger _voaid;
    NSString *_content; //全部内容
    NSString *_title; //标题
    NSString *_creattime; //新闻日期
    NSString *_pic;
    NSInteger _number; //标题匹配数
    NSInteger _titleNum; //内容匹配数
}

@property NSInteger _voaid;
@property (nonatomic,retain) NSString *_content;
@property (nonatomic,retain) NSString *_title;
@property (nonatomic,retain) NSString *_creattime;
@property (nonatomic,retain) NSString *_pic;
@property NSInteger _number;
@property NSInteger _titleNum;

- (id) initWithVoaId:(NSInteger) voaid content:(NSString *) content title:(NSString *) title creattime:(NSString *) creattime pic:(NSString *) pic number:(NSInteger) number titleNum:(NSInteger) titleNum ;
-(NSComparisonResult) compareNumber: (VOAContent *) p;

@end
