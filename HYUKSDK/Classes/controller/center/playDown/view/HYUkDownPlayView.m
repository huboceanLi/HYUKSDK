//
//  HYUkDownPlayView.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/5/16.
//

#import "HYUkDownPlayView.h"
#import "HYUKSDK/HYUKSDK-Swift.h"

#import "SJVideoPlayer.h"
#import "SJAVMediaPlaybackController.h"
#import "SJBaseVideoPlayerConst.h"
#import "SJMediaCacheServer.h"

@interface HYUkDownPlayView()

@property (nonatomic, strong, nullable) SJVideoPlayer *player;
//@property (nonatomic, strong) HYUkVideoDetailModel *detailModel;
@property (nonatomic, strong) HYUkHistoryRecordModel *currentRecordModel;
@property (nonatomic, strong) HYUkDownListModel *downModel;

@end

@implementation HYUkDownPlayView

- (void)dealloc {
    NSLog(@"HYUkDownPlayView 灰飞烟灭！");
}

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.blackColor;
    
    _player = SJVideoPlayer.player;
    _player.pausedInBackground = YES;
    [self addSubview:_player.view];
    [_player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.mas_top).offset(IS_iPhoneX ? 44 : 24);
    }];

    
}

- (void)saveHistoryRecord {
    NSInteger currentTime = self.player.currentTime - 10;
    if (currentTime > 30 && self.player.assetStatus == SJAssetStatusReadyToPlay) {
        HYUkHistoryRecordModel *recordModel = [HYUkHistoryRecordModel new];
        recordModel.tvId = self.downModel.video_id;
        recordModel.name = self.downModel.vod_name;
        recordModel.playUrl = self.currentRecordModel.playUrl;
        recordModel.imageUrl = self.downModel.vod_pic;
        recordModel.duration = self.player.duration;
        recordModel.playDuration = currentTime;
        recordModel.playName = self.currentRecordModel.playName;
        recordModel.create_Time = [[[HYUkConfigManager sharedInstance] getNowTimeTimestamp] integerValue];
        [[HYUkHistoryRecordLogic share] insertHistoryRecordWithRecordModel:recordModel];
    }
}

- (void)loadContent
{
    self.downModel = self.data;
    HYUkHistoryRecordModel *tempModel = [[HYUkHistoryRecordLogic share] queryAppointRecordWithVideoId:self.downModel.video_id];
    if (tempModel) {
        if ([self.downModel.playUrl isEqualToString:tempModel.playUrl] || [self.downModel.playName isEqualToString:tempModel.playName]) {
            self.currentRecordModel = tempModel;
            NSURL *URL = [NSURL URLWithString:tempModel.playUrl];
            [self startPaly:URL];
            return;
        }
    }
    self.currentRecordModel = [HYUkHistoryRecordModel new];
    self.currentRecordModel.playUrl = self.downModel.playUrl;
    self.currentRecordModel.playName = self.downModel.playName;
    NSURL *URL = [NSURL URLWithString:self.downModel.playUrl];
    [self startPaly:URL];
}

- (void)startPaly:(NSURL *)URL {

    NSURL *playbackURL = [SJMediaCacheServer.shared playbackURLWithURL:URL];
//    // play
    _player.URLAsset = [SJVideoPlayerURLAsset.alloc initWithURL:playbackURL startPosition:self.currentRecordModel.playDuration];
}

@end
