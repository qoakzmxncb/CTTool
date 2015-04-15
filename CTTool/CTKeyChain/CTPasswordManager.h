//
//  CTPasswordManager.h
//  CTTool
//
//  Created by Chief Tse on 15/4/14.
//
//

#import <Foundation/Foundation.h>

@interface CTPasswordManager : NSObject

/**
 *  保存密码
 *
 *  @param password
 */
+ (void)savePassword:(NSString *)password;

/**
 *  读取密码
 *
 *  @return
 */
+ (instancetype)readPassword;

/**
 *  删除密码
 */
+ (void)deletePassword;

@end
