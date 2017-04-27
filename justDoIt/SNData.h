//
//  SNData.h
//  sdk-demo
//
//  Created by User on 16/3/18.
//  Copyright © 2016年 Scinan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNData : NSObject

+ (void)saveMoney:(NSString *)shareId money:(NSString *)money time:(NSString*)time;
+(NSString*)loadSellMoney;
+(NSString*)loadBuyMoney;
@end
