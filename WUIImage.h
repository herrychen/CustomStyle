//
//  UIImage-Handling.h
//  WinAdDemo
//
//  Created by frank on 11-5-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface WUIImage:UIView
+(NSDictionary*)SeparateImage:(UIImage*)image ByX:(int)x andY:(int)y cacheQuality:(float)quality;
@end
