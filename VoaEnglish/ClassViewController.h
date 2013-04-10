//
//  ClassViewController.h
//  VOA
//  类别容器（已舍弃）
//  Created by song zhao on 12-2-2.
//  Copyright (c) 2012年 buaa. All rights reserved.
//
#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ClassViewController : UIViewController
{
    UIButton *at;
    UIButton *ay;
    UIButton *en;
    UIButton *ae;
    UIButton *bs;
    UIButton *hh;
    UIButton *sy;
    UIButton *wd;
    UIButton *ua;
    UIButton *myMove;
    UIImageView *cPg;
    BOOL isiPhone;
}

@property(nonatomic, retain) IBOutlet UIButton *at;
@property(nonatomic, retain) IBOutlet UIButton *ay;
@property(nonatomic, retain) IBOutlet UIButton *en;
@property(nonatomic, retain) IBOutlet UIButton *ae;
@property(nonatomic, retain) IBOutlet UIButton *bs;
@property(nonatomic, retain) IBOutlet UIButton *hh;
@property(nonatomic, retain) IBOutlet UIButton *sy;
@property(nonatomic, retain) IBOutlet UIButton *wd;
@property(nonatomic, retain) IBOutlet UIButton *ua;
@property(nonatomic, retain) IBOutlet UIButton *myMove;
@property(nonatomic, retain) IBOutlet UIImageView *cPg;
@property(nonatomic) BOOL isiPhone;

- (IBAction)buttonPressed:(UIButton *) sender;

@end
