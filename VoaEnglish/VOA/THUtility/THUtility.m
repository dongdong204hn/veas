//
//  THUtility.m
//  VOA
//
//  Created by TanHao on 12-12-10.
//  Copyright (c) 2012年 tanhao.me. All rights reserved.
//

#import "THUtility.h"

static const char  g_Base64EncodingTable[64]  = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static const short g_Base64DecodingTable[256] = {
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
	52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
	-2,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
	15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
	-2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
	41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2
};


@implementation THUtility

+ (uint8_t *)base64BufferwithData:(NSData *)objData length:(uint64_t*)length
{
    if (length == NULL)
    {
        return NULL;
    }
    
    const uint8_t * objRawData = [objData bytes];
    uint64_t objLength = [objData length];
    
    if (objLength == 0)
    {
        return NULL;
    }
    
    *length = ((objLength+2)/3)*4;
    uint8_t *buffer = (uint8_t *)calloc(*length, sizeof(uint8_t));
    uint8_t *writePoint = buffer;
    for (int i=0; i<objLength; i+=3)
    {
        uint8_t char1 = objRawData[i];
        *writePoint++ = g_Base64EncodingTable[char1>>2]; //1
        
        if (i+1>=objLength)
        {
            *writePoint++ = g_Base64EncodingTable[(char1&0x03)<<4]; //2
            *writePoint++ = '=';  //3
            *writePoint++ = '=';  //4
            break;
        }
        uint8_t char2 = objRawData[i+1];
        *writePoint++ = g_Base64EncodingTable[((char1&0x03)<<4)+(char2>>4)]; //2
        
        if (i+2>=objLength)
        {
            *writePoint++ = g_Base64EncodingTable[(char2&0x0F)<<2]; //3
            *writePoint++ = '=';  //4
            break;
        }
        
        uint8_t char3 = objRawData[i+2];
        *writePoint++ = g_Base64EncodingTable[((char2&0x0F)<<2)+(char3>>6)]; //3
        *writePoint++ = g_Base64EncodingTable[char3&0x3F]; //4
    }
    
    return buffer;
}

+ (uint8_t *)bufferWithBase64Data:(NSData *)objData length:(uint64_t*)length
{
    if (length == NULL)
    {
        return NULL;
    }
    
    const unsigned char * objRawData = [objData bytes];
    uint64_t objLength = [objData length];
    
    if (objLength == 0)
    {
        return NULL;
    }
    
    *length = (objLength/4)*3;
    uint8_t *buffer = (uint8_t *)calloc(*length, sizeof(uint8_t));
    uint8_t *writePoint = buffer;
    
    int i=0,writeCount=0;
    uint8_t item[4]={0};
    while (i<objLength)
    {
        uint8_t charCurrent = objRawData[i++];
        int8_t valueCurrent = g_Base64DecodingTable[charCurrent];
        
        if (i<objLength && valueCurrent<0)
        {
            continue;
        }
        
        int8_t idx = writeCount%4;
        
        if (idx == 0)
        {
            item[1] = 0;
            item[2] = 0;
            item[3] = 0;
        }
        item[idx] = valueCurrent>=0?valueCurrent:0;
        
        if (i==objLength || writeCount%4==3)
        {
            *writePoint++ = (item[0]<<2)+(item[1]>>4);
            *writePoint++ = ((item[1]&0x0F)<<4)+(item[2]>>2);
            *writePoint++ = ((item[2]&0x03)<<6)+item[3];
        }
        
        writeCount++;
    }
    
    *length = ((writeCount+3)/4)*3;
    
    return buffer;
}

+ (NSString *)encodeBase64WithData:(NSData *)objData
{
    uint64_t length = 0;
    uint8_t *buffer = [self base64BufferwithData:objData length:&length];
    if (buffer == NULL)
    {
        return nil;
    }
    
    NSString *resultString = [[NSString alloc] initWithBytes:buffer length:length encoding:NSASCIIStringEncoding];
    free(buffer);
    return resultString;
}

+ (NSData *)decodeBase64WithString:(NSString *)string
{
    NSData *objData = [string dataUsingEncoding:NSASCIIStringEncoding];
    if ([objData length] < 4)
    {
        return nil;
    }
    uint64_t length = 0;
    uint8_t *buffer = [self bufferWithBase64Data:objData length:&length];
    if (buffer == NULL)
    {
        return nil;
    }
    NSData *resultData = [[NSData alloc] initWithBytes:buffer length:length];
    free(buffer);
    return resultData;
}

+ (NSString *)encodeBase64AtURL:(NSURL *)fileUrl
{
    NSError *error = nil;
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingFromURL:fileUrl error:&error];
    
    if (!fileHandle)
    {
        return nil;
    }
    
    uint64_t size = [fileHandle seekToEndOfFile];
    [fileHandle seekToFileOffset:0];
    
    NSMutableData *resultData = [[NSMutableData alloc] initWithCapacity:((size+2)/3)*4];
    while ([fileHandle offsetInFile] != size)
    {
        NSData *objData = [fileHandle readDataOfLength:3*1024];
        
        uint64_t length = 0;
        uint8_t *buffer = [self base64BufferwithData:objData length:&length];
        if (buffer == NULL)
        {
            [fileHandle closeFile];
            return nil;
        }
        
        [resultData appendBytes:buffer length:length];
        free(buffer);
    }
    [fileHandle closeFile];
    NSString *resultString = [[NSString alloc] initWithData:resultData encoding:NSASCIIStringEncoding];
    
    return resultString;
}

+ (NSData *)decodeBase64AtURL:(NSURL *)fileUrl
{
    NSError *error = nil;
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingFromURL:fileUrl error:&error];
    
    if (!fileHandle)
    {
        return nil;
    }
    
    uint64_t size = [fileHandle seekToEndOfFile];
    [fileHandle seekToFileOffset:0];
    
    NSMutableData *resultData = [[NSMutableData alloc] initWithCapacity:((size+3)/4)*3];
    while ([fileHandle offsetInFile] != size)
    {
        NSData *objData = [fileHandle readDataOfLength:4*1024];
        
        uint64_t length = 0;
        uint8_t *buffer = [self bufferWithBase64Data:objData length:&length];
        if (buffer == NULL)
        {
            [fileHandle closeFile];
            return nil;
        }        
        
        [resultData appendBytes:buffer length:length];
        free(buffer);
    }
    [fileHandle closeFile];
    
    return resultData;
}

+ (BOOL)encodeBase64AtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL
{
    NSError *error = nil;
    NSFileHandle *srcHandle = [NSFileHandle fileHandleForReadingFromURL:srcURL error:&error];
    if (!srcHandle)
    {
        return NO;
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[dstURL path]])
    {
        BOOL sucess = [[NSFileManager defaultManager] createFileAtPath:[dstURL path] contents:nil attributes:nil];
        if (!sucess)
        {
            [srcHandle closeFile];
            return NO;
        }
    }
    
    NSFileHandle *dstHandle = [NSFileHandle fileHandleForWritingToURL:dstURL error:&error];
    if (!dstHandle)
    {
        [srcHandle closeFile];
        return NO;
    }
    
    uint64_t size = [srcHandle seekToEndOfFile];
    [srcHandle seekToFileOffset:0];
    
    while ([srcHandle offsetInFile] != size)
    {
        NSData *objData = [srcHandle readDataOfLength:3*1024];
        
        uint64_t length = 0;
        uint8_t *buffer = [self base64BufferwithData:objData length:&length];
        if (buffer == NULL)
        {
            [srcHandle closeFile];
            [dstHandle closeFile];
            return NO;
        }
        
        NSData *subData = [[NSData alloc] initWithBytes:buffer length:length];
        [dstHandle writeData:subData];
        free(buffer);
    }
    
    [srcHandle closeFile];
    [dstHandle closeFile];
    
    return YES;
}

+ (BOOL)decodeBase64AtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL
{
    NSError *error = nil;
    NSFileHandle *srcHandle = [NSFileHandle fileHandleForReadingFromURL:srcURL error:&error];
    if (!srcHandle)
    {
        return NO;
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[dstURL path]])
    {
        BOOL sucess = [[NSFileManager defaultManager] createFileAtPath:[dstURL path] contents:nil attributes:nil];
        if (!sucess)
        {
            [srcHandle closeFile];
            return NO;
        }
    }
    
    NSFileHandle *dstHandle = [NSFileHandle fileHandleForWritingToURL:dstURL error:&error];
    if (!dstHandle)
    {
        [srcHandle closeFile];
        return NO;
    }
    
    uint64_t size = [srcHandle seekToEndOfFile];
    [srcHandle seekToFileOffset:0];
    
    while ([srcHandle offsetInFile] != size)
    {
        NSData *objData = [srcHandle readDataOfLength:4*1024];
        
        uint64_t length = 0;
        uint8_t *buffer = [self bufferWithBase64Data:objData length:&length];
        if (buffer == NULL)
        {
            [srcHandle closeFile];
            [dstHandle closeFile];
            return NO;
        }
        
        NSData *subData = [[NSData alloc] initWithBytes:buffer length:length];
        [dstHandle writeData:subData];
        free(buffer);
    }
    
    [srcHandle closeFile];
    [dstHandle closeFile];
    
    return YES;
}

@end
