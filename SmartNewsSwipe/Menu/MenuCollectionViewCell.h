//
//  MenuCollectionViewCell.h
//  SmartNewsSwipe
//
//  Created by Anh Tuan on 10/10/19.
//  Copyright © 2019 Anh Tuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuCollectionViewCell : UICollectionViewCell

- (void)configureCellWith:(NSString *)title bgColor:(UIColor *)bgColor active:(BOOL)active;
- (void)focusCell:(BOOL)active;

@end

NS_ASSUME_NONNULL_END
