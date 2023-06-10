//
//  HYUkVideoPlayView.m
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/14.
//

#import "HYUkVideoPlayView.h"
#import "HYUKSDK/HYUKSDK-Swift.h"

#import "SJVideoPlayer.h"
#import "SJAVMediaPlaybackController.h"
#import "SJBaseVideoPlayerConst.h"

#import "SJMediaCacheServer.h"
#import "NSURLRequest+MCS.h"
#import "MCSURL.h"
#import "MCSPrefetcherManager.h"
#import "MCSDownload.h"

static NSString *const DEMO_URL_HLS = @"https://ukzyvod3.ukubf5.com/20230415/9HciOKan/index.m3u8";

//static NSString *const DEMO_URL_HLS = @"https://cache.we-vip.com:2096/search/index.m3u8?data=NwmwEe5eNbjbU3YjM1YzU3MzQ3ZTE3OTA4NjY3M2Q4OThlZjQO0O0O";

@interface HYUkVideoPlayView()

@property (nonatomic, strong, nullable) SJVideoPlayer *player;
@property (nonatomic, strong) HYUkVideoDetailModel *detailModel;
@property (nonatomic, strong) HYUkHistoryRecordModel *currentRecordModel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger recordIndex;

@end

@implementation HYUkVideoPlayView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.blackColor;
    
    _player = SJVideoPlayer.player;
    _player.pausedInBackground = YES;
//    self.player.controlLayerDataSource = self;
    [self addSubview:_player.view];
    [_player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.mas_top).offset(IS_iPhoneX ? 44 : 24);
    }];
    
    
    self.timer = [NSTimer timerWithTimeInterval:(1.0f) target:self selector:@selector(timeRecordCurrent) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];

    [self.timer pauseTimer];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netChangeWanNotic) name:net_change_wan object:nil];

//    SJMediaCacheServer.shared.enabledConsoleLog = YES;
//    SJMediaCacheServer.shared.logOptions = MCSLogOptionDownloader;
}

- (void)netChangeWanNotic {
    if (![UserDefault boolValueForKey:video_allow_flow_play] && [HYUkDownManager sharedInstance].isWan) {
        [self.player pause];
        MYDialogViewController * dialogVC = [[MYDialogViewController alloc] initWithTitle:@"温馨提示" tipsString:@"非wifi下播放视频会消耗流量,确定要播放吗?"];
        dialogVC.customView.height = 110;
        __weak typeof(self) weakSelf = self;
        [dialogVC addSubmitButtonWithText:@"播放" block:^(__kindof QMUIDialogViewController * _Nonnull aDialogViewController) {
            [aDialogViewController hide];
            [UserDefault setBool:true forKey:video_allow_flow_play];
            [[NSNotificationCenter defaultCenter] postNotificationName:video_allow_flow_play object:nil];
            [weakSelf.player play];
        }];
        [dialogVC addCancelButtonWithText:@"取消" block:nil];
        [dialogVC show];
    }
}

- (void)removeView
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc {
    NSLog(@"HYUkVideoPlayView 灰飞烟灭！");
}


- (void)timeRecordCurrent {
    NSInteger currentTime = self.player.currentTime;
    if (self.player.duration > 0 && currentTime + 1 >= self.player.duration) {
        NSLog(@"准备切换下一集");
        [self.timer pauseTimer];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.detailModel.vod_play_url.count > self.recordIndex + 1) {
                
                self.recordIndex++;
                self.currentRecordModel.playUrl = self.detailModel.vod_play_url[self.recordIndex].url;
                self.currentRecordModel.playName = self.detailModel.vod_play_url[self.recordIndex].name;
                
                if (self.currentRecordModel.playUrl.length > 0) {
                    NSURL *URL = [NSURL URLWithString:self.currentRecordModel.playUrl];
                    [self _play:URL];
                }
            }
        });

    }
}

- (void)loadContent
{
    HYUkVideoDetailModel *model = self.data;
    self.detailModel = model;
    
    
    if (model.vod_play_url.count >= 1) {
        HYUkHistoryRecordModel *tempModel = [[HYUkHistoryRecordLogic share] queryAppointRecordWithVideoId:self.detailModel.ID];
        if (tempModel) {
            
            BOOL isHave = false;
            
            for (int i = 0; i < model.vod_play_url.count; i++) {
                HYUkVideoDetailItemModel *item = model.vod_play_url[i];
                if ([item.url isEqualToString:tempModel.playUrl] || [item.name isEqualToString:tempModel.playName]) {
                    self.currentRecordModel = tempModel;
                    isHave = true;
                    self.recordIndex = i;
                    NSURL *URL = [NSURL URLWithString:tempModel.playUrl];
                    [self _play:URL];
                    
                    break;
                }
            }
            
            if (!isHave) {
                self.currentRecordModel = [HYUkHistoryRecordModel new];
                
                HYUkVideoDetailItemModel *playModel = model.vod_play_url.firstObject;
                self.recordIndex = 0;
                self.currentRecordModel.playUrl = playModel.url;
                self.currentRecordModel.playName = playModel.name;
                
                NSURL *URL = [NSURL URLWithString:playModel.url];
                [self _play:URL];
                
                
                return;
            }
            
        }else {
            self.currentRecordModel = [HYUkHistoryRecordModel new];

            HYUkVideoDetailItemModel *playModel = model.vod_play_url.firstObject;
            self.recordIndex = 0;
            self.currentRecordModel.playUrl = playModel.url;
            self.currentRecordModel.playName = playModel.name;
            
            NSURL *URL = [NSURL URLWithString:playModel.url];
            [self _play:URL];
            
            return;
        }
    }

//    NSLog(@"播放时间:%f",self.player.currentTime);
//    NSLog(@"总时间:%f",self.player.duration);
}

- (void)saveHistoryRecord {
    NSInteger currentTime = self.player.currentTime - 10;
    if (currentTime > 30 && self.player.assetStatus == SJAssetStatusReadyToPlay) {
        HYUkHistoryRecordModel *recordModel = [HYUkHistoryRecordModel new];
        recordModel.tvId = self.detailModel.ID;
        recordModel.name = self.detailModel.vod_name;
        recordModel.playUrl = self.currentRecordModel.playUrl;
        recordModel.imageUrl = self.detailModel.vod_pic;
        recordModel.duration = self.player.duration;
        recordModel.playDuration = currentTime;
        recordModel.playName = self.currentRecordModel.playName;
        recordModel.create_Time = [[[HYUkVideoConfigManager sharedInstance] getNowTimeTimestamp] integerValue];
        [[HYUkHistoryRecordLogic share] insertHistoryRecordWithRecordModel:recordModel];
    }
}

#pragma mark -

- (void)_play:(NSURL *)URL {

    if (![UserDefault boolValueForKey:video_allow_flow_play] && [HYUkDownManager sharedInstance].isWan) {
        MYDialogViewController * dialogVC = [[MYDialogViewController alloc] initWithTitle:@"温馨提示" tipsString:@"非wifi下播放视频会消耗流量,确定要播放吗?"];
        dialogVC.customView.height = 110;
        __weak typeof(self) weakSelf = self;
        [dialogVC addSubmitButtonWithText:@"播放" block:^(__kindof QMUIDialogViewController * _Nonnull aDialogViewController) {
            [aDialogViewController hide];
            [UserDefault setBool:true forKey:video_allow_flow_play];
            [[NSNotificationCenter defaultCenter] postNotificationName:video_allow_flow_play object:nil];
            [weakSelf startPaly:URL];
        }];
        [dialogVC addCancelButtonWithText:@"取消" block:nil];
        [dialogVC show];
        return;
    }

    [self startPaly:URL];
}

- (void)startPaly:(NSURL *)URL {
    
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:self.currentRecordModel];
    }
    [self.timer setFireDate:[NSDate date]];
    
    NSURL *playbackURL = [SJMediaCacheServer.shared playbackURLWithURL:URL];
//    // play
    _player.URLAsset = [SJVideoPlayerURLAsset.alloc initWithURL:playbackURL startPosition:self.currentRecordModel.playDuration];
}

- (void)changeSelect:(NSString *)name Url:(NSString *)url {
    self.currentRecordModel.playUrl = url;
    self.currentRecordModel.playName = name;
    self.currentRecordModel.playDuration = 0;
    
    NSURL *URL = [NSURL URLWithString:url];
    [self _play:URL];
}

@end
