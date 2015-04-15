//
//  CTBase64.m
//  JIAMI
//
//  Created by ChiefTse on 15/2/13.
//  Copyright (c) 2015年 ChiefTse. All rights reserved.
//

#import "CTBase64.h"

@implementation CTBase64

#pragma mark Encode
+ (NSData *)dataByEncodingData:(NSData *)data{
    return [data base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

+ (NSData *)dataByEncodingString:(NSString *)string{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self dataByEncodingData:data];
}

+ (NSString *)stringByEncodingData:(NSData *)data{
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

+ (NSString *)stringByEncodingString:(NSString *)string{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self stringByEncodingData:data];
}

#pragma mark Decode
+ (NSData *)dataByDecodingData:(NSData *)data{
    NSData *da = [[NSData alloc] initWithBase64EncodedData:data
                                                   options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return da;
}

+ (NSData *)dataByDecodingString:(NSString *)string{
    NSData *da = [[NSData alloc] initWithBase64EncodedString:string
                                                     options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return da;
}

+ (NSString *)stringByDecodingData:(NSData *)data{
    return [[NSString alloc] initWithData:[self dataByDecodingData:data]
                                 encoding:NSUTF8StringEncoding];
}

+ (NSString *)stringByDecodingString:(NSString *)string{
    return [[NSString alloc] initWithData:[self dataByDecodingString:string]
                                 encoding:NSUTF8StringEncoding];
    
}
@end
