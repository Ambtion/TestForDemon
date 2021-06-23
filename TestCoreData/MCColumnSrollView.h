////
////  MCColumnSrollView.h
////  TestCoreData
////
////  Created by kequ on 2021/6/23.
////
//
//#import <UIKit/UIKit.h>
//
//
//NS_ASSUME_NONNULL_BEGIN
//
//typedef NS_ENUM(NSUInteger, kColumItemState) {
//    kColumItemStateNormal, // 普通默认态，无数据灰色 or 有数据蓝色
//    kColumItemStateForces, // 选择态，蓝色
//    kColumItemStateInvalid // 无效态，不显示内容
//};
//
//@class MCColumnSrollView;
//
//@interface MCColumnItemAttributes : NSObject
//
//@property (nonatomic, assign) kColumItemState state;
//
//@property (nonatomic, copy) NSString *annotation;
//
//@property (nonatomic) CGFloat value; //range is [0,1]
//@property (nonatomic, copy) NSString *title;
//@property (nonatomic, copy) NSString *bottomTitle;
//
//
//
//@end
//
//@protocol MCColumnSrollViewDataSource<NSObject>
//
//@required
//
///// 显示的柱行图个数
///// @param columScrollView columScrollView
//-(NSUInteger)numberOfItemsInColumnSrollView:(MCColumnSrollView*)columScrollView;
//
//-(MCColumnItemAttributes*)timePillarView:(MCColumnSrollView*)columScrollView
//                attributesForItemAtIndex:(NSUInteger)index;
//
//@optional
//
///// 文案标题。如不传递，默认使用对应MCColumnItemAttributes title 属性
///// @param columScrollView columScrollView
///// @param index index
///// @param state 文案状态
//-(NSString*)columScrollView:(MCColumnSrollView*)columScrollView
//               titleAtIndex:(NSUInteger)index forState:(kColumItemState)state;
////
////- (NSInteger)indexOfFocusItem;
//
//@end
//
//@protocol MCColumnSrollViewDelegate <NSObject>
//
//@optional
//
//@end
//
//@interface MCColumnSrollView : UIView
//
//@property (nonatomic, weak) id<MCColumnSrollViewDataSource> dataSource;
//@property (nonatomic, weak) id<MCColumnSrollViewDelegate> delegate;
//
//+ (CGFloat)heightForView;
//- (instancetype)new NS_UNAVAILABLE;
//- (instancetype)init NS_UNAVAILABLE;
//- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
//- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
//
//@end
//
//NS_ASSUME_NONNULL_END
