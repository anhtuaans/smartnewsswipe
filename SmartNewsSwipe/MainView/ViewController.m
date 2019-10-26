//
//  ViewController.m
//  SmartNewsSwipe
//
//  Created by Anh Tuan on 10/10/19.
//  Copyright © 2019 Anh Tuan. All rights reserved.
//

#import "ViewController.h"
#import "MenuViewController.h"
#import "PageViewController.h"
#import "ContentViewController.h"
#import "ViewModelManager.h"

@interface ViewController () <MenuViewControllerDelegate, PageViewControllerDelegate>

@property (nonatomic, strong) MenuViewController *menuVC;
@property (nonatomic, strong) PageViewController *pageVC;
@property (nonatomic, assign) NSInteger defaultIndex;

@property (nonatomic, strong) NSCache *vcCache;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.vcCache = [[NSCache alloc] init];
    
    self.menuVC.delegate = self;
    self.pageVC.pageDelegate = self;
    
    self.defaultIndex = 2;
    
    UIViewController *vc = [self pageViewController:self.pageVC viewControllerAtIndex:self.defaultIndex];
    [self.pageVC setViewControllers:@[vc]
                          direction:UIPageViewControllerNavigationDirectionForward
                           animated:NO
                         completion:nil];
    [self.menuVC reloadData];
    [self.menuVC focusCellAtIndex:[NSIndexPath indexPathForRow:self.defaultIndex inSection:0]];
}

- (void)dealloc {
    [self.vcCache removeAllObjects];
}

- (UIViewController *)viewControllerAtIndex:(NSInteger)index {
    UIViewController *cachedVC = [self.vcCache objectForKey:@(index)];
    if (cachedVC) {
        return cachedVC;
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ContentViewController" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
    ContentViewController *contentVC = (ContentViewController *)vc;
    contentVC.index = index;
    [self.vcCache setObject:vc forKey:@(index)];
    return vc;
}

#pragma mark - MenuViewControllerDelegate

- (void)menuViewController:(MenuViewController *)menuViewController
             selectedIndex:(NSInteger)index {
    UIViewController *currentVC = self.pageVC.viewControllers.firstObject;
    NSInteger currentIndex = [self pageViewController:self.pageVC indexOfViewController:currentVC];
    if (index == currentIndex) {
        return;
    }
    
    UIPageViewControllerNavigationDirection direction = currentIndex < index ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;
    UIViewController *vc = [self pageViewController:self.pageVC viewControllerAtIndex:index];
    
    // Prevent to tap on menu and swipe page when animation is running
    [self.pageVC setScrollEnable:NO];
    self.menuVC.view.userInteractionEnabled = NO;
    __weak typeof(self) weakSelf = self;
    [self.pageVC setViewControllers:@[vc] direction:direction animated:YES completion:^(BOOL finished) {
        [weakSelf.pageVC setScrollEnable:YES];
        weakSelf.menuVC.view.userInteractionEnabled = YES;
        NSLog(@"finished %@", @(finished));
    }];
}

- (NSInteger)numberOfTabsInMenuViewController:(MenuViewController *)menuViewController {
    return [ViewModelManager sharedInstance].menuData.count;
}

- (ViewModel *)menuViewController:(MenuViewController *)menuViewController viewModelAtIndex:(NSInteger)index {
    return [ViewModelManager sharedInstance].menuData[index];
}

#pragma mark - PageViewControllerDelegate

- (UIViewController *)pageViewController:(PageViewController *)pageViewController
                   viewControllerAtIndex:(NSInteger)index {
    return [self viewControllerAtIndex:index];
}

- (NSInteger)pageViewController:(PageViewController *)pageViewController
          indexOfViewController:(UIViewController *)viewController {
    ContentViewController *vc = (ContentViewController *)viewController;
    return vc.index;
}

- (NSInteger)numberOfPagesInPageViewController:(PageViewController *)pageViewController {
    return [ViewModelManager sharedInstance].menuData.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"menu_segue"]) {
        self.menuVC = segue.destinationViewController;
    } else if ([segue.identifier isEqualToString:@"page_segue"]) {
        self.pageVC = segue.destinationViewController;
    }
}

- (void)pageViewController:(PageViewController *)pageViewController
              changedIndex:(NSInteger)index {
    [self.menuVC focusCellAtIndex:[NSIndexPath indexPathForRow:index inSection:0]];
}

- (void)pageViewControllerBeginDragging:(PageViewController *)pageViewController {
    self.menuVC.view.userInteractionEnabled = NO;
}

- (void)pageViewControllerEndDecelerating:(PageViewController *)pageViewController {
    self.menuVC.view.userInteractionEnabled = YES;
}

@end
