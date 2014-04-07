//
//  MoveButtonView.m
//  CustomStyle
//
//  Created by  陈文娟 on 14-3-30.
//  Copyright (c) 2014年 heinqi. All rights reserved.
//

#import "MoveButtonView.h"



@implementation MoveButtonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_dragEnable) {
        return;
    }
    UITouch *touch = [touches anyObject];
    
    beginPoint = [touch locationInView:self];
    
}

//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    if (!_dragEnable) {
//        return;
//    }
//    
//    CGRect screenframe = [[UIScreen mainScreen] applicationFrame];
//    UITouch *touch = [touches anyObject];
//    
//    CGPoint nowPoint = [touch locationInView:self];
//    float offsetX,offsetY;
//
//    offsetX = nowPoint.x - beginPoint.x;
//    
//    offsetY = nowPoint.y - beginPoint.y;
//    
//
//    float currentX = self.center.x + offsetX;
//    float currentY = self.center.y + offsetY;
//    
//    if (currentX<self.frame.size.width/2) {
//        currentX =self.frame.size.width/2;
//    }
//    else if (currentX > screenframe.size.width-(self.frame.size.width/2))
//    {
//        currentX = screenframe.size.width-(self.frame.size.width/2);
//    }
//    
//    if (currentY < screenframe.origin.y + 44 + self.frame.size.height/2) {
//        currentY = screenframe.origin.y + 44 + self.frame.size.height/2;
//    }
//    else if (currentY > screenframe.size.height - (self.frame.size.height)/2)
//    {
//        currentY = screenframe.size.height - (self.frame.size.height)/2;
//    }
//    
//    self.center = CGPointMake(currentX, currentY);
//}

@end
