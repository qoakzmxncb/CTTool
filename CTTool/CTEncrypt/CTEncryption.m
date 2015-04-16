//
//  C'TEncryption.m
//  JIAMI
//
//  Created by ChiefTse on 15/2/13.
//  Copyright (c) 2015年 ChiefTse. All rights reserved.
//

#import "CTEncryption.h"
#import <CommonCrypto/CommonCrypto.h>

//DES加密时，所用到的偏移量
const Byte iv[] = {1,2,3,4,5,6,7,8};

@implementation CTEncryption

#pragma mark - MD5
+ (NSString *)md5Hex_16:(NSString *)string
{
    return [self md5:string Length:CC_MD5_DIGEST_LENGTH];
}

+ (NSString *)md5Hex_32:(NSString *)string{
    return [self md5:string Length:CC_MD5_DIGEST_LENGTH * 2];
}

+ (NSString *)md5:(NSString *)string Length:(NSInteger)length{
    if ([string isEqualToString:@""]) {
        return @"";
    }
    const char *original_str = [string UTF8String];
    unsigned char result[length];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < length; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

#pragma mark - SHA
+ (NSString *)sha1:(NSString *)string{
    return [self sha:string Length:CC_SHA1_DIGEST_LENGTH];
}

+ (NSString *)sha224:(NSString *)string{
    return [self sha:string Length:CC_SHA224_DIGEST_LENGTH];
}

+ (NSString *)sha256:(NSString *)string{
    return [self sha:string Length:CC_SHA256_DIGEST_LENGTH];
}

+ (NSString *)sha384:(NSString *)string{
    return [self sha:string Length:CC_SHA384_DIGEST_LENGTH];
}

+ (NSString *)sha512:(NSString *)string{
    return [self sha:string Length:CC_SHA512_DIGEST_LENGTH];
}

+ (NSString *)sha:(NSString *)string Length:(NSInteger)length{
    if ([string isEqualToString:@""]) {
        return @"";
    }
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    uint8_t digest[length];
    CC_SHA512(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:length * 2];
    for(int i = 0; i < length; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

#pragma mark - DES
+ (NSString *)DESEncrypt:(NSString *)plainText WithKey:(NSString *)key{
    if(!plainText || [plainText isEqualToString:@""]){
        return @"";
    }
    
    const void *vkey = (const void *) [key UTF8String];
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    const void *vplainText = (const void *)[data bytes];
    size_t plainTextBufferSize = [data length];
    
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    
    size_t bufferPtrSize = plainTextBufferSize + kCCBlockSizeDES;
    uint8_t *bufferPtr = malloc(bufferPtrSize * sizeof(uint8_t));
    size_t movedBytes = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          vkey,
                                          kCCKeySizeDES,
                                          NULL,
                                          vplainText,
                                          plainTextBufferSize,
                                          (void *)bufferPtr,
                                          bufferPtrSize,
                                          &movedBytes);
    
    NSString *ciphertext = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        return [CTBase64 stringByEncodingData:myData];
    }
    return ciphertext;
}

+ (NSString *)DESDecrypt:(NSString *)plainText WithKey:(NSString *)key{
    return nil;
}

+ (NSString *)DES3Encrypt:(NSString *)plainText WithKey:(NSString *)key{
    if(!plainText || [plainText isEqualToString:@""]){
        return @"";
    }
    
    const void *vkey = (const void *) [key UTF8String];
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    const void *vplainText = (const void *)[data bytes];
    size_t plainTextBufferSize = [data length];
    
    size_t bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    uint8_t *bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    size_t movedBytes = 0;
    
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    CCCryptorStatus ccStatus = CCCrypt(kCCEncrypt,
                                       kCCAlgorithm3DES,
                                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                                       vkey,
                                       kCCKeySize3DES,
                                       nil,
                                       vplainText,
                                       plainTextBufferSize,
                                       (void *)bufferPtr,
                                       bufferPtrSize,
                                       &movedBytes);
    
    if (ccStatus == kCCSuccess) {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        return [CTBase64 stringByEncodingData:myData];
    }
    free(bufferPtr);
    return nil;
}

+ (NSString *)DES3Decrypt:(NSString *)plainText WithKey:(NSString *)key{
    return nil;
}

@end
