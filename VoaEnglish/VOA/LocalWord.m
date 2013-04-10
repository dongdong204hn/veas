//
//  LocalWord.m
//  VOAAdvanced
//
//  Created by song zhao on 12-6-29.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "LocalWord.h"

@implementation LocalWord

@synthesize key = _key;
@synthesize audio = _audio;
@synthesize pron = _pron;
@synthesize def = _def;

- (id) initWithKey:(NSString *) key audio:(NSString *) audio pron:(NSString *) pron def:(NSString *) def 
{
    if (self = [super init]) {
        self.key = [key retain];
        self.audio = [audio retain];
        self.pron = [pron retain];
        self.def = [def retain];
    }
    return self;
}

+ (NSString *)decodeFromPercentEscapeString: (NSString *) input  
{  
    NSMutableString *outputStr = [NSMutableString stringWithString:input];  
    [outputStr replaceOccurrencesOfString:@"+"  
                               withString:@" "  
                                  options:NSLiteralSearch  
                                    range:NSMakeRange(0, [outputStr length])];  
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  
}

+ (id) findByKey:(NSString *) key {
	PLSqliteDatabase *dataBase = [worddatabase setup];
    //    const char *myVoaid = [voaid UTF8String];//NSString转变为字符数组
    //    int myVoaid = voaid.intValue;//NSString转变为整型
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select * FROM Words WHERE Word like \'%@\' ;" , key ];
	rs = [dataBase executeQuery:findSql];
//	NSLog(@"本地查词-%@",key);
	LocalWord *word = nil;
	
//	if([rs next]) {
//        NSString *key = [rs objectForColumn:@"Word"];
//        NSString *audio = [rs objectForColumn:@"audio"];
//        NSString *pron = [rs objectForColumn:@"pron"];
//        pron = [self decodeFromPercentEscapeString:pron];
//        NSString *def = [rs objectForColumn:@"def"];
//        word = [[LocalWord alloc] initWithKey:key audio:audio pron:pron def:def];
//	}
//	else {
//        //		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Can not find!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        //		[errAlert show];
//	}
    
    if([rs next]) {
        NSString *myKey = [rs objectForColumn:@"Word"];
        NSString *audio = [rs objectForColumn:@"audio"];
        NSString *pron = [rs objectForColumn:@"pron"];
        pron = [self decodeFromPercentEscapeString:pron];
        NSString *def = [rs objectForColumn:@"def"];
        word = [[LocalWord alloc] initWithKey:myKey audio:audio pron:pron def:def];
	}
	else {
        //        NSString *nonWordEx = @"\\w+s";
        NSString *sufOne = @"s";
        NSString *sufTwo = @"es";
        NSString *sufThree = @"d";
        NSString *sufFour = @"ed";
        NSString *sufFive = @"ing";
        if ([key hasSuffix:sufOne]) {
            //            NSLog(@"s");
            [rs close];
            NSString *keyTwo = [key substringToIndex:key.length - 1];
            findSql = [NSString stringWithFormat:@"select * FROM Words WHERE Word like \'%@\' ;" , keyTwo ];
            //            NSLog(@"findSql:%@",findSql);
            rs = [dataBase executeQuery:findSql];
            if([rs next]) {
                //                NSLog(@"ss");
                NSString *myKey = [rs objectForColumn:@"Word"];
                NSString *audio = [rs objectForColumn:@"audio"];
                NSString *pron = [rs objectForColumn:@"pron"];
                pron = [self decodeFromPercentEscapeString:pron];
                NSString *def = [rs objectForColumn:@"def"];
                word = [[LocalWord alloc] initWithKey:myKey audio:audio pron:pron def:def];
            }
            else {
                //                NSLog(@"s|");
                if ([key hasSuffix:sufTwo]) {
                    [rs close];
                    NSString *keyTwo = [key substringToIndex:key.length - 2];
                    findSql = [NSString stringWithFormat:@"select * FROM Words WHERE Word like \'%@\' ;" , keyTwo ];
                    rs = [dataBase executeQuery:findSql];
                    if([rs next]) {
                        NSString *myKey = [rs objectForColumn:@"Word"];
                        NSString *audio = [rs objectForColumn:@"audio"];
                        NSString *pron = [rs objectForColumn:@"pron"];
                        pron = [self decodeFromPercentEscapeString:pron];
                        NSString *def = [rs objectForColumn:@"def"];
                        word = [[LocalWord alloc] initWithKey:myKey audio:audio pron:pron def:def];
                    }
                }
            } 
        } else if ([key hasSuffix:sufThree]) {
            [rs close];
            NSString *keyTwo = [key substringToIndex:key.length - 1];
            findSql = [NSString stringWithFormat:@"select * FROM Words WHERE Word like \'%@\' ;" , keyTwo ];
            //            NSLog(@"findSql:%@",findSql);
            rs = [dataBase executeQuery:findSql];
            if([rs next]) {
                //                NSLog(@"ss");
                NSString *myKey = [rs objectForColumn:@"Word"];
                NSString *audio = [rs objectForColumn:@"audio"];
                NSString *pron = [rs objectForColumn:@"pron"];
                pron = [self decodeFromPercentEscapeString:pron];
                NSString *def = [rs objectForColumn:@"def"];
                word = [[LocalWord alloc] initWithKey:myKey audio:audio pron:pron def:def];
            }
            else {
                //                NSLog(@"s|");
                if ([key hasSuffix:sufFour]) {
                    [rs close];
                    NSString *keyTwo = [key substringToIndex:key.length - 2];
                    findSql = [NSString stringWithFormat:@"select * FROM Words WHERE Word like \'%@\' ;" , keyTwo ];
                    rs = [dataBase executeQuery:findSql];
                    if([rs next]) {
                        NSString *myKey = [rs objectForColumn:@"Word"];
                        NSString *audio = [rs objectForColumn:@"audio"];
                        NSString *pron = [rs objectForColumn:@"pron"];
                        pron = [self decodeFromPercentEscapeString:pron];
                        NSString *def = [rs objectForColumn:@"def"];
                        word = [[LocalWord alloc] initWithKey:myKey audio:audio pron:pron def:def];
                    }
                }
            } 
        } else if ([key hasSuffix:sufFive]) {
            [rs close];
            NSString *keyTwo = [key substringToIndex:key.length - 3];
            findSql = [NSString stringWithFormat:@"select * FROM Words WHERE Word like \'%@\' ;" , keyTwo ];
            //            NSLog(@"findSql:%@",findSql);
            rs = [dataBase executeQuery:findSql];
            if([rs next]) {
                //                NSLog(@"ss");
                NSString *myKey = [rs objectForColumn:@"Word"];
                NSString *audio = [rs objectForColumn:@"audio"];
                NSString *pron = [rs objectForColumn:@"pron"];
                pron = [self decodeFromPercentEscapeString:pron];
                NSString *def = [rs objectForColumn:@"def"];
                word = [[LocalWord alloc] initWithKey:myKey audio:audio pron:pron def:def];
            }
        } 
        
        
        //		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Can not find!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //		[errAlert show];
	}
	
	[rs close];
    //	[dataBase close];//
	return word;	
}

@end
