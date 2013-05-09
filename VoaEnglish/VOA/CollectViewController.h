//
//  CollectViewController.h
//  VOA
//  本地容器
//  Created by song zhao on 12-2-2.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "VOAView.h"
#import <PlausibleDatabase/PlausibleDatabase.h>
#import "VoaViewCell.h"
#import "SearchViewController.h"
#import "VOAFav.h"
#import "VOASentence.h"
#import "PlayViewController.h"
#import "SentenceViewController.h"
#import "ASIFormDataRequest.h"

/**
 *
 */
@interface CollectViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,MBProgressHUDDelegate> 
{
    UITableView *voasTableView;
    UISegmentedControl *segmentedControl; //进行“新闻”和“句子”选择的组件
    NSMutableArray *favArray; //存放本地新闻的数组
    NSMutableArray *senArray; //存放本地句子数组
    UISearchBar *search; //搜索栏
    MBProgressHUD *HUD;
    BOOL isiPhone;
    BOOL isSentence;
    NSInteger nowUserId;
    //    NSMutableArray *voasArray;
}

@property (nonatomic, retain) IBOutlet UITableView *voasTableView;
@property (nonatomic, retain) NSOperationQueue *sharedSingleQueue;
@property (nonatomic, retain) UISegmentedControl *segmentedControl;
@property (nonatomic, retain) NSMutableArray *favArray;
@property (nonatomic, retain) NSMutableArray *senArray;
@property (nonatomic, retain) UISearchBar *search;
@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic) BOOL isiPhone;
@property (nonatomic) NSInteger nowUserId;
@property (nonatomic) BOOL rightCharacter;
@property (nonatomic) BOOL notSelect;
@property (nonatomic) BOOL isSentence ;
//@property (nonatomic, retain) NSMutableArray *voasArray;
@end
