//
//  DCTypeListVC.m
//  DCKeyboardResponderExample
//
//  Created by Davis Chung on 5/8/15.
//  Copyright (c) 2015 Davis Chung. All rights reserved.
//

#import "DCTypeListVC.h"
#import "DCScrollViewDemoVC.h"
#import "DCTableViewDemoVC.h"

@interface DCTypeListVC () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation DCTypeListVC

#pragma mark - UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"UIScrollView Demo";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"UITableView Demo";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        DCScrollViewDemoVC *vc = [DCScrollViewDemoVC new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        DCTableViewDemoVC *vc = [DCTableViewDemoVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - View Lifecycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"DCKeyboardResponder Demo";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
