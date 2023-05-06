#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "APIBaseManager.h"
#import "FaceStoreService.h"
#import "Target_CTAppContext.h"
#import "Target_FaceStoreService.h"
#import "APIString.h"
#import "HYVideoSingle.h"
#import "BaseModel.h"
#import "HYResponseCategeryModel.h"
#import "HYResponseSearchModel.h"
#import "HYResponseVideoListModel.h"
#import "UICollectionView+UKEmptyView.h"
#import "UIColor+UkPublicUse.h"
#import "UIImage+uk_bundleImage.h"
#import "UITableView+UKEmptyView.h"
#import "HYUkBaseListViewController.h"
#import "HYUkShowLoadingManager.h"
#import "HYUkVideoBaseViewController.h"
#import "HYUkVideoTabBarViewController.h"
#import "HYUkCollectionViewController.h"
#import "HYUkCollectionCell.h"
#import "HYUkDownViewController.h"
#import "HYUkDownCompleteCell.h"
#import "HYUkDownProgressCell.h"
#import "HYUkCenterHistoryListViewController.h"
#import "HYUkCenterHistoryListCell.h"
#import "HYUkCenterViewController.h"
#import "HYUkSettingViewController.h"
#import "HYUkSettingCell.h"
#import "HYCenterToolView.h"
#import "HYUkCenterHistoryListView.h"
#import "HYUkCenterHistoryListViewCell.h"
#import "HYUkCenterHistoryView.h"
#import "HYUkLoginView.h"
#import "HYUkDetailViewController.h"
#import "HYUkVideoBriefDetailView.h"
#import "HYUkVideoDetailBriefView.h"
#import "HYUkVideoDetailSelectWorkView.h"
#import "HYUkVideoDetailToolView.h"
#import "HYUkVideoPlayView.h"
#import "HYUkVideoRecommendView.h"
#import "HYUkHomeViewController.h"
#import "HYUkOtherViewController.h"
#import "HYUkCategeryListView.h"
#import "HYUkHomeCategeryCell.h"
#import "HYUkHomeCategeryView.h"
#import "HYUkRecommendVC.h"
#import "HYUkRecommendHeadView.h"
#import "HYUkHomeSearchView.h"
#import "HYUkVideoHomeListCell.h"
#import "HYUkRankViewController.h"
#import "HYUkRankViewCell.h"
#import "HYUkSearchViewController.h"
#import "HYUkHistoryHeadView.h"
#import "HYUkHistoryView.h"
#import "HYUkSearchHeadView.h"
#import "HYUkSearchListView.h"
#import "HYUkHeader.h"
#import "DGActivityIndicatorBallBeatAnimation.h"
#import "DGActivityIndicatorBallClipRotateAnimation.h"
#import "DGActivityIndicatorBallClipRotateMultipleAnimation.h"
#import "DGActivityIndicatorBallClipRotatePulseAnimation.h"
#import "DGActivityIndicatorBallGridBeatAnimation.h"
#import "DGActivityIndicatorBallGridPulseAnimation.h"
#import "DGActivityIndicatorBallPulseAnimation.h"
#import "DGActivityIndicatorBallPulseSyncAnimation.h"
#import "DGActivityIndicatorBallRotateAnimation.h"
#import "DGActivityIndicatorBallScaleAnimation.h"
#import "DGActivityIndicatorBallScaleMultipleAnimation.h"
#import "DGActivityIndicatorBallScaleRippleAnimation.h"
#import "DGActivityIndicatorBallScaleRippleMultipleAnimation.h"
#import "DGActivityIndicatorBallSpinFadeLoader.h"
#import "DGActivityIndicatorBallTrianglePathAnimation.h"
#import "DGActivityIndicatorBallZigZagAnimation.h"
#import "DGActivityIndicatorBallZigZagDeflectAnimation.h"
#import "DGActivityIndicatorCookieTerminatorAnimation.h"
#import "DGActivityIndicatorDoubleBounceAnimation.h"
#import "DGActivityIndicatorFiveDotsAnimation.h"
#import "DGActivityIndicatorLineScaleAnimation.h"
#import "DGActivityIndicatorLineScalePartyAnimation.h"
#import "DGActivityIndicatorLineScalePulseOutAnimation.h"
#import "DGActivityIndicatorLineScalePulseOutRapidAnimation.h"
#import "DGActivityIndicatorNineDotsAnimation.h"
#import "DGActivityIndicatorRotatingSandglassAnimation.h"
#import "DGActivityIndicatorRotatingSquaresAnimation.h"
#import "DGActivityIndicatorRotatingTrigonAnimation.h"
#import "DGActivityIndicatorThreeDotsAnimation.h"
#import "DGActivityIndicatorTriangleSkewSpinAnimation.h"
#import "DGActivityIndicatorTriplePulseAnimation.h"
#import "DGActivityIndicatorTripleRingsAnimation.h"
#import "DGActivityIndicatorTwoDotsAnimation.h"
#import "DGActivityIndicatorAnimationProtocol.h"
#import "DGActivityIndicatorView.h"
#import "BadgeButton.h"
#import "HYVideoUpgradeViewController.h"
#import "HYVideoUpgradeView.h"
#import "GCDAsyncSocket.h"
#import "GCDAsyncUdpSocket.h"
#import "FILEAsset.h"
#import "FILEAssetReader.h"
#import "FILEAssetContentProvider.h"
#import "HLSAsset.h"
#import "HLSAssetContentProvider.h"
#import "HLSAssetContentReader.h"
#import "HLSAssetDefines.h"
#import "HLSAssetParser.h"
#import "HLSAssetReader.h"
#import "HLSAssetTsContent.h"
#import "MCSAssetContent.h"
#import "MCSAssetContentReader.h"
#import "MCSAssetDefines.h"
#import "MCSAssetManager.h"
#import "MCSAssetUsageLog.h"
#import "MCSConfiguration.h"
#import "MCSAssetCacheManager.h"
#import "MCSConsts.h"
#import "MCSDatabase.h"
#import "MCSDefines.h"
#import "MCSError.h"
#import "MCSInterfaces.h"
#import "MCSLogger.h"
#import "MCSQueue.h"
#import "MCSReadwrite.h"
#import "MCSRootDirectory.h"
#import "MCSURL.h"
#import "MCSUtils.h"
#import "NSFileHandle+MCS.h"
#import "NSFileManager+MCS.h"
#import "NSURLRequest+MCS.h"
#import "MCSContents.h"
#import "MCSDownload.h"
#import "MCSAssetExporterDefines.h"
#import "MCSAssetExporterManager.h"
#import "FILEPrefetcher.h"
#import "HLSPrefetcher.h"
#import "MCSPrefetcherDefines.h"
#import "MCSPrefetcherManager.h"
#import "MCSProxyServer.h"
#import "MCSProxyTask.h"
#import "MCSResponse.h"
#import "DDData.h"
#import "DDNumber.h"
#import "DDRange.h"
#import "HTTPAuthenticationRequest.h"
#import "HTTPConnection.h"
#import "HTTPLogging.h"
#import "HTTPMessage.h"
#import "HTTPResponse.h"
#import "HTTPServer.h"
#import "MultipartFormDataParser.h"
#import "MultipartMessageHeader.h"
#import "MultipartMessageHeaderField.h"
#import "HTTPAsyncFileResponse.h"
#import "HTTPDataResponse.h"
#import "HTTPDynamicFileResponse.h"
#import "HTTPErrorResponse.h"
#import "HTTPFileResponse.h"
#import "HTTPRedirectResponse.h"
#import "WebSocket.h"
#import "KTVCocoaHTTPServer.h"
#import "SJMediaCacheServer.h"
#import "AVAsset+SJAVMediaExport.h"
#import "SJAVMediaPlayer.h"
#import "SJAVMediaPlayerLayerView.h"
#import "SJAVMediaPlayerLoader.h"
#import "SJAVPictureInPictureController.h"
#import "SJVideoPlayerURLAsset+SJAVMediaPlaybackAdd.h"
#import "SJVideoPlayerURLAssetPrefetcher.h"
#import "SJAVMediaPlaybackController.h"
#import "SJBaseVideoPlayerConst.h"
#import "SJVideoPlayerPlayStatusDefines.h"
#import "NSString+SJBaseVideoPlayerExtended.h"
#import "NSTimer+SJAssetAdd.h"
#import "SJControlLayerAppearStateManager.h"
#import "SJDanmakuItem.h"
#import "SJDanmakuPopupController.h"
#import "SJDeviceVolumeAndBrightness.h"
#import "SJDeviceVolumeAndBrightnessController.h"
#import "SJDeviceVolumeAndBrightnessTargetViewContext.h"
#import "SJFitOnScreenManager.h"
#import "SJFlipTransitionManager.h"
#import "SJMediaPlaybackController.h"
#import "SJPlaybackHistoryController.h"
#import "SJPlaybackObservation.h"
#import "SJPlaybackRecord.h"
#import "SJPlayerAutoplayConfig.h"
#import "SJPlayerView.h"
#import "SJPlayerViewInternal.h"
#import "SJPlayModel+SJPrivate.h"
#import "SJPlayModel.h"
#import "SJPlayModelPropertiesObserver.h"
#import "SJPromptingPopupController.h"
#import "SJReachability.h"
#import "SJRotationDefines.h"
#import "SJRotationFullscreenNavigationController.h"
#import "SJRotationFullscreenViewController.h"
#import "SJRotationFullscreenWindow.h"
#import "SJRotationManager.h"
#import "SJRotationManagerInternal.h"
#import "SJRotationManager_iOS_16_Later.h"
#import "SJRotationManager_iOS_9_15.h"
#import "SJRotationObserver.h"
#import "SJSmallViewFloatingController.h"
#import "SJSubtitleItem.h"
#import "SJSubtitlePopupController.h"
#import "SJTextPopupController.h"
#import "SJVideoDefinitionSwitchingInfo+Private.h"
#import "SJVideoDefinitionSwitchingInfo.h"
#import "SJVideoPlayerPresentView.h"
#import "SJVideoPlayerURLAsset+SJSubtitlesAdd.h"
#import "SJVideoPlayerURLAsset.h"
#import "SJViewControllerManager.h"
#import "SJWatermarkView.h"
#import "SJControlLayerAppearManagerDefines.h"
#import "SJDanmakuPopupControllerDefines.h"
#import "SJDeviceVolumeAndBrightnessControllerDefines.h"
#import "SJFitOnScreenManagerDefines.h"
#import "SJFlipTransitionManagerDefines.h"
#import "SJGestureControllerDefines.h"
#import "SJPictureInPictureControllerDefines.h"
#import "SJPlaybackHistoryControllerDefines.h"
#import "SJPromptingPopupControllerDefines.h"
#import "SJReachabilityDefines.h"
#import "SJRotationManagerDefines.h"
#import "SJSmallViewFloatingControllerDefines.h"
#import "SJSubtitlePopupControllerDefines.h"
#import "SJTextPopupControllerDefines.h"
#import "SJVideoPlayerControlLayerProtocol.h"
#import "SJVideoPlayerPlaybackControllerDefines.h"
#import "SJVideoPlayerPresentViewDefines.h"
#import "SJViewControllerManagerDefines.h"
#import "SJWatermarkViewDefines.h"
#import "CALayer+SJBaseVideoPlayerExtended.h"
#import "UIScrollView+SJBaseVideoPlayerExtended.h"
#import "UIView+SJBaseVideoPlayerExtended.h"
#import "UIViewController+SJBaseVideoPlayerExtended.h"
#import "SJTimerControl.h"
#import "SJVideoPlayerRegistrar.h"
#import "SJBaseVideoPlayerResourceLoader.h"
#import "SJBaseVideoPlayer+TestLog.h"
#import "SJBaseVideoPlayer.h"
#import "SJPlaybackRecordSaveHandler.h"
#import "UIScrollView+ListViewAutoplaySJAdd.h"
#import "SJAttributesRecorder.h"
#import "SJAttributeWorker.h"
#import "NSAttributedString+SJMake.h"
#import "SJAttributesFactory.h"
#import "SJUIKitAttributesDefines.h"
#import "SJUIKitTextMaker.h"
#import "SJUTAttributes.h"
#import "SJUTRangeHandler.h"
#import "SJUTRecorder.h"
#import "SJUTRegexHandler.h"
#import "SJUTUtils.h"
#import "NSObject+SJObserverHelper.h"
#import "SJPresentationQueue.h"
#import "SJQueue.h"
#import "SJRunLoopTaskQueue.h"
#import "SJTaskQueue.h"
#import "SJSQLite3ColumnOrder.h"
#import "SJSQLite3Condition.h"
#import "SJSQLite3Logger.h"
#import "SJSQLite3TableClassCache.h"
#import "SJSQLite3TableInfoCache.h"
#import "SJSQLiteColumnInfo.h"
#import "SJSQLiteCore.h"
#import "SJSQLiteErrors.h"
#import "SJSQLiteObjectInfo.h"
#import "SJSQLiteTableInfo.h"
#import "SJSQLiteTableModelConstraints.h"
#import "SJSQLiteTableModelProtocol.h"
#import "SJSQLite3+FoundationExtended.h"
#import "SJSQLite3+Private.h"
#import "SJSQLite3+QueryExtended.h"
#import "SJSQLite3+RemoveExtended.h"
#import "SJSQLite3+TableExtended.h"
#import "SJSQLite3.h"
#import "SJVideoPlayerConfigurations.h"
#import "SJControlLayerIdentifiers.h"
#import "SJItemTags.h"
#import "SJVideoPlayerLocalizedStringKeys.h"
#import "SJDraggingObservation.h"
#import "SJDraggingProgressPopupView.h"
#import "SJFullscreenModeStatusBar.h"
#import "SJLoadingView.h"
#import "SJScrollingTextMarqueeView.h"
#import "SJSpeedupPlaybackPopupView.h"
#import "SJVideoPlayerURLAsset+SJControlAdd.h"
#import "SJControlLayerDefines.h"
#import "SJDraggingObservationDefines.h"
#import "SJDraggingProgressPopupViewDefines.h"
#import "SJFullscreenModeStatusBarDefines.h"
#import "SJLoadingViewDefines.h"
#import "SJScrollingTextMarqueeViewDefines.h"
#import "SJSpeedupPlaybackPopupViewDefines.h"
#import "SJVideoPlayerClipsDefines.h"
#import "UIView+SJAnimationAdded.h"
#import "SJEdgeControlButtonItem.h"
#import "SJEdgeControlButtonItemAdapter.h"
#import "SJEdgeControlButtonItemAdapterLayout.h"
#import "SJEdgeControlButtonItemInternal.h"
#import "SJEdgeControlButtonItemView.h"
#import "SJEdgeControlLayerAdapters.h"
#import "SJButtonProgressSlider.h"
#import "SJCommonProgressSlider.h"
#import "SJProgressSlider.h"
#import "SJVideoPlayerControlMaskView.h"
#import "SJControlLayerSwitcher.h"
#import "SJClipsGIFRecordsControlLayer.h"
#import "SJClipsResultsControlLayer.h"
#import "SJClipsVideoRecordsControlLayer.h"
#import "SJClipsResultShareItem.h"
#import "SJClipsSaveResultToAlbumHandler.h"
#import "SJVideoPlayerClipsConfig.h"
#import "SJVideoPlayerClipsGeneratedResult.h"
#import "SJVideoPlayerClipsParameters.h"
#import "SJClipsBackButton.h"
#import "SJClipsButtonContainerView.h"
#import "SJClipsCommonViewLayer.h"
#import "SJClipsGIFCountDownView.h"
#import "SJClipsResultShareItemsContainerView.h"
#import "SJClipsVideoCountDownView.h"
#import "SJClipsControlLayer.h"
#import "SJEdgeControlLayer.h"
#import "SJLoadFailedControlLayer.h"
#import "SJMoreSettingControlLayer.h"
#import "SJNotReachableControlLayer.h"
#import "SJSmallViewControlLayer.h"
#import "SJVideoDefinitionSwitchingControlLayer.h"
#import "SJVideoPlayerURLAsset+SJExtendedDefinition.h"
#import "SJVideoPlayerResourceLoader.h"
#import "SJVideoPlayer.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
#import "XPathQuery.h"

FOUNDATION_EXPORT double HYUKSDKVersionNumber;
FOUNDATION_EXPORT const unsigned char HYUKSDKVersionString[];

