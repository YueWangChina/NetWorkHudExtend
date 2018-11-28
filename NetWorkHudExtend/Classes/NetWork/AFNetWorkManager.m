//
//  AFNetWorkManager.m
//  XDYCar
//
//  Created by xdy on 2018/5/3.
//  Copyright © 2018年 xindongyuan. All rights reserved.
//

#import "AFNetWorkManager.h"
typedef NS_ENUM(NSInteger, AFNetWorkType) {
    AFNetWorkTypeGet  = 0,
    AFNetWorkTypePost     = 1,
    
};
@implementation AFNetWorkManager
+ (instancetype)sharedNetWork{
    
    static AFNetWorkManager * manager = nil;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForRequest = 20.0;
#if DEBUG
        manager = [[AFNetWorkManager alloc]initWithBaseURL:[NSURL URLWithString:TestURL] sessionConfiguration:config];
#else
        manager = [[AFNetWorkManager alloc]initWithBaseURL:[NSURL URLWithString:TestURL] sessionConfiguration:config];
#endif

        
    });
    return manager;
}
#pragma mark - 重写initWithBaseURL
- (instancetype)initWithBaseURL:(NSURL *)url{
    
    if (self = [super initWithBaseURL:url]) {

        /**设置相应的缓存策略*/
        //        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        /**分别设置请求以及相应的序列化器*/
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        AFJSONResponseSerializer * response = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;
        self.responseSerializer = response;
//        [self.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//        self.requestSerializer.timeoutInterval = 10.0f;
//        [self.requestSerializer didChangeValueForKey:@"timeoutInterval"];

        
        /**设置接受的类型*/
        [self.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",@"multipart/form-data",@"application/json",@"text/json",@"text/javascript",@"text/html", nil ,nil]];
        /**复杂的参数类型 需要使用json传值-设置请求内容的类型*/
        [self.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];

    }
    
    return self;
    
    
    
}
#pragma mark - 打印URL串
+ (NSString *)HTTPStrWithDict:(NSDictionary *)parameters with:(NSString *)baseUrl with:(NSString *)subUrl
{
    if (![parameters isKindOfClass:[NSDictionary class]]) {
        return @"" ;
    }
    NSArray *ascendingArray = [AFNetWorkManager ascendingWithDataArray:[parameters allKeys]];
    NSString *tempStr = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"%@",subUrl]];
    for (int i = 0;i<ascendingArray.count;i++) {
        
        NSString * lowercaseStr = ascendingArray[i];
        
        NSString * parameterStr = [NSString stringWithFormat:@"%@=%@&",lowercaseStr,parameters[lowercaseStr]];
        
        tempStr = [tempStr stringByAppendingString:parameterStr];
        
    }
    NSString *lastStr = [tempStr substringToIndex:[tempStr length] - 1];
    return lastStr;
}
//单词数组升序排列方法
+ (NSArray *)ascendingWithDataArray:(NSArray *)dataArray
{
    
    NSArray *result = [dataArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        return [obj1 compare:obj2]; //升序
        
    }];
    //    NSLog(@"字符串数组排序结果%@",result);
    
    
    
    
    return result;
}

@end
