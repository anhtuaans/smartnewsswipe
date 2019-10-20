//
//  MenuViewController.h
//  SmartNewsSwipe
//
//  Created by Anh Tuan on 10/10/19.
//  Copyright © 2019 Anh Tuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MenuViewController;
@class ViewModel;

@protocol MenuViewControllerDelegate <NSObject>

- (NSInteger)numberOfTabsInMenuViewController:(MenuViewController *)menuViewController;
- (ViewModel *)menuViewController:(MenuViewController *)menuViewController viewModelAtIndex:(NSInteger)index;
- (void)menuViewController:(MenuViewController *)menuViewController selectedIndex:(NSInteger)index;

@end

@interface MenuViewController : UIViewController

@property (nonatomic, weak)id<MenuViewControllerDelegate> delegate;

- (void)reloadData;
- (void)focusCellAtIndex:(NSIndexPath *) indexPath;

@end

NS_ASSUME_NONNULL_END
