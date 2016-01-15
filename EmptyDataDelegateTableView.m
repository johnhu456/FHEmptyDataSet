//
//  EmptyDataDelegate.m
//  Shire
//
//  Created by MADAO on 16/1/14.
//  Copyright © 2016年 LLJZ. All rights reserved.
//

#import "EmptyDataDelegateTableView.h"
#import <UIScrollView+EmptyDataSet.h>
#import "Global.h"

@interface EmptyDataDelegateTableView ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@end

@implementation EmptyDataDelegateTableView
- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.emptyDataSetDelegate = self;
        self.emptyDataSetSource = self;
        self.loadState = EmptyDataStateLoading;
    }
    return self;
}
- (void)setLoadState:(EmptyDataState)loadState
{
    if (self.loadState == loadState) {
        return;
    }
    self.hidden = NO;
    _loadState = loadState;
    if (loadState == EmptyDataStateDoneLoad) {
        self.hidden = YES;
    }
    else
        self.hidden = NO;
    [self reloadEmptyDataSet];
}
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    switch (self.loadState) {
        default:
            return NO;
            break;
    }
}
/**加载时图片的旋转效果，可关闭*/
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}
/**标题*/
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    switch (self.loadState) {
        case EmptyDataStateNoData:
            text = @"暂无记录";
            break;
        case EmptyDataStateLoading:
            text = @"正在努力加载...";
            break;
        case EmptyDataStateFailure:
            text = @"操作失败";
            break;
        default:
            text = @" ";
            break;
    }
    font = SH_FONT_THIN_MIDDLE;
    textColor = [UIColor lightGrayColor];
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    return attributedString;
}
/**描述*/
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.loadState == EmptyDataStateFailure) {
        NSString *text = @"点击屏幕,重新加载";
        UIFont *font = SH_FONT_BOLD_MIDDLE;
        UIColor *textColor = [UIColor lightGrayColor];
        textColor = [UIColor lightGrayColor];
        font = [UIFont boldSystemFontOfSize:14.0];
        NSMutableDictionary *attributes = [NSMutableDictionary new];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
        return attributedString;
    }
    else
        return nil;
}
/**图片*/
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    switch (self.loadState) {
        case EmptyDataStateFailure:
            return [UIImage imageNamed:@"password_img_icon"];
            break;
        case EmptyDataStateLoading:
            return [UIImage animatedImageNamed:@"loading_imv_frame" duration:0.5];
            break;
        case EmptyDataStateNoData:
            return [UIImage imageNamed:@"transferResult_img_icon_success"];
        default:
            return nil;
            break;
    }
}
/**点击时调用*/
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView
{
    self.loadState = EmptyDataStateLoading;
    [self.emptyDataDeleate startReload];
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 10.f;
}

@end
