//
//  AdaptScreen.h
//  Pods
//
//  Created by Ocean 李 on 2023/6/15.
//

#ifndef AdaptScreen_h
#define AdaptScreen_h

#define XJ_INLINE static inline

/**< 适配ipad计算大小*/
XJ_INLINE CGFloat XJFlexibleWidth(CGFloat iphoneSetWidth){
    
//    CGFloat width = iphone5SSize.width * XJHorizontalMultiplier();
//    if (adjustWidth) {
//        width = iphone5SSize.width * XJVerticalMultiplier();
//    }
//    CGFloat height = iphone5SSize.height * XJVerticalMultiplier();
    return IS_IPAD ? iphoneSetWidth * 1.5 : iphoneSetWidth;
}

/**< 适配ipad文字大小*/
XJ_INLINE NSInteger XJFlexibleFont(NSInteger fontSize){
    
//    CGFloat width = iphone5SSize.width * XJHorizontalMultiplier();
//    if (adjustWidth) {
//        width = iphone5SSize.width * XJVerticalMultiplier();
//    }
//    CGFloat height = iphone5SSize.height * XJVerticalMultiplier();
    return IS_IPAD ? (ceil(fontSize * 1.5)) : fontSize;
}

#endif /* AdaptScreen_h */
