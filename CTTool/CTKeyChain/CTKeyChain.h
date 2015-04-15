//
//  CTKeyChain.h
//  CTTool
//
//  Created by Chief Tse on 15/4/14.
//
//

#import <Foundation/Foundation.h>

@interface CTKeyChain : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;

@end
