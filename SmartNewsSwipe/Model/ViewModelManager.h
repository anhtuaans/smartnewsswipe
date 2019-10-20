//
//  ViewModelManager.h
//  SmartNewsSwipe
//
//  Created by Anh Tuan on 10/10/19.
//  Copyright © 2019 Anh Tuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewModel : NSObject

@property (nonatomic, strong) NSString *menuTitle;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) UIColor *themeColor;

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content color:(UIColor *)color;

@end

@interface ViewModelManager : NSObject

@property (nonatomic, strong, readonly) NSArray<ViewModel *> *menuData;
@property (nonatomic, strong, readonly) NSArray<NSString *> *contentData;

+ (ViewModelManager *)sharedInstance;

@end

NS_ASSUME_NONNULL_END
