//
//  EmptyDataDelegate.h
//  Shire
//
//  Created by MADAO on 16/1/14.
//  Copyright © 2016年 LLJZ. All rights reserved.
//

#import <UIKit/UIKit.h>

/**刷新状态*/
typedef enum : NSUInteger {
    EmptyDataStateLoading = 1,
    EmptyDataStateDoneLoad,
    EmptyDataStateNoData,
    EmptyDataStateFailure,
} EmptyDataState;
@protocol EmptyDataDelegate <NSObject>
/**代理重新加载数据*/
- (void)startReload;
@end
@interface EmptyDataDelegateTableView :UITableView

@property (nonatomic, assign) EmptyDataState loadState;

@property (nonatomic, weak) id<EmptyDataDelegate> emptyDataDeleate;
@end
