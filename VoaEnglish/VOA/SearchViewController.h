//
//  SearchViewController.h
//  VOA
//  展示搜索结果的容器
//  Created by song zhao on 12-2-11.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "VOAView.h"
#import "VoaViewCell.h"
#import "UIImageView+WebCache.h"
#import "PlayViewController.h"

/**
 *  展示搜索结果的容器
 */
@interface SearchViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,ASIHTTPRequestDelegate,MBProgressHUDDelegate,UIAlertViewDelegate> 
{
    NSMutableArray *_contentsArray; //存放本地搜索的结果
    NSMutableArray *_contentsSrArray; //存放联网搜索的结果
    UITableView *_voasTableView; 
    NSString *_searchWords;
    NSInteger _addNum; //每次刷新添加的新闻数
    NSInteger _searchFlg; //标记搜索的类别 0:全部 1-9：9个分类 11：本地
    NSInteger _contentMode; //1：联网搜索 2：本地搜索
    MBProgressHUD *_HUD;
    BOOL _isiPhone;
    NSInteger _category; //标记新闻所属分类
}

@property (nonatomic, retain) IBOutlet UITableView *voasTableView;
@property (nonatomic, retain) NSMutableArray *contentsArray;
@property (nonatomic, retain) NSString *searchWords;
@property (nonatomic, retain) NSOperationQueue *sharedSingleQueue;
@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic, retain) NSMutableArray *contentsSrArray;
@property (nonatomic, assign) NSInteger addNum;
@property (nonatomic, assign) NSInteger searchFlg;
@property (nonatomic, assign) NSInteger contentMode;
@property (nonatomic) BOOL isiPhone;
@property (nonatomic) NSInteger category;

- (void)catchDetails:(VOAView *) voaid;
- (void)catchResult:(NSString *) searchWord page:(NSInteger)page;

@end
