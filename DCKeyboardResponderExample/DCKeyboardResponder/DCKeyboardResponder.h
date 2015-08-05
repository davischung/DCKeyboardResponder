//
//  DCKeyboardResponder.h
//  DCKeyboardResponder
//
//  Created by Davis Chung on 5/8/15.
//  Copyright (c) 2015 Davis Chung. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DCKeyboardResponderDelegate;

@interface DCKeyboardResponder : NSObject <UIScrollViewDelegate, UITextFieldDelegate, UITextViewDelegate>
{
    @private
    BOOL setCurrentOffsetY;
    CGFloat currentOffsetY;
    CGFloat expectedOffsetY;
    UITextField *activeTextField;
    UITextView *activeTextView;
}

@property (weak, nonatomic) id<DCKeyboardResponderDelegate>delegate;
@property (weak, nonatomic) UIScrollView *scrollView;

- (id)initWithDelegate:(id)delegate;

@end

@protocol DCKeyboardResponderDelegate <NSObject>
@optional
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (BOOL)textFieldShouldClear:(UITextField *)textField;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

- (void)textViewDidBeginEditing:(UITextView *)textView;
- (void)textViewDidEndEditing:(UITextView *)textView;
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
- (BOOL)textViewShouldEndEditing:(UITextView *)textView;
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)textViewDidChange:(UITextView *)textView;
- (void)textViewDidChangeSelection:(UITextView *)textView;
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange;
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange;

@end
