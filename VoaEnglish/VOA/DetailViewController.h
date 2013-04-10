//
//  DetailViewController.h
//  VOA
//  某类新闻容器（已舍弃）
//  Created by song zhao on 12-2-3.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import <PlausibleDatabase/PlausibleDatabase.h>
#import "VOAView.h"
#import "VoaViewCell.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"
#import "PlayViewController.h"
#import "SearchViewController.h"
#import "Reachability.h"
#import "EGORefreshTableHeaderView.h" 

@interface DetailViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,ASIHTTPRequestDelegate,EGORefreshTableHeaderDelegate> 
{
    UITableView *voasTableView;
    NSMutableArray *voasArray;
    NSMutableArray *voasArrayNet;
    UISearchBar *search;
    NSInteger category;
    NSMutableArray *datesArray;
    NSInteger nowSection;
    MBProgressHUD *HUD;
    NSInteger nowRow;
    NSInteger pageNum;
    NSInteger addNum;
    NSInteger lastId;
    BOOL rightCharacter;
//    BOOL isExisitNet;
    BOOL _reloading;
    BOOL isiPhone;
    EGORefreshTableHeaderView *_refreshHeaderView;
}

@property (nonatomic, retain) NSMutableArray *voasArray;
@property (nonatomic, retain) NSMutableArray *voasArrayNet;
@property (nonatomic) NSInteger category;
@property (nonatomic, retain) NSMutableArray *datesArray;
@property (nonatomic) NSInteger nowSection;
@property (nonatomic) NSInteger nowRow;
@property (nonatomic) NSInteger pageNum;
@property (nonatomic) NSInteger lastId;
@property (nonatomic) NSInteger addNum;
@property (nonatomic) BOOL rightCharacter;
//@property (nonatomic) BOOL isExisitNet;
@property (nonatomic) BOOL reloading;
@property (nonatomic) BOOL isiPhone;
@property (nonatomic, retain) UISearchBar *search;
@property (nonatomic, retain) IBOutlet UITableView *voasTableView;
@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic, retain) EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic, retain) NSOperationQueue *sharedSingleQueue;

- (void)catchIntroduction:(NSInteger)maxid pages:(NSInteger)pages pageNum:(NSInteger)pageNumOne;
- (void)catchDetails:(NSInteger) voaid;
-(BOOL) isExistenceNetwork:(NSInteger)choose;
- (void)reloadTableViewDataSource; 
- (void)doneLoadingTableViewData; 
//- (void)catchNetA;

@end
