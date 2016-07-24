//
//  LQSWaterFlowView.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/7/18.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    LQSWaterFlowViewMarginTypeTop,
    LQSWaterFlowViewMarginTypeBottom,
    LQSWaterFlowViewMarginTypeLeft,
    LQSWaterFlowViewMarginTypeRight,
    LQSWaterFlowViewMarginTypeColumn, // 每一列
    LQSWaterFlowViewMarginTypeRow, // 每一行
} LQSWaterFlowViewMarginType;

@class LQSWaterFlowView, LQSWaterFlowViewCell;
/**
 *  数据源方法
 */
@protocol LQSWaterFlowViewDataSource <NSObject>
@required
/**
 *  一共有多少个数据
 */
- (NSUInteger)numberOfCellsInWaterflowView:(LQSWaterFlowView *)waterflowView;
/**
 *  返回index位置对应的cell
 */
- (LQSWaterFlowViewCell *)waterflowView:(LQSWaterFlowView *)waterflowView cellAtIndex:(NSUInteger)index;

@optional
/**
 *  一共有多少列
 */
- (NSUInteger)numberOfColumnsInWaterflowView:(LQSWaterFlowView *)waterflowView;
@end

/**
 *  代理方法
 */
@protocol LQSWaterFlowViewDelegate <UIScrollViewDelegate>
@optional
/**
 *  第index位置cell对应的高度
 */
- (CGFloat)waterflowView:(LQSWaterFlowView *)waterflowView heightAtIndex:(NSUInteger)index;
/**
 *  选中第index位置的cell
 */
- (void)waterflowView:(LQSWaterFlowView *)waterflowView didSelectAtIndex:(NSUInteger)index;
/**
 *  返回间距
 */
- (CGFloat)waterflowView:(LQSWaterFlowView *)waterflowView marginForType:(LQSWaterFlowViewMarginType)type;

@end

/**
 *  瀑布流控件
 */
@interface LQSWaterFlowView : UIScrollView
/**
 *  数据源
 */
@property (nonatomic, weak) id<LQSWaterFlowViewDataSource> dataSource;
/**
 *  代理
 */
@property (nonatomic, weak) id<LQSWaterFlowViewDelegate> delegate;

/**
 *  刷新数据（只要调用这个方法，会重新向数据源和代理发送请求，请求数据）
 */
- (void)reloadData;

/**
 *  cell的宽度
 */
- (CGFloat)cellWidth;

/**
 *  根据标识去缓存池查找可循环利用的cell
 */
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;
@end