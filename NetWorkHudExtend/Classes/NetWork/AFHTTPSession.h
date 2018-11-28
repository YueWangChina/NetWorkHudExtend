//
//  AFHTTPSession.h
//  XDYCar
//
//  Created by xdy on 2018/5/3.
//  Copyright © 2018年 xindongyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger,HTTPSRequestType)
{
    Get = 0,
    Post,
    Delete,
    Put
};
/**
 业务人员使用过程中仅得到三者中一者，其余两者均为 nil ,业务人员根据业务需求书写相关判断逻辑处理相关业务
 
 @param object 返回此参数        说明数据正常可用
 @param errorMessge 返回此参数   说明服务器返回非正常数据提示
 @param error 返回此参数         说明服务器错误,无任何数据相关指示,建议咨询后台人员
 */
typedef void(^completeBlock)( NSDictionary *_Nullable object,NSString * _Nullable errorMessge,NSError * _Nullable error);

/** 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小*/
typedef void (^HttpProgress)(NSProgress * _Nullable progress);

@interface AFHTTPSession : NSObject
+ (nullable NSURLSessionDataTask *)GET:(nonnull NSString *)urlString
                             paraments:(nullable id)paraments
                         completeBlock:(nullable completeBlock)completeBlock;

+ (nullable NSURLSessionDataTask *)POST:(nonnull NSString *)urlString
                              paraments:(nullable id)paraments
                          completeBlock:(nullable completeBlock)completeBlock;

+ (nullable NSURLSessionDataTask *)requestWithRequestType:(HTTPSRequestType)type
                                                urlString:(nonnull NSString *)urlString
                                                paraments:(nullable id)paraments
                                            completeBlock:(nullable completeBlock)completeBlock;
+ (nullable NSURLSessionDataTask *)DELETE:(nonnull NSString *)urlString
                                paraments:(nullable id)paraments
                            completeBlock:(nullable completeBlock)completeBlock;
+ (nullable NSURLSessionDataTask *)PUT:(nonnull NSString *)urlString
                             paraments:(nullable id)paraments
                         completeBlock:(nullable completeBlock)completeBlock;

/**
 *  上传图片文件
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param images     图片数组
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
                                     images:(NSArray<UIImage *> *_Nullable)images
                                       name:(NSString *_Nullable)name
                                   fileName:(NSString *_Nullable)fileName
                                   mimeType:(NSString *_Nullable)mimeType
                                   progress:(HttpProgress _Nullable )progress
                                    success:(completeBlock _Nullable )success
                                    failure:(completeBlock _Nullable )failure;
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
                                    failure:(completeBlock _Nullable )failure;

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
                                       failure:(completeBlock _Nullable)failure;


/**
 上传多张图片；
 */
+(void)UploadWithImages:(NSArray<UIImage*>*_Nullable)imageArray
                success:(completeBlock _Nullable )completeBlock;

/**
 *  取消指定的url请求
 *
 *  @param requestType 该请求的请求类型
 *  @param string      该请求的完整url
 */

+(void)cancelHttpRequestWithRequestType:(NSString *_Nullable)requestType
                       requestUrlString:(NSString *_Nullable)string;

- (void)AFNetworkStatus;

@end
