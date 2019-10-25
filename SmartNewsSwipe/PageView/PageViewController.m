//
//  PageViewController.m
//  SmartNewsSwipe
//
//  Created by Anh Tuan on 10/10/19.
//  Copyright © 2019 Anh Tuan. All rights reserved.
//

#import "PageViewController.h"
#import "ContentViewController.h"

@interface PageViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = self;
    self.delegate = self;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger prevIndex = [self.pageDelegate pageViewController:self indexOfViewController:viewController] - 1;
    if (prevIndex < 0) {
        return nil;
    }
        
    return [self.pageDelegate pageViewController:self viewControllerAtIndex:prevIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger nextIndex = [self.pageDelegate pageViewController:self indexOfViewController:viewController] + 1;
    if (nextIndex >= [self.pageDelegate numberOfPagesInPageViewController:self]) {
        return nil;
    }
    
    return [self.pageDelegate pageViewController:self viewControllerAtIndex:nextIndex];
}

@end
