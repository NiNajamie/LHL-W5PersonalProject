//
//  UIImage+Resize.h
//  LHL-W5PersonalProject
//
//  Created by Asuka Nakagawa on 2016-06-02.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import <UIKit/UIKit.h>

// Add category that holds methods for resizeing
@interface UIImage (Resize)

- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality;

@end
