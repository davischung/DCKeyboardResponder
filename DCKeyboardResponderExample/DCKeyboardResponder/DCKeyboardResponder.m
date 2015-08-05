//
//  DCKeyboardResponder.m
//  DCKeyboardResponder
//
//  Created by Davis Chung on 5/8/15.
//  Copyright (c) 2015 Davis Chung. All rights reserved.
//

#import "DCKeyboardResponder.h"

@implementation DCKeyboardResponder

#define BottomPadding       8
#define AnimationDuration   0.3
#define ScrollBackRange     40

#pragma mark - UITextFieldDelegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    activeTextField = textField;
    activeTextView = nil;
    if ([_delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [_delegate textFieldDidBeginEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    activeTextField = nil;
    if ([_delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [_delegate textFieldDidEndEditing:textField];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([_delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [_delegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([_delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [_delegate textFieldShouldEndEditing:textField];
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([_delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [_delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if ([_delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [_delegate textFieldShouldClear:textField];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([_delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [_delegate textFieldShouldReturn:textField];
    }
    return YES;
}

#pragma mark - UITextViewDelegate Methods
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([_delegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [_delegate textViewDidBeginEditing:textView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    activeTextView = nil;
    if ([_delegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [_delegate textViewDidEndEditing:textView];
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    activeTextField = nil;
    activeTextView = textView;
    if ([_delegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [_delegate textViewShouldBeginEditing:textView];
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([_delegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [_delegate textViewShouldEndEditing:textView];
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([_delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        return [_delegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView {
    if ([_delegate respondsToSelector:@selector(textViewDidChange:)]) {
        [_delegate textViewDidChange:textView];
    }
}
- (void)textViewDidChangeSelection:(UITextView *)textView {
    if ([_delegate respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        [_delegate textViewDidChangeSelection:textView];
    }
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange{
    if ([_delegate respondsToSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:)]) {
        return [_delegate textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([_delegate respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)]) {
        return [_delegate textView:textView shouldInteractWithURL:URL inRange:characterRange];
    }
    return YES;
}

#pragma mark - Keyboard Methods - Animation & Dismiss
- (void)keyboardWasShown:(NSNotification *)notification
{
    if (_scrollView) {
        CGFloat keyboardHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
        CGRect display = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, ([[UIScreen mainScreen] bounds].size.height-keyboardHeight));
        
        if (!setCurrentOffsetY)
            currentOffsetY = [_scrollView contentOffset].y;
        setCurrentOffsetY = YES;
        
        _scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, keyboardHeight, 0.0);
        _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardHeight, 0.0);
  
        CGPoint origin;
        CGPoint bottom;
        if (activeTextField && !activeTextView) {
            origin = [activeTextField.superview convertPoint:activeTextField.frame.origin toView:nil];
            bottom = CGPointMake(origin.x, origin.y +activeTextField.frame.size.height +BottomPadding);
        } else if (!activeTextField && activeTextView) {
            origin = [activeTextView.superview convertPoint:activeTextView.frame.origin toView:nil];
            bottom = CGPointMake(origin.x, origin.y +activeTextView.frame.size.height +BottomPadding);
        } else {
            NSLog(@"Error in setting \"activeTextField\" OR \"activeTextView\"");
            return;
        }
        if (!CGRectContainsPoint(display, bottom)) {
            float difference = bottom.y - ([[UIScreen mainScreen] bounds].size.height -keyboardHeight);
            [UIView animateWithDuration:AnimationDuration animations:^{
                [_scrollView setContentOffset:CGPointMake(0, currentOffsetY + difference)];
            } completion:^(BOOL finished) {
                expectedOffsetY = _scrollView.contentOffset.y;
            }];
        }
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    if (_scrollView) {
        NSLog(@"SavedOffsetY: %.01f", currentOffsetY);
        NSLog(@"CurrentOffsetY: %.01f", _scrollView.contentOffset.y);
        
        if (fabs(expectedOffsetY -_scrollView.contentOffset.y) < ScrollBackRange) {
            [UIView animateWithDuration:AnimationDuration animations:^ {
                [_scrollView setContentOffset:CGPointMake(0, currentOffsetY)];
            }completion:^(BOOL finished) {
                _scrollView.contentInset = UIEdgeInsetsZero;
                _scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
            }];
        }
        _scrollView.contentInset = UIEdgeInsetsZero;
        _scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
        setCurrentOffsetY = NO;
    }
}

#pragma mark - Initialization
- (id)initWithDelegate:(id)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWasShown:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
