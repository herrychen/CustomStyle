//
//  UIDragButton.h
//  Draging
//
//  Created by makai on 13-1-8.
//  Copyright (c) 2013年 makai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum{
    up = 0,
    down = 1,
}Location;

@class UIDragButton;

@protocol UIDragButtonDelegate <NSObject>

- (void)arrangeUpButtonsWithButton:(UIDragButton *)button andAdd:(BOOL)_bool;
- (void)arrangeDownButtonsWithButton:(UIDragButton *)button andAdd:(BOOL)_bool;
- (void)setDownButtonsFrameWithAnimate:(BOOL)_bool withoutShakingButton:(UIDragButton *)shakingButton;
- (void)checkLocationOfOthersWithButton:(UIDragButton *)shakingButton;
- (void)removeShakingButton:(UIDragButton *)button fromUpButtons:(BOOL)_bool;

-(void)exchangeLocationofButton;

@end

@interface UIDragButton : UIButton
{
    UIView *superView;
    CGPoint lastPoint;
    NSTimer *timer;
}

@property (nonatomic, assign) Location location;
@property (nonatomic, assign) CGPoint lastCenter;
@property (nonatomic, assign) id<UIDragButtonDelegate> delegate;

- (id)initWithFrame:(CGRect)frame andImage:(UIImage *)image inView:(UIView *)view;
- (void)startShake;
- (void)stopShake;

@end
