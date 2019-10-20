//
//  MenuCollectionViewCell.m
//  SmartNewsSwipe
//
//  Created by Anh Tuan on 10/10/19.
//  Copyright © 2019 Anh Tuan. All rights reserved.
//

#import "MenuCollectionViewCell.h"

@interface MenuCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@end

@implementation MenuCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.bgView.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii: (CGSize){6.0, 6.0}].CGPath;
    maskLayer.frame = self.bgView.bounds;
    self.bgView.layer.mask = maskLayer;
}

- (void)configureCellWith:(NSString *)title bgColor:(UIColor *)bgColor active:(BOOL)active {
    self.titleLabel.text = title;
    self.bgView.backgroundColor = bgColor;
    [self focusCell:active];
    [self layoutIfNeeded];
}

- (void)focusCell:(BOOL)active {
    UIColor *color = active ? UIColor.whiteColor : UIColor.lightGrayColor;
    self.titleLabel.textColor = color;
    self.topConstraint.constant = active ? 0 : 6;
    [self setNeedsDisplay];
}

@end
