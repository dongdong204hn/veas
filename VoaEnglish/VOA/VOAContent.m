//
//  VOAContent.m
//  VOA
//
//  Created by song zhao on 12-2-14.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "VOAContent.h"

@implementation VOAContent
@synthesize _voaid;
@synthesize _content;
@synthesize _titleNum;
@synthesize _number;
@synthesize _title;
@synthesize _creattime;
@synthesize _pic;

/**
 *  按匹配数排序
 */
-(NSComparisonResult) compareNumber: (VOAContent *) p{
    if (self._titleNum>p._titleNum) {
        return  NSOrderedAscending;
    }else
    {
        if (self._titleNum==p._titleNum) {
            if (self._number == p._number) {
                return NSOrderedSame;
            }else
            {
                if (self._number > p._number) {
                    return  NSOrderedAscending;
                }else
                {
                    return NSOrderedDescending;
                }
            }
        }
    }
    return NSOrderedDescending;
}

- (id) initWithVoaId:(NSInteger) voaid content:(NSString *) content title:(NSString *) title creattime:(NSString *) creattime      pic:(NSString *) pic number:(NSInteger) number  titleNum:(NSInteger) titleNum
{
    if (self = [super init]) {
        _voaid = voaid;
        _content = [content retain];
        _title = [title retain];
        _creattime = [creattime retain];
        _pic = [pic retain];
        _number = number;
        _titleNum = titleNum;
    }
    return self;
}


@end
