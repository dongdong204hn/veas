//
//  ROPublishFeedRequestParam.m
//  CET6
//
//  Created by Seven Lee on 12-5-17.
//  Copyright (c) 2012年 iyuba. All rights reserved.
//

#import "ROPublishFeedRequestParam.h"
#import "ROPublishFeedResponseItem.h"
#import "ROError.h"

@implementation ROPublishFeedRequestParam
@synthesize image = _image;
@synthesize action_link = _action_link;
@synthesize action_name = _action_name;
@synthesize message = _message;
@synthesize caption = _caption;

-(id)init
{
	if (self = [super init]) {
		self.method = [NSString stringWithFormat:@"feed.publishFeed"];
	}
	
	return self;
}

-(void)addParamToDictionary:(NSMutableDictionary*)dictionary
{
	if (dictionary == nil) {
		return;
	}
	
	if (self.image != nil && ![self.image isEqualToString:@""]) {
		[dictionary setObject:self.image forKey:@"image"];
	}
	
	if (self.action_link != nil && ![self.action_link isEqualToString:@""]) {
		[dictionary setObject:self.action_link forKey:@"action_link"];
	}
    if (self.action_name != nil && ![self.action_name isEqualToString:@""]) {
		[dictionary setObject:self.action_name forKey:@"action_name"];
	}
    if (self.message != nil && ![self.message isEqualToString:@""]) {
		[dictionary setObject:self.message forKey:@"message"];
	}
    if (self.caption != nil && ![self.caption isEqualToString:@""]) {
		[dictionary setObject:self.caption forKey:@"caption"];
	}
}

-(ROResponse*)requestResultToResponse:(id)result
{
	id responseObject = nil;
	if ([result isKindOfClass:[NSArray class]]) {
		responseObject = [[[NSMutableArray alloc] init] autorelease];
		
		for (NSDictionary *item in result) {
			ROPublishFeedResponseItem *responseItem = [[[ROPublishFeedResponseItem alloc] initWithDictionary:item] autorelease];
			[(NSMutableArray*)responseObject addObject:responseItem];
		}
		
		return [ROResponse responseWithRootObject:responseObject];
	} else {
		if ([result objectForKey:@"error_code"] != nil) {
			responseObject = [ROError errorWithRestInfo:result];
			return [ROResponse responseWithError:responseObject];
		}
		
		return [ROResponse responseWithRootObject:responseObject];
	}
}

-(void)dealloc
{
	self.image = nil;
	self.action_name = nil;
    self.action_link = nil;
	self.caption = nil;
    self.message = nil;
	[super dealloc];
}

@end
