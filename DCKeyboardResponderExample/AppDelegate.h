//
//  AppDelegate.h
//  DCKeyboardResponderExample
//
//  Created by Davis Chung on 5/8/15.
//  Copyright (c) 2015 Davis Chung. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCTypeListVC;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navTypeList;
@property (strong, nonatomic) DCTypeListVC *typeListVC;


@end

