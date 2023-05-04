//
//  HYUkVideoPlayView.m
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/14.
//

#import "HYUkVideoPlayView.h"

#import "SJVideoPlayer.h"
#import "SJAVMediaPlaybackController.h"
#import "SJBaseVideoPlayerConst.h"

#import "SJMediaCacheServer.h"
#import "NSURLRequest+MCS.h"
#import "MCSURL.h"
#import "MCSPrefetcherManager.h"
#import "MCSDownload.h"

static NSString *const DEMO_URL_HLS = @"https://ukzy.ukubf3.com/20220729/Dv07GYBT/index.m3u8";

//static NSString *const DEMO_URL_HLS = @"https://cache.we-vip.com:2096/search/index.m3u8?data=NwmwEe5eNbjbU3YjM1YzU3MzQ3ZTE3OTA4NjY3M2Q4OThlZjQO0O0O";

@interface HYUkVideoPlayView()

@property (nonatomic, strong, nullable) SJVideoPlayer *player;

@end

@implementation HYUkVideoPlayView

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
    
    SJMediaCacheServer.shared.enabledConsoleLog = YES;
    SJMediaCacheServer.shared.logOptions = MCSLogOptionDownloader;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *url = DEMO_URL_HLS;
        NSURL *URL = [NSURL URLWithString:url];
        [self _play:URL];
    });
}

- (void)loadContent
{
//    HYMovieListItemModel *model = self.data;
//    NSLog(@"播放时间:%f",self.player.currentTime);
//    NSLog(@"总时间:%f",self.player.duration);
}

#pragma mark -

- (void)_play:(NSURL *)URL {
//    URL = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"com.SJMediaCacheServer.cache/87d5ff79f295648c071555a12fb412cc/file_0_0.mp4"]];
    
    NSURL *playbackURL = [SJMediaCacheServer.shared playbackURLWithURL:URL];
//    // play
    _player.URLAsset = [SJVideoPlayerURLAsset.alloc initWithURL:playbackURL startPosition:0];
}

@end
