//
//  ROPublishFeedResponseItem.h
//  CET6
//
//  Created by Seven Lee on 12-5-17.
//  Copyright (c) 2012年 iyuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ROResponseItem.h"

@interface ROPublishFeedResponseItem : ROResponseItem{
    NSString * _post_id;
}
/*
 *大于0表示新鲜事id，0表示失败 
 */
@property(nonatomic,readonly)NSString *post_id;
@end
