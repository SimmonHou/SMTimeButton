//
//  UIButton+TimeButton.m
//  SendMessageToNil
//  计时
//  Created by Small on 16/7/25.
//  Copyright © 2016年 ZaZa. All rights reserved.
//

#import "UIButton+TimeButton.h"
#import <objc/runtime.h>
@interface UIButton ()
@property (nonatomic,strong)NSDate *timeSeconds;
@end

static const NSString *secondKey = @"timeSeconds";
@implementation UIButton (TimeButton)

- (void)setTimeSeconds:(NSDate *)timeSeconds
{
    objc_setAssociatedObject(self, &secondKey, timeSeconds, OBJC_ASSOCIATION_COPY);
}
- (NSDate *)timeSeconds
{
   return objc_getAssociatedObject(self, &secondKey);
}
- (void)stareCountTime
{
    self.timeSeconds = [NSDate date];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(buttonEndle:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

}
- (void)buttonEndle:(NSTimer *)timer
{
    
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.timeSeconds];
    // 倒计时的话 自己做个-- 操作就行 这里只是做一个基本的演示
    if ((long)timeInterval == 10) {
        self.enabled = NO;
        [self setTitle:@"按钮失效" forState:UIControlStateDisabled];
        [timer invalidate];
        timer = nil;
    }
    NSLog(@"%ld",(long)timeInterval);
}

@end
