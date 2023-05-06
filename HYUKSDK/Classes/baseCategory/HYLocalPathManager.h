//
//  HYLocalPathManager.h
//  HYReadBook
//
//  Created by oceanMAC on 2023/2/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYLocalPathManager : NSObject

/**
 文件根目录
 @return 文件根目录
 */
+ (NSString *)funVideoRootPath:(NSString *)fileName;


//图片保存
//+ (NSString *)photoSave:(UIImage *)image;

//读取图片
+ (UIImage *)GetPhoto:(NSString *)name;

/**
 清除目录
 @dirPath 文件路径
 */
+ (void)clearDir:(NSString *)dirPath;

/**
 创建视频录制保存的路径
 */
+ (NSString *)createRecrodDir;

/**
 创建视频录制保存的路径
 */
+ (NSString *)createExportDir;

/**
 生成随机字符串
 @return 随机字符串
 */
+ (NSString*)uuidString;

//读取文件夹
+ (NSArray *)readVideoRootPath;

+ (NSString*)getCurrentTimes;

//保存data
+ (NSString *)SaveData:(NSData *)data bookId:(NSString *)bookId chapterId:(NSString *)chapterId;

+ (BOOL)createPath:(NSString *)path;


+ (NSString *)getBookFilePath:(NSString *)name;

+ (NSString *)getBookFilePathBookId:(NSString *)bookId chapterId:(NSString *)chapterId;

@end

NS_ASSUME_NONNULL_END
