//
//  PageViewController.m
//  SmartNewsSwipe
//
//  Created by Anh Tuan on 10/10/19.
//  Copyright © 2019 Anh Tuan. All rights reserved.
//

#import "PageViewController.h"
#import "ContentViewController.h"

@interface PageViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate,
UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat prevOffset;
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidEnterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    self.dataSource = self;
    self.delegate = self;
    
    for (UIView *subview in self.view.subviews) {
        if ([subview isKindOfClass:[UIScrollView class]]) {
            self.scrollView = (UIScrollView *)subview;
            self.scrollView.delegate = self;
            return;
        }
    }
    
    self.prevOffset = 0;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Public methods

- (void)setScrollEnable:(BOOL)enabled {
    self.scrollView.scrollEnabled = enabled;
}

#pragma mark - Observer

- (void)applicationDidEnterBackground:(NSNotification *)notification {
    [self.pageDelegate pageViewControllerEndDecelerating:self];
}

#pragma mark - Override methods

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers
                 direction:(UIPageViewControllerNavigationDirection)direction
                  animated:(BOOL)animated
                completion:(void (^)(BOOL))completion {
    [super setViewControllers:viewControllers
                    direction:direction
                     animated:animated
                   completion:completion];
    self.pageIndex = [self.pageDelegate pageViewController:self
                                     indexOfViewController:viewControllers.firstObject];
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger prevIndex = [self.pageDelegate pageViewController:self indexOfViewController:viewController] - 1;

    if (prevIndex < 0) {
        return nil;
    }
        
    return [self.pageDelegate pageViewController:self viewControllerAtIndex:prevIndex];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger nextIndex = [self.pageDelegate pageViewController:self indexOfViewController:viewController] + 1;

    if (nextIndex >= [self.pageDelegate numberOfPagesInPageViewController:self]) {
        return nil;
    }
    
    return [self.pageDelegate pageViewController:self viewControllerAtIndex:nextIndex];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.pageDelegate pageViewControllerBeginDragging:self];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"scrollViewDidEndDragging %@", @(decelerate));
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.pageDelegate pageViewControllerEndDecelerating:self];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.view.frame.size.width;
    CGFloat pageWidthHalf = pageWidth / 2;
    CGFloat offset = scrollView.contentOffset.x - pageWidth;
    NSLog(@"scrollViewDidScroll offset %lf", offset);
    NSLog(@"scrollViewDidScroll isDragging %@, isDecelerating %@", @(scrollView.isDragging), @(scrollView.isDecelerating));
    if (!scrollView.isDragging && !scrollView.isDecelerating) {
        return;
    }
    if (offset == 0 || fabs(offset - self.prevOffset) > pageWidthHalf) {
        self.prevOffset = offset;
        return;
    }
    
    if ((self.prevOffset < pageWidthHalf && offset >= pageWidthHalf) ||
        (self.prevOffset < -pageWidthHalf && offset >= -pageWidthHalf)) {
        NSLog(@"page up");
        self.pageIndex += 1;
        if (self.pageIndex < [self.pageDelegate numberOfPagesInPageViewController:self]) {
            [self.pageDelegate pageViewController:self
                                     changedIndex:self.pageIndex];
        }
    } else if ((self.prevOffset > -pageWidthHalf && offset <= -pageWidthHalf) ||
               (self.prevOffset > pageWidthHalf && offset <= pageWidthHalf)) {
        NSLog(@"page down");
        self.pageIndex -= 1;
        if (self.pageIndex >= 0) {
            [self.pageDelegate pageViewController:self
                                     changedIndex:self.pageIndex];
        }
    }
    self.prevOffset = offset;
}

@end
