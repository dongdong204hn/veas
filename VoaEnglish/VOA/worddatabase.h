//
//  worddatabase.h
//  VOAAdvanced
//
//  Created by song zhao on 12-6-29.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PlausibleDatabase/PlausibleDatabase.h>
@interface worddatabase : NSObject
+ (PLSqliteDatabase *) setup;

+ (void) close;
@end
