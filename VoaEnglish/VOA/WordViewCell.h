//
//  WordViewCell.h
//  VOA
//  单词列表单元项
//  Created by song zhao on 12-3-9.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

/**
 *
 */
@interface WordViewCell : UITableViewCell
{
    UIButton *audioButton;
    UIButton *defButton;
    UILabel *keyLabel;
    UILabel *pronLabel;
//    MyLabel *defLabel;
}

@property (nonatomic,retain) IBOutlet UIButton *audioButton;
@property (nonatomic,retain) IBOutlet UIButton *defButton;
@property (nonatomic,retain) IBOutlet UILabel *keyLabel;
@property (nonatomic,retain) IBOutlet UILabel *pronLabel;
//@property (nonatomic,retain) IBOutlet MyLabel *defLabel;

//- (void)setMyDelegate:(id <MyLabelDelegate>) myLabelDelegate;

@end
