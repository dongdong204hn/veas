//
//  GetIPAddress.h
//  TCWeiBoSDKDemo
//
//  Created by wang ying on 12-8-19.
//  Copyright (c) 2012年 bysft. All rights reserved.
//


#define MAXADDRS    32  

extern char *ip_names[MAXADDRS];  

void InitAddresses();  
void GetIPAddresses();  
void GetHWAddresses();  