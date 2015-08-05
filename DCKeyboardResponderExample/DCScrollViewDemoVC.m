//
//  DCScrollViewDemoVC.m
//  DCKeyboardResponderExample
//
//  Created by Davis Chung on 5/8/15.
//  Copyright (c) 2015 Davis Chung. All rights reserved.
//

#import "DCScrollViewDemoVC.h"
#import "DCKeyboardResponder.h"

@interface DCScrollViewDemoVC () <UITextFieldDelegate>

@property (strong, nonatomic) DCKeyboardResponder *kr;

@end

@implementation DCScrollViewDemoVC

#pragma mark - UITextFieldDelegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Private Methods
- (void)dismissKeyboard
{
    [self.view endEditing:YES];
}

#pragma mark - View Lifecycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"UIScrollView Demo";
    
    _kr = [[DCKeyboardResponder alloc] initWithDelegate:self];
    _kr.scrollView = _sv;
    
    UIControl *vContent = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 1000)];
    [vContent addTarget:self action:@selector(dismissKeyboard) forControlEvents:UIControlEventTouchUpInside];
    for (int i = 0; i < 1000/50; i++) {
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(32, i*50 +12, [[UIScreen mainScreen] bounds].size.width -64, 50 -20)];
        tf.backgroundColor = [UIColor lightGrayColor];
        tf.delegate = _kr;
        tf.placeholder = @"Type Here";
        tf.returnKeyType = UIReturnKeyDone;
        tf.tag = 1000;
        [vContent addSubview:tf];
    }
    [_sv addSubview:vContent];
    [_sv setContentSize:vContent.frame.size];
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
