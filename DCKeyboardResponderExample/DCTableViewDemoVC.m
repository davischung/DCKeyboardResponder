//
//  DCTableViewDemoVC.m
//  DCKeyboardResponderExample
//
//  Created by Davis Chung on 5/8/15.
//  Copyright (c) 2015 Davis Chung. All rights reserved.
//

#import "DCTableViewDemoVC.h"
#import "DCKeyboardResponder.h"

@interface DCTableViewDemoVC () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) DCKeyboardResponder *kr;

@end

@implementation DCTableViewDemoVC

#pragma mark - UITableViewDelegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    for (UIView *subview in [cell subviews]) {
        if (subview.tag == 1000 || subview.tag == 1001)
            [subview removeFromSuperview];
    }
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(16, 8, 150, 28)];
    tf.backgroundColor = [UIColor lightGrayColor];
    tf.delegate = _kr;
    tf.text = [NSString stringWithFormat:@"Row :%d", (int)indexPath.row];
    tf.returnKeyType = UIReturnKeyDone;
    tf.tag = 1000;
    [cell addSubview:tf];
    
    UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(16 +150 +16, 0, 150, 40)];
    tv.backgroundColor = [UIColor lightGrayColor];
    tv.delegate = _kr;
    tv.text = [NSString stringWithFormat:@"Row :%d", (int)indexPath.row];
    tv.returnKeyType = UIReturnKeyDone;
    tv.tag = 1001;
    [cell addSubview:tv];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - View Lifecycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"UITableView Demo";
    
    _kr = [[DCKeyboardResponder alloc] initWithDelegate:self];
    _kr.scrollView = _tv;
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
