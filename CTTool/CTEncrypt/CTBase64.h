//
//  CTBase64.h
//  JIAMI
//
//  Created by ChiefTse on 15/2/13.
//  Copyright (c) 2015年 ChiefTse. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CTBase64 : NSObject

/**
 *  NSData -> Base64 Encode -> NSData
 *
 *  @param data 将要转换的NSData
 *
 *  @return 返回NSData数据
 */
+ (NSData *)dataByEncodingData:(NSData *)data;

/**
 *  NSString -> Base64 Encode -> NSData
 *
 *  @param string 将要转换的NSString
 *
 *  @return 返回NSData数据
 */
+ (NSData *)dataByEncodingString:(NSString *)string;

/**
 *  NSData -> Base64 Encode -> NSString
 *
 *  @param data 将要转换的NSString
 *
 *  @return 返回NSString数据
 */
+ (NSString *)stringByEncodingData:(NSData *)data;

/**
 *  NSString -> Base64 Encode -> NSString
 *
 *  @param string 将要转换的NSString
 *
 *  @return 返回NSString数据
 */
+ (NSString *)stringByEncodingString:(NSString *)string;

/**
 *  NSData -> Base64 Decode -> NSData
 *  sgkog
 *  @param data 将要转换的NSData
 *
 *  @return 返回NSData数据
 */
+ (NSData *)dataByDecodingData:(NSData *)data;

/**
 *  NSString -> Base64 Decode -> NSData
 *
 *  @param data 将要转换的NSString
 *
 *  @return 返回NSData数据
 */
+ (NSData *)dataByDecodingString:(NSString *)string;

/**
 *  NSData -> Base64 Decode -> NSString
 *
 *  @param data 将要转换的NSData
 *
 *  @return 返回NSString数据
 */
+ (NSString *)stringByDecodingData:(NSData *)data;

/**
 *  NSString -> Base64 Decode -> NSString
 *
 *  @param data 将要转换的NSString
 *
 *  @return 返回NSString数据
 */
+ (NSString *)stringByDecodingString:(NSString *)string;

@end
