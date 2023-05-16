//
//  HYUkDownManager.m
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/15.
//

#import "HYUkDownManager.h"
#import "LHYReachability.h"
#import "HYUkHeader.h"
#import "SJMediaCacheServer.h"
#import "HYUKSDK/HYUKSDK-Swift.h"

static NSInteger exportCount = 1;

static HYUkDownManager *manager = nil;

@interface HYUkDownManager()

@property (nonatomic) LHYReachability *hostReachability;
@property (nonatomic, strong) NSMutableArray *waitPrimaryIds;

@end

@implementation HYUkDownManager

+ (HYUkDownManager *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        manager.downIngDic = [NSMutableDictionary dictionary];
        manager.downWaitDic = [NSMutableDictionary dictionary];
        manager.waitPrimaryIds = [NSMutableArray array];
        
        [SJMediaCacheServer shared].maxConcurrentExportCount = exportCount;
        
        manager.hostReachability = [LHYReachability reachabilityWithHostName:@"https://www.baidu.com"];
        [manager.hostReachability startNotifier];
    });
    return manager;
}

- (void)startNetworkMonitoring
{
    NetworkStatus netStatus = [self.hostReachability currentReachabilityStatus];
    switch (netStatus){
        case NotReachable: {
            NSLog(@"ViewController : 没有网络！");
            self.isWan = NO;
            break;
        }
        case ReachableViaWWAN: {
            
            NSLog(@"ViewController : 4G/3G");
            self.isWan = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:net_change_wan object:nil];
            
            break;
        }
        case ReachableViaWiFi: {
            self.isWan = NO;
            NSLog(@"ViewController : WiFi");
            break;
        }
    }
}

- (void)startDown:(HYUkDownListModel *)model {
    if ([self.downIngDic.allKeys containsObject:model.primary_Id]) {
        
        [[SJMediaCacheServer shared] cancelAllPrefetchTasks];
        [self.downIngDic removeObjectForKey:model.primary_Id];
        NSArray *arr = self.downIngDic.allKeys;
        for (int i = 0; arr.count; i++) {
            if (arr.count > i) {
                [self downIng:self.downIngDic[arr[i]]];
            }
        }
        if ([self.delegate respondsToSelector:@selector(downProgress:progress:status:)]) {
            [self.delegate downProgress:model.primary_Id progress:0 status:down_pause];
        }
        return;
    }
    
    if (self.downIngDic.allKeys.count >= exportCount) { //任务满了
        [self.downWaitDic setObject:model forKey:model.primary_Id];
        [self.waitPrimaryIds addObject:model.primary_Id];
        if ([self.delegate respondsToSelector:@selector(downProgress:progress:status:)]) {
            [self.delegate downProgress:model.primary_Id progress:0 status:down_wait];
        }
        return;
    }

    [self.downIngDic setObject:model forKey:model.primary_Id];
    if ([self.downWaitDic.allKeys containsObject:model.primary_Id]) {
        [self.downWaitDic removeObjectForKey:model.primary_Id];
        [self.waitPrimaryIds removeObject:model.primary_Id];
    }
    if ([self.delegate respondsToSelector:@selector(downProgress:progress:status:)]) {
        [self.delegate downProgress:model.primary_Id progress:model.progress status:downing];
    }
    [self downIng:model];

}

- (void)downIng:(HYUkDownListModel *)model {

    __weak typeof(self) weakSelf = self;
    [[SJMediaCacheServer shared] prefetchWithURL:[NSURL URLWithString:model.playUrl] progress:^(float progress) {
        NSInteger p = progress * 100;
        NSLog(@"下载进度:%ld",p);

        if (p % 3 == 0) {
            [[HYUkDownListLogic share] updateDownProgressWithPrimaryId:model.primary_Id progress:p];
        }

        if ([weakSelf.delegate respondsToSelector:@selector(downProgress:progress:status:)]) {
            [weakSelf.delegate downProgress:model.primary_Id progress:p status:downing];
        }
    } completed:^(NSError * _Nullable error) {
        if (!error) {

            [[HYUkDownListLogic share] updateDownStatusWithPrimaryId:model.primary_Id];
            [weakSelf.downIngDic removeObjectForKey:model.primary_Id];
            [weakSelf startNext];
            if ([weakSelf.delegate respondsToSelector:@selector(downProgress:progress:status:)]) {
                [weakSelf.delegate downProgress:model.primary_Id progress:0 status:down_success];
            }
            NSLog(@"下载完成");
        }else {
            NSLog(@"下载出错了:%@",error);
        }
    }];
}

- (void)startNext {
    if (self.waitPrimaryIds.count > 0) {
        NSString *ID = self.waitPrimaryIds.firstObject;
        HYUkDownListModel *model = self.downWaitDic[ID];
        [self.downIngDic setObject:model forKey:model.primary_Id];
        [self.downWaitDic removeObjectForKey:model.primary_Id];
        [self.waitPrimaryIds removeObject:model.primary_Id];
        
        [self downIng:model];
    }else {
        NSLog(@"没有下载任务了");
    }
}

- (void)removeCacheForURLs:(NSArray *)urls
{
    if (urls.count > 0) {
        for (NSString *item in urls) {
            [[SJMediaCacheServer shared] removeCacheForURL:[NSURL URLWithString:item]];
        }
    }
}

@end
