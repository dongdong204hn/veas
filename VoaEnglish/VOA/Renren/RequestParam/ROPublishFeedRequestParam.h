//
//  ROPublishFeedRequestParam.h
//  CET6
//
//  Created by Seven Lee on 12-5-17.
//  Copyright (c) 2012年 iyuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RORequestParam.h"


@interface ROPublishFeedRequestParam : RORequestParam{
    NSString * _image;
    NSString * _caption;
    NSString * _action_name;
    NSString * _action_link;
    NSString * _message;
}
/**
 *新鲜事图片地址
 */
@property (retain,nonatomic)NSString *image;

/**
 *新鲜事副标题 注意：最多20个字符
 */
@property (copy,nonatomic)NSString *caption;

/**
 *新鲜事动作模块文案。 注意：最多10个字符
 */
@property (copy,nonatomic)NSString *action_name;

/**
 *新鲜事动作模块链接。
 */
@property (copy,nonatomic)NSString *action_link;
/**
 *用户输入的自定义内容。注意：最多200个字符。
 */
@property (copy,nonatomic)NSString *message;
@end
