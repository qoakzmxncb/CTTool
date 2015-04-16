//
//  C'TEncryption.h
//  JIAMI
//
//  Created by ChiefTse on 15/2/13.
//  Copyright (c) 2015年 ChiefTse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTBase64.h"

@interface CTEncryption : NSObject

#pragma mark - MD5
/**
 *  MD5加密，返回16位加密信息
 *
 *  @param string 将要加密的string
 *
 *  @return 返回NSString数据
 */
+ (NSString *)md5Hex_16:(NSString *)string;

/**
 *  MD5加密，返回32位加密信息
 *
 *  @param string 将要加密的string
 *
 *  @return 返回NSString数据
 */
+ (NSString *)md5Hex_32:(NSString *)string;

#pragma mark - SHA
/**
 *  SHA-1加密
 *
 *  @param string 将要加密的string
 *
 *  @return 返回NSString数据
 */
+ (NSString *)sha1:(NSString *)string;

/**
 *  SHA-224加密
 *
 *  @param string 将要加密的string
 *
 *  @return 返回NSString数据
 */
+ (NSString *)sha224:(NSString *)string;

/**
 *  SHA-256加密
 *
 *  @param string 将要加密的string
 *
 *  @return 返回NSString数据
 */
+ (NSString *)sha256:(NSString *)string;

/**
 *  SHA-384加密
 *
 *  @param string 将要加密的string
 *
 *  @return 返回NSString数据
 */
+ (NSString *)sha384:(NSString *)string;

/**
 *  SHA-512加密
 *
 *  @param string 将要加密的string
 *
 *  @return 返回NSString数据
 */
+ (NSString *)sha512:(NSString *)string;

#pragma mark - DES
+ (NSString *)DESEncrypt:(NSString *)plainText WithKey:(NSString *)key;

+ (NSString *)DESDecrypt:(NSString *)plainText WithKey:(NSString *)key;

+ (NSString *)DES3Encrypt:(NSString *)plainText WithKey:(NSString *)key;

+ (NSString *)DES3Decrypt:(NSString *)plainText WithKey:(NSString *)key;

@end
