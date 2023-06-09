//
//  HYUkVideoDetailToolView.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/13.
//

#import "HYUkVideoDetailToolView.h"
#import "HYUKSDK/HYUKSDK-Swift.h"

@interface HYUkVideoDetailToolView()

@property (nonatomic, strong) HYUkVideoDetailModel *detailModel;
@property (nonatomic, strong) QMUIButton *downBtn;
@property (nonatomic, strong) QMUIButton *likeBtn;
@property (nonatomic, strong) QMUIButton *shareBtn;
@property (nonatomic, assign) BOOL isLike;
@property (nonatomic, strong) HYUkCollectionModel *collectionModel;


@end

@implementation HYUkVideoDetailToolView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.whiteColor;

    self.downBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [self.downBtn setTitle:@"下载" forState:0];
    [self.downBtn setTitleColor:UIColor.textColor22 forState:0];
    self.downBtn.titleLabel.font = [UIFont systemFontOfSize:XJFlexibleFont(13)];
    [self.downBtn setImage:[UIImage uk_bundleImage:@"uk_down_Img"] forState:0];
    [self.downBtn setImagePosition:QMUIButtonImagePositionTop];
    self.downBtn.spacingBetweenImageAndTitle = XJFlexibleFont(10);
    self.downBtn.tag = 2;
    [self addSubview:self.downBtn];
    [self.downBtn addTarget:self action:@selector(downButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.likeBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [self.likeBtn setTitle:@"收藏" forState:0];
    [self.likeBtn setTitleColor:UIColor.textColor22 forState:0];
    self.likeBtn.titleLabel.font = [UIFont systemFontOfSize:XJFlexibleFont(13)];
    [self.likeBtn setImage:[UIImage uk_bundleImage:@"uk_like_no"] forState:0];
    [self.likeBtn setImagePosition:QMUIButtonImagePositionTop];
    self.likeBtn.spacingBetweenImageAndTitle = XJFlexibleFont(10);
    self.likeBtn.tag = 3;
    [self addSubview:self.likeBtn];
    [self.likeBtn addTarget:self action:@selector(likeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.shareBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [self.shareBtn setTitle:@"分享" forState:0];
    [self.shareBtn setTitleColor:UIColor.textColor22 forState:0];
    self.shareBtn.titleLabel.font = [UIFont systemFontOfSize:XJFlexibleFont(13)];
    [self.shareBtn setImage:[UIImage uk_bundleImage:@"uk_fenxiang"] forState:0];
    [self.shareBtn setImagePosition:QMUIButtonImagePositionTop];
    self.shareBtn.spacingBetweenImageAndTitle = XJFlexibleFont(10);
    self.shareBtn.tag = 4;
    [self addSubview:self.shareBtn];
    [self.shareBtn addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat w = XJFlexibleFont(60);
    CGFloat space = (SCREEN_WIDTH - w * 3) / 4;
    
//    [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(space);
//        make.width.mas_offset(w);
//        make.centerY.equalTo(self);
//    }];
    
    [self.downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(space);
        make.width.mas_offset(w);
        make.centerY.equalTo(self);
    }];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.downBtn.mas_right).offset(space);
        make.width.mas_offset(w);
        make.centerY.equalTo(self);
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.likeBtn.mas_right).offset(space);
        make.width.mas_offset(w);
        make.centerY.equalTo(self);
    }];
}

//- (void)changeButtonClick {
//    
//}

- (void)loadContent {
    self.detailModel = self.data;
    
    HYUkCollectionModel *model = [[HYVideoCollectionLogic share] queryAppointCollectionWithVideoId:self.detailModel.ID];
    if (model == nil) {
        self.isLike = NO;
        [self.likeBtn setImage:[UIImage uk_bundleImage:@"uk_like_no"] forState:0];
        [self.likeBtn setTitleColor:UIColor.textColor22 forState:0];
    }else {
        self.isLike = YES;
        [self.likeBtn setTitleColor:UIColor.mainColor forState:0];
        [self.likeBtn setImage:[UIImage uk_bundleImage:@"uk_like_add"] forState:0];
    }
    
    self.collectionModel = [HYUkCollectionModel new];
    self.collectionModel.video_id = self.detailModel.ID;
    self.collectionModel.type_id_1 = self.detailModel.type_id_1;
    self.collectionModel.vod_name = self.detailModel.vod_name;
    self.collectionModel.vod_pic = self.detailModel.vod_pic;
    self.collectionModel.vod_year = self.detailModel.vod_year;
    self.collectionModel.vod_area = self.detailModel.vod_area;
    self.collectionModel.vod_class = self.detailModel.vod_class;
    self.collectionModel.vod_remarks = self.detailModel.vod_remarks;
    self.collectionModel.create_Time = [[[HYUkVideoConfigManager sharedInstance] getNowTimeTimestamp] integerValue];
}

- (void)downButtonClick {
    NSString *str = @"";
    if (self.detailModel.vod_play_url.count == 1) {
        HYUkVideoDetailItemModel *itemModel = self.detailModel.vod_play_url.firstObject;
        str = [NSString stringWithFormat:@"%ld-%@",self.detailModel.ID,itemModel.name];
        if ([[HYUkDownListLogic share] queryAppointDownWithPrimaryId:str]) {
            [MYToast showWithText:@"已在下载队列中!"];
            return;
        }
        HYUkDownListModel *downModel = [HYUkDownListModel new];
        downModel.primary_Id = str;
        downModel.video_id = self.detailModel.ID;
        downModel.type_id_1 = self.detailModel.type_id_1;
        downModel.vod_name = self.detailModel.vod_name;
        downModel.vod_pic = self.detailModel.vod_pic;
        downModel.vod_year = self.detailModel.vod_year;
        downModel.vod_area = self.detailModel.vod_area;
        downModel.playName = itemModel.name;
        downModel.playUrl = itemModel.url;
        downModel.content = self.detailModel.vod_content;
        downModel.create_Time = [[[HYUkVideoConfigManager sharedInstance] getNowTimeTimestamp] integerValue];
        [[HYUkDownListLogic share] insertDownListWithModel:downModel];
        
        [[HYUkDownManager sharedInstance] startDown:downModel];

        [MYToast showWithText:@"已添加到下载队列中!"];
        return;
    }

    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:@{@"type":@"down"}];
    }
}

- (void)likeButtonClick {
    if (self.isLike) {
        self.isLike = NO;
        [self.likeBtn setTitleColor:UIColor.textColor22 forState:0];
        [[HYVideoCollectionLogic share] removeAppointCollectionWithVideoId:self.detailModel.ID];
        [self.likeBtn setImage:[UIImage uk_bundleImage:@"uk_like_no"] forState:0];
    }else {
        self.isLike = YES;
        [self.likeBtn setTitleColor:UIColor.mainColor forState:0];
        [[HYVideoCollectionLogic share] insertCollectionListWithList:@[self.collectionModel]];
        [self.likeBtn setImage:[UIImage uk_bundleImage:@"uk_like_add"] forState:0];
    }
    
    if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
        [self.delegate customView:self event:@{@"videoID":@(self.detailModel.ID),@"isLike":@(self.isLike),@"type":@"like"}];
    }
//    [self routerWithEventName:@"RENEWCOLLECTION" userInfo:@{@"videoID":@(self.detailModel.ID),@"isLike":@(self.isLike)}];
}

- (void)shareButtonClick {
    NSMutableArray *activityItems = [NSMutableArray array];
    [activityItems addObject:[NSURL URLWithString:[HYUKConfigManager shareInstance].versionModel.url]];
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    
    activityViewController.popoverPresentationController.sourceView = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    activityViewController.popoverPresentationController.sourceRect = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-80, 1.0, 1.0);
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:activityViewController animated:YES completion:nil];
    
    [activityViewController setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        // 显示选中的分享类型
        NSLog(@"act type %@",activityType);
        
        if (completed) {
            NSLog(@"ok");
        }else {
            NSLog(@"no ok");
        }
    }];
}

@end
