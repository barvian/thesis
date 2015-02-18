//
//  UIAppearance+Swift.m
//  Thesis
//
//  Created by Maxwell Barvian on 2/9/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

@import UIKit;

@implementation UIView (UIViewAppearance_Swift)
+ (instancetype)bridge_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass {
	return [self appearanceWhenContainedIn:containerClass, nil];
}
@end