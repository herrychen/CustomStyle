//
//  MoveButtonView.h
//  CustomStyle
//
//  Created by  陈文娟 on 14-3-30.
//  Copyright (c) 2014年 heinqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoveButtonView : UIButton
{
    CGPoint beginPoint;
}
@property (nonatomic) BOOL dragEnable;
@end
