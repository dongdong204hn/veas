//
//  InformationView.h
//  FinalTest
//  “关于爱语吧”容器
//  Created by Seven Lee on 12-1-12.
//  Copyright (c) 2012年 iyuba. All rights reserved.
//

#import "InforController.h"
#import "Reachability.h"//isExistenceNetwork
#import "Constants.h"

@interface InformationView : UIViewController{
    BOOL isiPhone;
}

@property (nonatomic) BOOL isiPhone;

- (IBAction)goUrl:(id)sender;
- (BOOL) isExistenceNetwork:(NSInteger)choose;

@end
