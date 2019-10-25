//
//  ContentViewController.h
//  SmartNewsSwipe
//
//  Created by Anh Tuan on 10/10/19.
//  Copyright © 2019 Anh Tuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ContentViewController;

@protocol ContentViewControllerDelegate <NSObject>

- (void)contentViewControllerViewWillAppear:(ContentViewController *)contentViewController;

@end

@interface ContentViewController : UIViewController

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, weak) id<ContentViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
