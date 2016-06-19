//
//  YKTouchIDAuthodManager.h
//  MyCoffee
//
//  Created by yk on 16/5/18.
//  Copyright © 2016年 coderYK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

@interface YKTouchIDAuthodManager : NSObject

/**
 *  发起指纹认证
 *
 *  @param completedBlock 指纹认证成功后的回调
 */
+ (void)authodYourTouchIDCompleted:(void (^)(void))completedBlock;

@end
