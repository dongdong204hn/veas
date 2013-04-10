//
//  ROPublishFeedResponseItem.m
//  CET6
//
//  Created by Seven Lee on 12-5-17.
//  Copyright (c) 2012年 iyuba. All rights reserved.
//

#import "ROPublishFeedResponseItem.h"

@implementation ROPublishFeedResponseItem
@synthesize post_id = _post_id;

-(id)initWithDictionary:(NSDictionary*)responseDictionary
{
    self = [super initWithDictionary:responseDictionary];
    if (self) {
        _post_id = [self valueForItemKey:@"post_id"];
    }
    return self;
}
- (void)dealloc{
    _post_id = nil;
    [super dealloc];
}
@end
