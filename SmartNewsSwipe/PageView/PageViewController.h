//
//  PageViewController.h
//  SmartNewsSwipe
//
//  Created by Anh Tuan on 10/10/19.
//  Copyright © 2019 Anh Tuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PageViewController;

@protocol PageViewControllerDelegate <NSObject>

- (UIViewController *)pageViewController:(PageViewController *)pageViewController
                   viewControllerAtIndex:(NSInteger)index;
- (NSInteger)pageViewController:(PageViewController *)pageViewController
          indexOfViewController:(UIViewController *)viewController;
- (NSInteger)numberOfPagesInPageViewController:(PageViewController *)pageViewController;

- (void)pageViewController:(PageViewController *)pageViewController
              changedIndex:(NSInteger)index;

@end

@interface PageViewController : UIPageViewController

@property (nonatomic, weak)id<PageViewControllerDelegate> pageDelegate;

- (void)setScrollEnable:(BOOL)enabled;

@end

NS_ASSUME_NONNULL_END
