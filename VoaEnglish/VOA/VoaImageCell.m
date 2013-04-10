//
//  VoaImageCell.m
//  VOA
//
//  Created by song zhao on 12-6-25.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "VoaImageCell.h"

@implementation VoaImageCell
@synthesize myImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
	[self.myImage release], myImage = nil;
    [super dealloc];
}

@end
