//
//  AFNetWorkManager.h
//  XDYCar
//
//  Created by xdy on 2018/5/3.
//  Copyright © 2018年 xindongyuan. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#define BaseUrl(URL) [NSString stringWithFormat:@"%@", (URL)]
@interface AFNetWorkManager : AFHTTPSessionManager

+ (instancetype)sharedNetWork;
//打印URL
#pragma mark - 打印URL串
+ (NSString *)HTTPStrWithDict:(NSDictionary *)parameters with:(NSString *)baseUrl with:(NSString *)subUrl;

+ (NSArray *)ascendingWithDataArray:(NSArray *)dataArray;
@end
