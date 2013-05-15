//
//  NewViewController.h
//  VOA
//  “最新”容器
//  Created by song zhao on 12-2-2.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "PlayViewController.h"
#import "VOAView.h"
#import <PlausibleDatabase/PlausibleDatabase.h>
#import "VoaViewCell.h"
#import "UIImageView+WebCache.h"
#import "SearchViewController.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"
#import "ASIHTTPRequest.h"
#import "MBProgressHUD.h"
#import "Reachability.h"//isExistenceNetwork
#import "EGORefreshTableHeaderView.h" 
#import "Constants.h"

/**
 *
 */
@interface NewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,ASIHTTPRequestDelegate,MBProgressHUDDelegate,EGORefreshTableHeaderDelegate,UIActionSheetDelegate>
{
    UITableView *voasTableView;
    UITableView *classTableView;
    NSMutableArray *voasArray;
//    NSMutableArray *localArray;
    NSArray *classArray;
    UISearchBar *search;
    MBProgressHUD *HUD;
    NSInteger lastId;
    NSInteger addNum;
    NSInteger pageNum;
    NSInteger category;
    UIButton *titleBtn;
//    BOOL isExisitNet;
    BOOL rightCharacter;
    BOOL _reloading; 
    BOOL isiPhone;
    EGORefreshTableHeaderView *_refreshHeaderView; 
}

@property (nonatomic, retain) IBOutlet UITableView *voasTableView; //新闻表视图
@property (nonatomic, retain) NSMutableArray *voasArray; //存放VOA新闻的数组
@property (nonatomic, retain) NSArray *classArray; //存放所有类别的名称
@property (nonatomic, retain) UIButton *titleBtn; //顶部按钮，
@property (nonatomic, retain) UISearchBar *search; //搜索栏
@property (nonatomic, retain) UITableView *classTableView; //类别选择的表视图
@property (nonatomic, retain) NSString *nowTitle; //记录当前类别名
@property (nonatomic, retain) MBProgressHUD *HUD; //加载等待组件
@property (nonatomic, retain) EGORefreshTableHeaderView *refreshHeaderView; //下拉刷新组件
@property (nonatomic, retain) NSOperationQueue *sharedSingleQueue; //下载队列
@property (nonatomic, retain) NSTimer			*returnTimer;
@property (nonatomic, retain) UIBarButtonItem *returnButton;
@property (nonatomic) BOOL isValid;
@property (nonatomic) NSInteger				lastId; //记录当前所有新闻最大id
@property (nonatomic) NSInteger addNum; //每次刷新添加的新闻数
@property (nonatomic) NSInteger pageNum; //一页十篇，分页加载 表示当前是第几页
@property (nonatomic) NSInteger category; //表示当前新闻的类别号 0：全部 1-9：具体分类
@property (nonatomic) BOOL rightCharacter; //标识所选新闻的内容是否完整
@property (nonatomic) BOOL reloading; //标识下拉刷新
@property (nonatomic) BOOL isiPhone;
@property (nonatomic) BOOL notSelect; //标识是否已点击了某篇新闻，防止加载过程中重复点击

- (void)catchIntroduction:(NSInteger)maxid pages:(NSInteger)pages pageNum:(NSInteger)pageNumOne;
- (void)catchDetails:(VOAView *)voaid;
-(BOOL) isExistenceNetwork:(NSInteger)choose;
- (void)reloadTableViewDataSource; 
- (void)doneLoadingTableViewData; 
//- (void)catchNetA;
//- (IBAction)doReturn:(id)sender;

@end
