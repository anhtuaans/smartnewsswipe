//
//  MenuViewController.m
//  SmartNewsSwipe
//
//  Created by Anh Tuan on 10/10/19.
//  Copyright © 2019 Anh Tuan. All rights reserved.
//

#import "MenuViewController.h"
#import "ViewModelManager.h"
#import "MenuCollectionViewCell.h"

@interface MenuViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, assign) NSUInteger selectedIndex;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MenuCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MenuCollectionViewCell"];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(100.0, 40.0);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.prefetchingEnabled = NO;
}

- (void)reloadData {
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.delegate numberOfTabsInMenuViewController:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MenuCollectionViewCell" forIndexPath:indexPath];
    ViewModel *model = [self.delegate menuViewController:self viewModelAtIndex:indexPath.row];
    BOOL active = (indexPath.row == self.selectedIndex);
    [cell configureCellWith:model.menuTitle bgColor:model.themeColor active:active];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self focusCellAtIndex:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(menuViewController:selectedIndex:)]) {
        [self.delegate menuViewController:self selectedIndex:indexPath.row];
    }
}

- (void)focusCellAtIndex:(NSIndexPath *) indexPath {
    if (self.selectedIndex == indexPath.row) {
        return;
    }
    
    MenuCollectionViewCell *previousCell = (MenuCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0]];
    if (previousCell) {
        [previousCell focusCell:NO];
    }
    
    MenuCollectionViewCell *nextCell = (MenuCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    if (nextCell) {
        [nextCell focusCell:YES];
    }
    
    self.selectedIndex = indexPath.row;
    [self.collectionView scrollToItemAtIndexPath:indexPath
                                atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                        animated:YES];
}

@end
