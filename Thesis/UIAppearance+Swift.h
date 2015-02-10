//
//  UIAppearance+Swift.h
//  Thesis
//
//  Created by Maxwell Barvian on 2/9/15.
//  Copyright (c) 2015 Maxwell Barvian. All rights reserved.
//

#ifndef Thesis_UIAppearance_Swift_h
#define Thesis_UIAppearance_Swift_h

@interface UIView (UIViewAppearance_Swift)
// appearanceWhenContainedIn: is not available in Swift. This fixes that.
+ (instancetype)bridge_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass;
@end

#endif
