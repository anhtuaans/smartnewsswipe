//
//  ViewModelManager.m
//  SmartNewsSwipe
//
//  Created by Anh Tuan on 10/10/19.
//  Copyright © 2019 Anh Tuan. All rights reserved.
//

#import "ViewModelManager.h"

@interface ViewModelManager ()

@property (nonatomic, strong, readwrite) NSArray<ViewModel *> *menuData;
@property (nonatomic, strong, readwrite) NSArray<NSString *> *contentData;

@end

@implementation ViewModelManager

static ViewModelManager *_sharedInstance = nil;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.menuData = @[
            [[ViewModel alloc] initWithTitle:@"メニュー1" content:@"コンテンツ1" color:UIColor.redColor],
            [[ViewModel alloc] initWithTitle:@"メニュー2" content:@"コンテンツ2" color:UIColor.greenColor],
            [[ViewModel alloc] initWithTitle:@"メニュー3" content:@"コンテンツ3" color:UIColor.purpleColor],
            [[ViewModel alloc] initWithTitle:@"メニュー4" content:@"コンテンツ4" color:UIColor.yellowColor],
            [[ViewModel alloc] initWithTitle:@"メニュー5" content:@"コンテンツ5" color:UIColor.cyanColor],
            [[ViewModel alloc] initWithTitle:@"メニュー6" content:@"コンテンツ6" color:UIColor.orangeColor],
            [[ViewModel alloc] initWithTitle:@"メニュー7" content:@"コンテンツ7" color:UIColor.redColor],
            [[ViewModel alloc] initWithTitle:@"メニュー8" content:@"コンテンツ8" color:UIColor.greenColor],
            [[ViewModel alloc] initWithTitle:@"メニュー9" content:@"コンテンツ9" color:UIColor.purpleColor],
            [[ViewModel alloc] initWithTitle:@"メニュー10" content:@"コンテンツ10" color:UIColor.yellowColor],
            [[ViewModel alloc] initWithTitle:@"メニュー11" content:@"コンテンツ11" color:UIColor.cyanColor],
            [[ViewModel alloc] initWithTitle:@"メニュー12" content:@"コンテンツ12" color:UIColor.orangeColor],
            [[ViewModel alloc] initWithTitle:@"メニュー13" content:@"コンテンツ13" color:UIColor.redColor],
            [[ViewModel alloc] initWithTitle:@"メニュー14" content:@"コンテンツ14" color:UIColor.greenColor],
            [[ViewModel alloc] initWithTitle:@"メニュー15" content:@"コンテンツ15" color:UIColor.purpleColor],
            [[ViewModel alloc] initWithTitle:@"メニュー16" content:@"コンテンツ16" color:UIColor.yellowColor],
            [[ViewModel alloc] initWithTitle:@"メニュー17" content:@"コンテンツ17" color:UIColor.cyanColor],
            [[ViewModel alloc] initWithTitle:@"メニュー18" content:@"コンテンツ18" color:UIColor.orangeColor],
            [[ViewModel alloc] initWithTitle:@"メニュー19" content:@"コンテンツ19" color:UIColor.redColor],
            [[ViewModel alloc] initWithTitle:@"メニュー20" content:@"コンテンツ20" color:UIColor.greenColor],
            [[ViewModel alloc] initWithTitle:@"メニュー21" content:@"コンテンツ21" color:UIColor.purpleColor],
            [[ViewModel alloc] initWithTitle:@"メニュー22" content:@"コンテンツ22" color:UIColor.yellowColor],
            [[ViewModel alloc] initWithTitle:@"メニュー23" content:@"コンテンツ23" color:UIColor.cyanColor],
            [[ViewModel alloc] initWithTitle:@"メニュー24" content:@"コンテンツ24" color:UIColor.orangeColor],
            [[ViewModel alloc] initWithTitle:@"メニュー25" content:@"コンテンツ25" color:UIColor.redColor],
            [[ViewModel alloc] initWithTitle:@"メニュー26" content:@"コンテンツ26" color:UIColor.greenColor],
            [[ViewModel alloc] initWithTitle:@"メニュー27" content:@"コンテンツ27" color:UIColor.purpleColor],
            [[ViewModel alloc] initWithTitle:@"メニュー28" content:@"コンテンツ28" color:UIColor.yellowColor],
            [[ViewModel alloc] initWithTitle:@"メニュー29" content:@"コンテンツ29" color:UIColor.cyanColor],
            [[ViewModel alloc] initWithTitle:@"メニュー30" content:@"コンテンツ30" color:UIColor.orangeColor],
            [[ViewModel alloc] initWithTitle:@"メニュー31" content:@"コンテンツ31" color:UIColor.redColor],
            [[ViewModel alloc] initWithTitle:@"メニュー32" content:@"コンテンツ32" color:UIColor.greenColor],
            [[ViewModel alloc] initWithTitle:@"メニュー33" content:@"コンテンツ33" color:UIColor.purpleColor],
            [[ViewModel alloc] initWithTitle:@"メニュー34" content:@"コンテンツ34" color:UIColor.yellowColor],
            [[ViewModel alloc] initWithTitle:@"メニュー35" content:@"コンテンツ35" color:UIColor.cyanColor],
            [[ViewModel alloc] initWithTitle:@"メニュー36" content:@"コンテンツ36" color:UIColor.orangeColor],
            [[ViewModel alloc] initWithTitle:@"メニュー37" content:@"コンテンツ37" color:UIColor.redColor],
            [[ViewModel alloc] initWithTitle:@"メニュー38" content:@"コンテンツ38" color:UIColor.greenColor],
            [[ViewModel alloc] initWithTitle:@"メニュー39" content:@"コンテンツ39" color:UIColor.purpleColor],
            [[ViewModel alloc] initWithTitle:@"メニュー40" content:@"コンテンツ40" color:UIColor.yellowColor],
            [[ViewModel alloc] initWithTitle:@"メニュー41" content:@"コンテンツ41" color:UIColor.cyanColor],
            [[ViewModel alloc] initWithTitle:@"メニュー42" content:@"コンテンツ42" color:UIColor.orangeColor],
        ];
        
        self.contentData = @[
            @"1",
            @"2",
            @"3",
            @"4",
            @"5",
            @"6",
            @"7",
            @"8",
            @"9",
            @"10",
            @"11",
            @"12",
            @"13",
            @"14",
            @"15",
            @"16",
            
        ];
    }
    
    return self;
}

+ (ViewModelManager *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [ViewModelManager new];
    });
    return _sharedInstance;
}

@end

@implementation ViewModel

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content color:(UIColor *)color {
    if (self = [super init]) {
        self.menuTitle = title;
        self.content = content;
        self.themeColor = color;
    }
    return self;
}

@end
