//
//  main.m
//  CTTool
//
//  Created by Chief Tse on 15/4/14.
//
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "CTEncryption.h"

int main(int argc, char * argv[]) {
//    @autoreleasepool {
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//    }
    
    NSLog(@"%@",[CTEncryption sha1:@"1234567890"]);
    NSLog(@"%@",[CTBase64 stringByEncodingString:@"bedzberbedrb"]);
}
