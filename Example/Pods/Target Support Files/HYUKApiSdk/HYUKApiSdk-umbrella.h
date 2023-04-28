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

#import "HYVideoAFNetBaseRequset.h"
#import "HYVideoAFRequestWorking.h"
#import "HYAPIString.h"
#import "HYVideoApiHeader.h"
#import "HYUKApiHeader.h"
#import "HYRequestCategeryModel.h"
#import "HYRequestSearchModel.h"
#import "HYRequestVideoListModel.h"
#import "HYResponseCategeryModel.h"
#import "HYResponseSearchModel.h"
#import "HYResponseVideoListModel.h"

FOUNDATION_EXPORT double HYUKApiSdkVersionNumber;
FOUNDATION_EXPORT const unsigned char HYUKApiSdkVersionString[];

