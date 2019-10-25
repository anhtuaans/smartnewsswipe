//
//  ContentViewController.m
//  SmartNewsSwipe
//
//  Created by Anh Tuan on 10/10/19.
//  Copyright © 2019 Anh Tuan. All rights reserved.
//

#import "ContentViewController.h"
#import "ViewModelManager.h"
#import "PageViewController.h"

@interface ContentViewController () <PageContentViewControllerDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.contentLabel.text = ViewModelManager.sharedInstance.menuData[self.index].content;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([self.delegate respondsToSelector:@selector(contentViewControllerViewWillAppear:)]) {
        [self.delegate contentViewControllerViewWillAppear:self];
    }
}

- (void)dealloc {
    NSLog(@"ContentViewController dealloc");
}

- (void)resetUIs {
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ViewModelManager sharedInstance].contentData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *cellTitle = [ViewModelManager sharedInstance].contentData[indexPath.row];
    cell.textLabel.text = cellTitle;
    return cell;
}

@end
