//
//  AppDelegate.h
//  SlotMAchine
//
//  Created by RAVI DAS on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Test;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) Test *spinViewController;

@end

extern AppDelegate *DELEGATE;