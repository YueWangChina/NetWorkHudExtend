//
//  AFHTTPSession.m
//  XDYCar
//
//  Created by xdy on 2018/5/3.
//  Copyright © 2018年 xindongyuan. All rights reserved.
//

#import "AFHTTPSession.h"
#import "AFNetWorkManager.h"
#import "MBProgressHUD+NHAdd.h"
@implementation AFHTTPSession


+(void)dealBackStateWithResponse:(id)responseObject completeBlock:(nullable completeBlock)completeBlock
{
    if ([responseObject isKindOfClass:[NSData class]]) {
        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    }
    NSLog(@"dict start ----\n%@   \n ---- end  -- ", responseObject);
    NSString *statusStr = [NSString stringWithFormat:@"%@",responseObject[@"status"]];
 if([statusStr isEqualToString:@"200"]){
        // 请求成功，解析数据
        completeBlock(responseObject,nil,nil);
    }else if ([statusStr isEqualToString:@"400"]){

        completeBlock(nil,responseObject[@"message"],nil);
        
        
        
    }
}


+ (nullable NSURLSessionDataTask *)GET:(nonnull NSString *)urlString
                             paraments:(nullable id)paraments
                         completeBlock:(nullable completeBlock)completeBlock
{
    
        NSLog(@"---url---%@",[AFNetWorkManager HTTPStrWithDict:paraments with:[NSString stringWithFormat:@"%@",[AFNetWorkManager sharedNetWork].baseURL] with:urlString]);
    return [[AFNetWorkManager sharedNetWork] GET:urlString
                                      parameters:paraments
                                        progress:^(NSProgress * _Nonnull downloadProgress) {
                                        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                            [self dealBackStateWithResponse:responseObject completeBlock:completeBlock];
                                            
                                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                            [MBProgressHUD hideHUD];
                                            // 请求失败
                                            NSDictionary *dictionary = error.userInfo;
                                            if (dictionary[@"NSLocalizedDescription"]) {
                                                completeBlock(nil,dictionary[@"NSLocalizedDescription"],nil);
                                                [MBProgressHUD showTitleToView:nil postion:NHHUDPostionCenten title:[error localizedDescription]];
                                            }else{
                                                completeBlock(nil,nil,error);
                                            }
                                        }];
}

+ (nullable NSURLSessionDataTask *)POST:(nonnull NSString *)urlString
                              paraments:(nullable id)paraments
                          completeBlock:(nullable completeBlock)completeBlock
{
    // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误
    NSLog(@"---url---%@",[AFNetWorkManager HTTPStrWithDict:paraments with:[NSString stringWithFormat:@"%@",[AFNetWorkManager sharedNetWork].baseURL] with:urlString]);
    [AFNetWorkManager sharedNetWork].requestSerializer = [AFJSONRequestSerializer serializer];//请求
    [AFNetWorkManager sharedNetWork].responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    // post请求
    return  [[AFNetWorkManager sharedNetWork] POST:urlString parameters:paraments progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self dealBackStateWithResponse:responseObject completeBlock:completeBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", [error localizedDescription]);
        [MBProgressHUD hideHUD];
        // 请求失败
        NSDictionary *dictionary = error.userInfo;
        if (dictionary[@"NSLocalizedDescription"]) {
           completeBlock(nil,dictionary[@"NSLocalizedDescription"],nil);
           [MBProgressHUD showTitleToView:nil postion:NHHUDPostionCenten title:[error localizedDescription]];
        }else{
          completeBlock(nil,nil,error);
        }
       

    }];
}

+ (nullable NSURLSessionDataTask *)DELETE:(nonnull NSString *)urlString
                              paraments:(nullable id)paraments
                            completeBlock:(nullable completeBlock)completeBlock{
    return [[AFNetWorkManager sharedNetWork] DELETE:urlString parameters:paraments success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self dealBackStateWithResponse:responseObject completeBlock:completeBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        // 请求失败
        NSDictionary *dictionary = error.userInfo;
        if (dictionary[@"NSLocalizedDescription"]) {
            completeBlock(nil,dictionary[@"NSLocalizedDescription"],nil);
            [MBProgressHUD showTitleToView:nil postion:NHHUDPostionCenten title:[error localizedDescription]];
        }else{
            completeBlock(nil,nil,error);
        }
    }];
}

+ (nullable NSURLSessionDataTask *)PUT:(nonnull NSString *)urlString
                                paraments:(nullable id)paraments
                            completeBlock:(nullable completeBlock)completeBlock{
    return [[AFNetWorkManager sharedNetWork] PUT:urlString parameters:paraments success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [self dealBackStateWithResponse:responseObject completeBlock:completeBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        // 请求失败
        NSDictionary *dictionary = error.userInfo;
        if (dictionary[@"NSLocalizedDescription"]) {
            completeBlock(nil,dictionary[@"NSLocalizedDescription"],nil);
            [MBProgressHUD showTitleToView:nil postion:NHHUDPostionCenten title:[error localizedDescription]];
        }else{
            completeBlock(nil,nil,error);
        }
    }];
}


#pragma mark - 简化
+ (nullable NSURLSessionDataTask *)requestWithRequestType:(HTTPSRequestType)type
                                                urlString:(nonnull NSString *)urlString
                                                paraments:(nullable id)paraments
                                            completeBlock:(nullable completeBlock)completeBlock
{
    
    
    
    
    switch (type) {
        case Get:
        {
            return  [AFHTTPSession GET:urlString
                             paraments:paraments
                         completeBlock:^(NSDictionary * _Nullable object,NSString * _Nullable errorMessge, NSError * _Nullable error) {
                             completeBlock(object,errorMessge,error);
                         }];
        }
        case Post:
            return [AFHTTPSession POST:urlString
                             paraments:paraments
                         completeBlock:^(NSDictionary * _Nullable object,NSString * _Nullable errorMessge, NSError * _Nullable error) {
                             completeBlock(object,errorMessge,error);
                         }];

    
case Delete:
    return [AFHTTPSession DELETE:urlString
                     paraments:paraments
                 completeBlock:^(NSDictionary * _Nullable object,NSString * _Nullable errorMessge, NSError * _Nullable error) {
                     completeBlock(object,errorMessge,error);
                 }];
    

case Put:
return [AFHTTPSession PUT:urlString
                 paraments:paraments
             completeBlock:^(NSDictionary * _Nullable object,NSString * _Nullable errorMessge, NSError * _Nullable error) {
                 completeBlock(object,errorMessge,error);
             }];

}
}

#pragma mark -  取消所有的网络请求

/**
 *  取消所有的网络请求
 *  a finished (or canceled) operation is still given a chance to execute its completion block before it iremoved from the queue.
 */

+(void)cancelAllRequest
{
    [[AFNetWorkManager sharedNetWork].operationQueue cancelAllOperations];
}




#pragma mark - 上传图片文件

+(void)uploadSingleImage:(NSData*)data completeBlock:(nullable completeBlock)completeBlock{
    
    [[AFNetWorkManager sharedNetWork] POST:@"mobile/image/upload4" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //获取时间戳
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
        long long totalMilliseconds = interval*1000 ;
        [formData appendPartWithFileData:data name:@"0" fileName:[NSString stringWithFormat:@"xdy_image_%lld.jpg",totalMilliseconds] mimeType:@"multipart/form-data"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        NSString *statusStr = [NSString stringWithFormat:@"%@",responseObject[@"status"]];
        if ([statusStr isEqualToString:@"200"]) {
            NSDictionary *addressDict = @{@"address":responseObject[@"data"][0]};
            completeBlock(addressDict,nil,nil);
        }else{
            completeBlock(nil,responseObject[@"message"],nil);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        NSDictionary *dictionary = error.userInfo;
        if (dictionary[@"NSLocalizedDescription"]) {
            completeBlock(nil,dictionary[@"NSLocalizedDescription"],nil);
        }else{
            completeBlock(nil,nil,error);
        }
    }];
 
}



/**
 上传多张图片
 */
+(void)UploadWithImages:(NSArray<UIImage*>*)imageArray
                success:(completeBlock)completeBlock{
    NSMutableArray *array =[[NSMutableArray alloc]init];
    // 创建队列组
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int index = 0; index < imageArray.count ; index++){
        dispatch_group_async(group,queue, ^{
        NSData *imageData =UIImageJPEGRepresentation(imageArray[index], .5);
            [[self class] uploadSingleImage:imageData completeBlock:^(NSDictionary * _Nullable object, NSString * _Nullable errorMessge, NSError * _Nullable error) {
                if (object) {
                    [array addObject:@{@"image":object[@"address"],@"index":[NSString stringWithFormat:@"%d",index]}];
                    NSLog(@"上传成功");
                }
                dispatch_semaphore_signal(semaphore);
            }];
         dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        });
    }
    dispatch_group_notify(group, queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *sortDescriptors=[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES]];
            [array sortUsingDescriptors:sortDescriptors];
            NSMutableArray * imageArray =[[NSMutableArray alloc]init];
            for (NSDictionary *dic in array) {
                [imageArray addObject:[dic valueForKey:@"image"]];
            }
            NSString *courseString = [imageArray componentsJoinedByString:@","];
//            NSData *data=[NSJSONSerialization dataWithJSONObject:imageArray options:NSJSONWritingPrettyPrinted error:nil];
//            NSString *courseString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            completeBlock(@{@"address":courseString},nil,nil);
        });
    });
}






+ (NSURLSessionTask *_Nonnull)uploadWithURL:(NSString *_Nullable)URL
                                 parameters:(NSDictionary *_Nullable)parameters
                                     images:(NSArray<UIImage *> *_Nullable)images
                                       name:(NSString *_Nullable)name
                                   fileName:(NSString *_Nullable)fileName
                                   mimeType:(NSString *_Nullable)mimeType
                                   progress:(HttpProgress _Nullable )progress
                                    success:(completeBlock _Nullable )success
                                    failure:(completeBlock _Nullable )failure
{
        NSLog(@"---url---%@",[AFNetWorkManager HTTPStrWithDict:parameters with:[NSString stringWithFormat:@"%@",[AFNetWorkManager sharedNetWork].baseURL] with:URL]);
    return [[AFNetWorkManager sharedNetWork] POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //压缩-添加-上传图片
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData name:name fileName:[NSString stringWithFormat:@"%@%lu.%@",fileName,(unsigned long)idx,mimeType?mimeType:@"jpeg"] mimeType:[NSString stringWithFormat:@"image/%@",mimeType?mimeType:@"jpeg"]];
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        progress ? progress(uploadProgress) : nil;
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success ? success(responseObject,nil,nil) : nil;
        NSLog(@"responseObject = %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure ? failure(nil,nil,error) : nil;
        NSLog(@"error = %@",error);
    }];
}
/**
 *  上传文件
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param datas      文件数组
 *  @param name       文件对应服务器上的字段
 *  @param fileName   文件名
 *  @param mimeType   图片文件的类型,例:png、jpeg(默认类型)....
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *_Nonnull)uploadWithURL:(NSString *_Nullable)URL
                                 parameters:(NSDictionary *_Nullable)parameters
                                       data:(NSArray<NSData *> *_Nullable)datas
                                       name:(NSString *_Nullable)name
                                   fileName:(NSString *_Nullable)fileName
                                   mimeType:(NSString *_Nullable)mimeType
                                   progress:(HttpProgress _Nullable )progress
                                    success:(completeBlock _Nullable )success
                                    failure:(completeBlock _Nullable )failure{
            NSLog(@"---url---%@",[AFNetWorkManager HTTPStrWithDict:parameters with:[NSString stringWithFormat:@"%@",[AFNetWorkManager sharedNetWork].baseURL] with:URL]);
    return [[AFNetWorkManager sharedNetWork] POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
//        类型和后台进行协商目前不确定
        [datas enumerateObjectsUsingBlock:^(NSData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [formData appendPartWithFileData:obj name:name fileName:fileName mimeType:mimeType];
        }];

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        progress ? progress(uploadProgress) : nil;
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [self dealBackStateWithResponse:responseObject completeBlock:success];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure ? failure(nil,nil,error) : nil;
        NSLog(@"error = %@",error);
    }];
}



/**
 *  下载文件
 *
 *  @param URL      请求地址
 *  @param fileDir  文件存储目录(默认存储目录为Download)
 *  @param progress 文件下载的进度信息
 *  @param success  下载成功的回调(回调参数filePath:文件的路径)
 *  @param failure  下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */
+ (NSURLSessionTask *_Nullable)downloadWithURL:(NSString *_Nullable)URL
                                       fileDir:(NSString *_Nullable)fileDir
                                      progress:(HttpProgress _Nullable )progress
                                       success:(void(^_Nullable)(NSString * _Nullable filePath))success
                                       failure:(completeBlock _Nullable)failure{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    NSURLSessionDownloadTask *downloadTask = [[AFNetWorkManager sharedNetWork] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        progress ? progress(downloadProgress) : nil;
        NSLog(@"下载进度:%.2f%%",100.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"downloadDir = %@",downloadDir);
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        failure && error ? failure(nil,nil,error) : nil;
    }];
    //开始下载
    [downloadTask resume];
    
    return downloadTask;
}

#pragma mark -   取消指定的url请求/
/**
 *  取消指定的url请求
 *
 *  @param requestType 该请求的请求类型
 *  @param string      该请求的完整url
 */

+(void)cancelHttpRequestWithRequestType:(NSString *)requestType
                       requestUrlString:(NSString *)string
{
    NSError * error;
    /**根据请求的类型 以及 请求的url创建一个NSMutableURLRequest---通过该url去匹配请求队列中是否有该url,如果有的话 那么就取消该请求*/
    NSString * urlToPeCanced = [[[[AFNetWorkManager sharedNetWork].requestSerializer
                                  requestWithMethod:requestType URLString:string parameters:nil error:&error] URL] path];
    
    for (NSOperation * operation in [AFNetWorkManager sharedNetWork].operationQueue.operations) {
        //如果是请求队列
        if ([operation isKindOfClass:[NSURLSessionTask class]]) {
            //请求的类型匹配
            BOOL hasMatchRequestType = [requestType isEqualToString:[[(NSURLSessionTask *)operation currentRequest] HTTPMethod]];
            //请求的url匹配
            BOOL hasMatchRequestUrlString = [urlToPeCanced isEqualToString:[[[(NSURLSessionTask *)operation currentRequest] URL] path]];
            //两项都匹配的话  取消该请求
            if (hasMatchRequestType&&hasMatchRequestUrlString) {
                [operation cancel];
            }
        }
    }
}
- (void)AFNetworkStatus
{
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                networkReachabilityStatusUnknown();
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                networkReachabilityStatusReachableViaWWAN();
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                
                break;
                
            default:
                break;
        }
        
    }] ;
}
void networkReachabilityStatusUnknown()
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"已为”VRMAX“关闭蜂窝移动数据"
                                                                   message:@"您可以在”设置“中为此应用程序打开蜂窝移动数据。"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"设置"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                //                                                canOpenURLString(@"prefs:root=MOBILE_DATA_SETTINGS_ID");
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"好"
                                              style:UIAlertActionStyleCancel handler:nil]];
}

void networkReachabilityStatusReachableViaWWAN()
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"“VRMAX”正在使用流量，确定要如此土豪吗？"
                                                                   message:@"建议开启WIFI"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"设置"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                //                                                canOpenURLString(@"prefs:root=MOBILE_DATA_SETTINGS_ID");
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"好"
                                              style:UIAlertActionStyleCancel handler:nil]];
}
@end
