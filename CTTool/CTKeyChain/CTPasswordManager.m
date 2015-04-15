//
//  CTPasswordManager.m
//  CTTool
//
//  Created by Chief Tse on 15/4/14.
//
//

#import "CTPasswordManager.h"
#import "CTKeyChain.h"

@implementation CTPasswordManager

static NSString * const KEY_IN_KEYCHAIN = @"com.TCF.app.allinfo";
static NSString * const KEY_PASSWORD = @"com.TCF.app.password";

+ (void)savePassword:(NSString *)password{
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:password forKey:KEY_PASSWORD];
    [CTKeyChain save:KEY_IN_KEYCHAIN data:usernamepasswordKVPairs];
}

+ (instancetype)readPassword{
    NSDictionary *usernamepasswordKVPair = (NSDictionary *)[CTKeyChain load:KEY_IN_KEYCHAIN];
    return [usernamepasswordKVPair objectForKey:KEY_PASSWORD];
}

+ (void)deletePassword{
    [CTKeyChain delete:KEY_IN_KEYCHAIN];
}

@end
