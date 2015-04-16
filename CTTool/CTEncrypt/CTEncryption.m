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
    return [self DESWithType:kCCEncrypt Algorithm:kCCAlgorithmDES Text:plainText Key:key];
}

+ (NSString *)DESDecrypt:(NSString *)plainText WithKey:(NSString *)key{
    return [self DESWithType:kCCDecrypt Algorithm:kCCAlgorithmDES Text:plainText Key:key];
}

+ (NSString *)DES3Encrypt:(NSString *)plainText WithKey:(NSString *)key{
    return [self DESWithType:kCCEncrypt Algorithm:kCCAlgorithm3DES Text:plainText Key:key];
}

+ (NSString *)DES3Decrypt:(NSString *)plainText WithKey:(NSString *)key{
    return [self DESWithType:kCCDecrypt Algorithm:kCCAlgorithm3DES Text:plainText Key:key];
}

+ (NSString *)DESWithType:(CCOperation)operation Algorithm:(CCAlgorithm)algorithm Text:(NSString *)text Key:(NSString *)key{
    if (!text || [text isEqualToString:@""]) {
        return @"";
    }
    
    const void *dataIn;
    size_t dataInLength;
    
    if (operation == kCCEncrypt) {
        NSData *encryptData = [text dataUsingEncoding:NSUTF8StringEncoding];
        dataInLength = [encryptData length];
        dataIn = (const void *)[encryptData bytes];
    }
    else{
        NSData *decryptData = [CTBase64 dataByDecodingString:text];
        dataInLength = [decryptData length];
        dataIn = (const void *)[decryptData bytes];
    }
    
    const void *vkey = (const void *) [key UTF8String];
    uint8_t *dataOut            = NULL;
    size_t  dataOutAcailable    = 0;
    size_t  dataOutMoved        = 0;
    
    if (algorithm == kCCAlgorithmDES) {
        dataOutAcailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES -1);
    }
    else{
        dataOutAcailable = (dataInLength + kCCBlockSize3DES) & ~(kCCBlockSize3DES -1);
    }
    
    dataOut = malloc(dataOutAcailable * sizeof(uint8_t));
    memset((void *)dataOut, 0x0, dataOutAcailable);
    
    
    CCCryptorStatus ccStatus = CCCrypt(operation,
                                       algorithm,
                                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                                       vkey,
                                       algorithm == kCCAlgorithmDES ? kCCKeySizeDES : kCCKeySize3DES,
                                       nil,
                                       dataIn,
                                       dataInLength,
                                       (void *)dataOut,
                                       dataOutAcailable,
                                       &dataOutMoved);
    
    if (ccStatus == kCCSuccess) {
        NSData *myData = [NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved];
        if (operation == kCCEncrypt) {
            return [CTBase64 stringByEncodingData:myData];
        }
        else{
            NSString *str = [[NSString alloc] initWithData:myData encoding:NSUTF8StringEncoding];
            return str;
        }
    }
    free(dataOut);
    return nil;
}

@end
