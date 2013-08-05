//
//  SearchViewController.m
//  VOA
//
//  Created by song zhao on 12-2-11.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "SearchViewController.h"

@implementation SearchViewController
@synthesize contentsArray = _contentsArray;
@synthesize contentsSrArray = _contentsSrArray;
@synthesize searchWords = _searchWords;
@synthesize voasTableView = _voasTableView;
@synthesize addNum = _addNum;
@synthesize searchFlg = _searchFlg;
@synthesize HUD = _HUD;
@synthesize isiPhone = _isiPhone;
@synthesize sharedSingleQueue;
@synthesize contentMode = _contentMode;
@synthesize category = _category;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Request Queue
/**
 *  建立一个网络请求队列
 */
- (NSOperationQueue *)sharedQueue
{
    //    static NSOperationQueue *sharedSingleQueue;
    
    @synchronized(self)
    {
        if (!sharedSingleQueue){
            sharedSingleQueue = [[NSOperationQueue alloc] init];
            [sharedSingleQueue setMaxConcurrentOperationCount:1];
        }
        return sharedSingleQueue;
    }
}

#pragma mark - My Action
/**
 *  表视图编辑事件
 */
- (void) doEdit{
	[_voasTableView setEditing:!_voasTableView.editing animated:YES];
	if(_voasTableView.editing)
		self.navigationItem.rightBarButtonItem.title = kSearchOne;
	else
		self.navigationItem.rightBarButtonItem.title = kSearchTwo;
}

#pragma mark - View lifecycle

- (void) viewWillAppear:(BOOL)animated {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        kNetTest;
    });
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad
{
    _isiPhone = ![Constants isPad];
    if (_isiPhone) {
        [_voasTableView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    }else {
        [_voasTableView setFrame:CGRectMake(0, 0, 768, self.view.frame.size.height)];
    }
    _contentsSrArray = [[NSMutableArray alloc] initWithCapacity:10];
    self.navigationController.navigationBarHidden = NO;
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:kSearchTwo style:UIBarButtonItemStylePlain target:self action:@selector(doEdit)];
    self.navigationItem.rightBarButtonItem = editButton;
    [editButton release], editButton = nil;
    self.title = [NSString stringWithFormat:@"%@\"%@\"%@", kSearchThree,_searchWords,kSearchFour];
    if (_searchFlg<11) {
        [self catchResultSy:_searchWords page:1];
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.voasTableView = nil;
    [_contentsSrArray release], _contentsSrArray = nil;
    [_searchWords release], _searchWords = nil;
    [sharedSingleQueue release], sharedSingleQueue = nil;
    [_contentsArray release], _contentsArray = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    _voasTableView.delegate = nil;
    _voasTableView.dataSource = nil;
    [_voasTableView release];
    [_contentsSrArray release];
    [_searchWords release];
    [sharedSingleQueue release];
    [_contentsArray release];
    [super dealloc];
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView //明确cell数目
 numberOfRowsInSection:(NSInteger)section {
    return self.searchFlg > 10 ?[self.contentsArray count] : [_contentsSrArray count]+2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    static NSString *FirstLevelCell= @"SearchCell";
    VoaViewCell *cell = (VoaViewCell*)[tableView dequeueReusableCellWithIdentifier:FirstLevelCell];
    if (!cell) {
        if (_isiPhone) {
            cell = (VoaViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"VoaViewCell" 
                                                                owner:self 
                                                              options:nil] objectAtIndex:0];
        }else {
            cell = (VoaViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"VoaViewCell-iPad" 
                                                                owner:self 
                                                              options:nil] objectAtIndex:0];
        }
    }
    
    VOAContent *content = nil;
    if (self.searchFlg>10) {
        content = [_contentsArray objectAtIndex:row];
    }else{
        if (row == [_contentsSrArray count]) {
            static NSString *SecondLevelCell= @"SearchCellOne";
            UITableViewCell *cellTwo = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:SecondLevelCell];
            if (!cellTwo) {
                if (_isiPhone) {
                    cellTwo = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SecondLevelCell] autorelease];
                }else {
                    cellTwo = (VoaViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"VoaImageCell-iPad" 
                                                                           owner:self 
                                                                         options:nil] objectAtIndex:0];
                }
            }
            if (_addNum == 10) {
                if (_isiPhone) {
                    [cellTwo.imageView setImage:[UIImage imageNamed:@"load.png"]];
                }
            }else{
                [cellTwo setHidden:YES];
            }
            return cellTwo;
        }
        else
        {
            if (row == [_contentsSrArray count]+1) {
                static NSString *ThirdLevelCell= @"SearchCellTwo";
                UITableViewCell *cellThree = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:ThirdLevelCell];
                if (!cellThree) {
                    cellThree = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ThirdLevelCell] autorelease];
                }
                [cellThree setSelectionStyle:UITableViewCellSelectionStyleNone];
                if (_addNum == 10) {
                    [self catchResult:_searchWords page:([_contentsSrArray count]/10)+1];
                    [self.voasTableView reloadData];
                }else{
                    [cellThree setHidden:YES];
                }
                return cellThree;
            }
            content = [_contentsSrArray objectAtIndex:row];
        }
    }
    [cell.myTitle setTextColor:[UIColor purpleColor]];
    cell.myTitle.text = content._title;
    VOAView *nowVoa = [VOAView find:content._voaid];
    cell.readCount.text = [NSString stringWithFormat:@"%i%@", nowVoa._readCount.integerValue+11321, kSearchThirte];
    [cell.myDate setTextColor:[UIColor redColor]];
    cell.myDate.text = [NSString stringWithFormat:@"%@%d%@;%@%d%@",kSearchSix, content._titleNum, kSearchEight, kSearchSeven,content._number,kSearchEight];
    [cell.collectDate setTextColor:[UIColor purpleColor]];
    cell.collectDate.text = nowVoa._creatTime;
    //--------->设置内容换行
    [cell.myTitle setLineBreakMode:UILineBreakModeClip];
    //--------->设置最大行数
    [cell.myTitle setNumberOfLines:3];
    NSURL *url = [NSURL URLWithString: content._pic];
    [cell.myImage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"acquiesce.png"]];
    //        }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;  
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.searchFlg>10?(_isiPhone?80.0f:160.0f):( [indexPath row] < [_contentsSrArray count]? (_isiPhone?80.0f:160.0f): (([indexPath row] < [_contentsSrArray count]+1)?(_isiPhone?28.0f:48.0f):1.0f));
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{	
    if (self.searchFlg>10) {
        [_contentsArray removeObjectAtIndex:indexPath.row];
    }else{
        [_contentsSrArray removeObjectAtIndex:indexPath.row];
    }
	[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}

- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    VOAContent *content = nil;
    if (self.searchFlg>10) {
        content = [_contentsArray objectAtIndex:row];
    }else{
        content = [_contentsSrArray objectAtIndex:row];
    }
    VOAView *voa = [VOAView find:content._voaid];
    _HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow ];
    [[UIApplication sharedApplication].keyWindow addSubview:_HUD];
    _HUD.delegate = self;
    _HUD.labelText = @"Loading";
    _HUD.dimBackground = YES;
    [_HUD show:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{  
            VOADetail *myDetail = [VOADetail find:voa._voaid];
            PlayViewController *play = [PlayViewController sharedPlayer];//新建新界面的controller实例
            if (!myDetail) {
                [VOADetail deleteByVoaid: voa._voaid];
                [self catchDetails:voa];
            }
            if(play.voa._voaid == voa._voaid)
            {
                play.newFile = NO;
            }else
            {
                play.newFile = YES;
                play.voa = voa;
            }
            play.flushList = YES;
            play.contentMode = self.contentMode;
            play.category = self.category;
            [play setHidesBottomBarWhenPushed:YES];//设置推到新界面时无bottomBar
            [self.navigationController pushViewController:play animated:NO];
            [_HUD hide:YES];
        });
    });
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleDelete;
}

#pragma mark - Http connect

/**
 用队列异步从服务器获取搜索的结果
 @param searchWord the keyWord of search
 @param page the pageNumber of the result
 */
- (void)catchResult:(NSString *) searchWord page:(NSInteger)page{
    NSString *url = [NSString stringWithFormat:@"http://apps.iyuba.com/voa/searchApi.jsp?key=%@&format=xml&pages=%d&pageNum=10&parentID=%d&fields=all",searchWord,page,_searchFlg];
    NSOperationQueue *myQueue = [self sharedQueue];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [request setDelegate:self];
    [request setUsername:@"search"];
    //    [request setDidStartSelector:@selector(requestMyStarted:)];
    [request setDidFinishSelector:@selector(requestDone:)];
    [request setDidFailSelector:@selector(requestWentWrong:)];
    [myQueue addOperation:request];
}

/**
 catch search result by syn request from sever
 @param searchWord the keyWord of search
 @param page the pageNumber of the result
 */
- (void)catchResultSy:(NSString *) searchWord page:(NSInteger)page{
    NSString *url = [NSString stringWithFormat:@"http://apps.iyuba.com/voa/searchApi.jsp?key=%@&format=xml&pages=%d&pageNum=10&parentID=%d&fields=all",searchWord,page,_searchFlg];
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    request.delegate = self;
    [request setUsername:@"search"];
    [request startSynchronous];
}

/**
 catch specific content by syn request from sever
 @param voaid 
 */
- (void)catchDetails:(VOAView *) voaid
{
    NSString *url = [NSString stringWithFormat:@"http://apps.iyuba.com/voa/textNewApi.jsp?voaid=%d&format=xml",voaid._voaid];
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    request.delegate = self;
    [request setUsername:@"detail"];
    [request setTag:voaid._voaid];
    [request startSynchronous];
}

- (void)requestWentWrong:(ASIHTTPRequest *)request
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        kNetTest;
    });
    if ([request.username isEqualToString:@"search"])
    {
        UIAlertView * alert = [[[UIAlertView alloc] initWithTitle:kSearchNine message:kSearchTen delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] autorelease];
        [alert setTag:1];
        [alert show];
        [_HUD hide:YES];
    }else
    {
        if ([request.username isEqualToString:@"detail"]) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:kSearchEleven message:[NSString stringWithFormat:@"%@,%@",kSearchEleven,kSearchTwelve] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            [alert release]; 
            [_HUD hide:YES];
        }
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        kNetTest;
    });
    if ([request.username isEqualToString:@"search"])
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:kSearchNine message:kSearchTen delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert setTag:1];
        [alert show];
        [_HUD hide:YES];
    }else
    {
        if ([request.username isEqualToString:@"detail"]) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:kSearchEleven message:[NSString stringWithFormat:@"%@,%@",kSearchEleven,kSearchTwelve] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            [alert release]; 
            [_HUD hide:YES];
        }
    }
    
}

- (void)requestDone:(ASIHTTPRequest *)request
{
    kNetEnable;
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];
    if ([request.username isEqualToString:@"search" ]) {
        /////解析      
        _addNum = 0;
        NSArray *items = [doc nodesForXPath:@"data/voatitle" error:nil];
        if (items) {
            //            addNum = 0;
            for (DDXMLElement *obj in items) {
                VOAView *newVoa = [[VOAView alloc] init];
                newVoa._voaid = [[[obj elementForName:@"voaid"] stringValue] integerValue] ;
                newVoa._title = [[obj elementForName:@"Title"] stringValue];
                newVoa._descCn = [[[obj elementForName:@"DescCn"] stringValue] stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
                newVoa._title_Cn = [[[obj elementForName:@"Title_cn"] stringValue] isEqualToString: @" null"] ? nil :[[obj elementForName:@"Title_cn"] stringValue];
                newVoa._category = [[obj elementForName:@"Category"] stringValue];
                newVoa._sound = [[obj elementForName:@"Sound"] stringValue];
                newVoa._url = [[obj elementForName:@"Url"] stringValue];
                newVoa._pic = [[obj elementForName:@"Pic"] stringValue];
                newVoa._creatTime = [[obj elementForName:@"CreatTime"] stringValue];
                newVoa._publishTime = [[[obj elementForName:@"PublishTime"] stringValue] isEqualToString:@" null"] ? nil :[[obj elementForName:@"PublishTime"] stringValue];
                newVoa._readCount = [[obj elementForName:@"ReadCount"] stringValue];
                newVoa._hotFlg = [[obj elementForName:@"HotFlg"] stringValue];
                newVoa._isRead = @"0";
                if ([VOAView isExist:newVoa._voaid] == NO) {
                    [newVoa insert];
                    //                    NSLog(@"插入%d成功",newVoa._voaid);
                } else {
                    if (newVoa._readCount.integerValue > [[VOAView find:newVoa._voaid] _readCount].integerValue) {
                        [VOAView alterReadCount:newVoa._voaid count:newVoa._readCount.integerValue];
                    }
                }
                
                VOAContent *voaCon = [[VOAContent alloc] init];
                voaCon._voaid = [[[obj elementForName:@"voaid"] stringValue] integerValue] ;
                voaCon._titleNum = [[[obj elementForName:@"titleFind"] stringValue] integerValue];
                voaCon._number = [[[obj elementForName:@"textFind"] stringValue] integerValue];
                voaCon._title = [[[obj elementForName:@"Title"] stringValue] isEqualToString: @"null"] ? nil :[[obj elementForName:@"Title"] stringValue];
                voaCon._pic = [[obj elementForName:@"Pic"] stringValue];
                voaCon._creattime = [[obj elementForName:@"CreatTime"] stringValue];
                [_contentsSrArray addObject:voaCon];
                _addNum++;
                [newVoa release],newVoa = nil;
                [voaCon release],voaCon = nil;
            }
        }
        else{
            
        }
        if (_addNum == 0 && [_contentsSrArray count] == 0) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:kSearchNine message:kSearchTen delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert setTag:1];
            [alert show];
        }
    }else
    {
        if ([request.username isEqualToString:@"detail"]) {
            NSArray *items = [doc nodesForXPath:@"data/voatext" error:nil];
            if (items) {
                
                for (DDXMLElement *obj in items) {
                    VOADetail *newVoaDetail = [[VOADetail alloc] init];
                    newVoaDetail._voaid = request.tag ;
                    newVoaDetail._paraid = [[[obj elementForName:@"ParaId"] stringValue]integerValue];
                    newVoaDetail._idIndex = [[[obj elementForName:@"IdIndex"] stringValue]integerValue];             
                    newVoaDetail._startTiming = [[[obj elementForName:@"Timing"] stringValue] floatValue];
                    newVoaDetail._endTiming = [[[obj elementForName:@"EndTiming"] stringValue] floatValue];
                    newVoaDetail._sentence = [[[obj elementForName:@"Sentence"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
                    newVoaDetail._imgWords = [[[obj elementForName:@"ImgWords"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
                    newVoaDetail._imgPath = [[obj elementForName:@"ImgPath"] stringValue];
                    newVoaDetail._sentence_cn = [[[obj elementForName:@"sentence_cn"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
                    if ([newVoaDetail insertNew]) {
                        //                        NSLog(@"插入%d成功",newVoaDetail._voaid);
                    }
                    [newVoaDetail release],newVoaDetail = nil;
                }
            } 
            [_HUD hide:YES];
        }
        
    }
    [doc release],doc = nil;
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    kNetEnable;
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];
    if ([request.username isEqualToString:@"search" ]) {
        /////解析      
        _addNum = 0;
        NSArray *items = [doc nodesForXPath:@"data/voatitle" error:nil];
        if (items) {
            for (DDXMLElement *obj in items) {
                VOAView *newVoa = [[VOAView alloc] init];
                newVoa._voaid = [[[obj elementForName:@"voaid"] stringValue] integerValue] ;
                newVoa._title = [[obj elementForName:@"Title"] stringValue];
                newVoa._descCn = [[[obj elementForName:@"DescCn"] stringValue] stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
                newVoa._title_Cn = [[[obj elementForName:@"Title_cn"] stringValue] isEqualToString: @" null"] ? nil :[[obj elementForName:@"Title_cn"] stringValue];
                newVoa._category = [[obj elementForName:@"Category"] stringValue];
                newVoa._sound = [[obj elementForName:@"Sound"] stringValue];
                newVoa._url = [[obj elementForName:@"Url"] stringValue];
                newVoa._pic = [[obj elementForName:@"Pic"] stringValue];
                newVoa._creatTime = [[obj elementForName:@"CreatTime"] stringValue];
                newVoa._publishTime = [[[obj elementForName:@"PublishTime"] stringValue] isEqualToString:@" null"] ? nil :[[obj elementForName:@"PublishTime"] stringValue];
                newVoa._readCount = [[obj elementForName:@"ReadCount"] stringValue];
                newVoa._hotFlg = [[obj elementForName:@"HotFlg"] stringValue];
                newVoa._isRead = @"0";
                if ([VOAView isExist:newVoa._voaid] == NO) {
                    [newVoa insert];
                    //                    NSLog(@"插入%d成功",newVoa._voaid);
                } else {
                    if (newVoa._readCount.integerValue > [[VOAView find:newVoa._voaid] _readCount].integerValue) {
                        [VOAView alterReadCount:newVoa._voaid count:newVoa._readCount.integerValue];
                    }
                    
                }
                
                VOAContent *voaCon = [[VOAContent alloc] init];
                voaCon._voaid = [[[obj elementForName:@"voaid"] stringValue] integerValue] ;
                voaCon._titleNum = [[[obj elementForName:@"titleFind"] stringValue] integerValue];
                voaCon._number = [[[obj elementForName:@"textFind"] stringValue] integerValue];
                voaCon._title = [[[obj elementForName:@"Title"] stringValue] isEqualToString: @"null"] ? nil :[[obj elementForName:@"Title"] stringValue];
                voaCon._pic = [[obj elementForName:@"Pic"] stringValue];
                voaCon._creattime = [[obj elementForName:@"CreatTime"] stringValue];
                [_contentsSrArray addObject:voaCon];
                _addNum++;
                [newVoa release],newVoa = nil;
                [voaCon release],voaCon = nil;
            }
        }
        else{
            
        }
        if (_addNum == 0 && [_contentsSrArray count] == 0) {
            UIAlertView * alert = [[[UIAlertView alloc] initWithTitle:kSearchNine message:kSearchTen delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] autorelease];
            [alert setTag:1];
            [alert show];
        }
    }else
    {
        if ([request.username isEqualToString:@"detail"]) {
            NSArray *items = [doc nodesForXPath:@"data/voatext" error:nil];
            if (items) {
                
                for (DDXMLElement *obj in items) {
                    VOADetail *newVoaDetail = [[VOADetail alloc] init];
                    newVoaDetail._voaid = request.tag ;
                    newVoaDetail._paraid = [[[obj elementForName:@"ParaId"] stringValue]integerValue];
                    newVoaDetail._idIndex = [[[obj elementForName:@"IdIndex"] stringValue]integerValue];             
                    newVoaDetail._startTiming = [[[obj elementForName:@"Timing"] stringValue] floatValue];
                    newVoaDetail._endTiming = [[[obj elementForName:@"EndTiming"] stringValue] floatValue];
                    newVoaDetail._sentence = [[[obj elementForName:@"Sentence"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
                    newVoaDetail._imgWords = [[[obj elementForName:@"ImgWords"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
                    newVoaDetail._imgPath = [[obj elementForName:@"ImgPath"] stringValue];
                    newVoaDetail._sentence_cn = [[[obj elementForName:@"sentence_cn"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
                    if ([newVoaDetail insertNew]) {
                        //                        NSLog(@"插入%d成功",newVoaDetail._voaid);
                    }
                    [newVoaDetail release],newVoaDetail = nil;
                    
                }
                
            } 
            [_HUD hide:YES];
        }
        
    }
    [doc release],doc = nil;
}

#pragma mark- Alert Delegate
- (void)modalView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {//点击确定下载为0，取消为1
        if (alertView.tag == 1) {
            [self.navigationController popViewControllerAnimated:NO];
            [alertView release];
        }
        else{
        }
    }
}


@end
