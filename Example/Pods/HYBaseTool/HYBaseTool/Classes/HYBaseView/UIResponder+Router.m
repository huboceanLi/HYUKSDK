//
//  UIResponder+Router.m
//  MYSaSClerk
//
//  Created by chong on 2019/12/7.
//  Copyright © 2019 chong. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerWithEventName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    if (self.nextResponder) {
        [[self nextResponder] routerWithEventName:eventName userInfo:userInfo];
    }
}

- (void)routerWithEventName:(NSString *)eventName object:(id)object {
    if (self.nextResponder) {
        [self.nextResponder routerWithEventName:eventName object:object];
    }
}

@end
