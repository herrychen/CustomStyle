//
//  RemoteModelViewController.m
//  CustomStyle
//
//  Created by  陈文娟 on 14-4-7.
//  Copyright (c) 2014年 heinqi. All rights reserved.
//

#import "RemoteModelViewController.h"
#import "UIDragButton.h"

@interface RemoteModelViewController ()<UIDragButtonDelegate>
{
    NSMutableArray *imgViewArray;
    NSMutableArray *imgArray;
    NSMutableArray *frameArray;
    
    
    CGRect sreenRect;
    
    int paddingTohSreen ; // 距离屏幕左右的距离
    int paddng ; //图片之间的距离
    int columncount ; // 显示几列
    int imgwidth ;
    int imgheight ;
    int paddingTovScreen ; //距离屏幕上下的距离
    
    int row;
    int column;
    
    int totalHeight ;
    
    int originIndex;
    int shakeIndex;
    
    BOOL isExchange; // 是否两个控件有交集
}
@property(nonatomic,strong) UIScrollView *modelScrollView;
@end

@implementation RemoteModelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    imgArray = [[NSMutableArray alloc] init];
    imgViewArray = [[NSMutableArray alloc] init];
    frameArray = [[NSMutableArray alloc] init];
    isExchange = NO;
    for (int i=1; i<11; i++) {
        NSString *imgname = [NSString stringWithFormat:@"%d",i];
        [imgArray addObject:[UIImage imageNamed:imgname]];
    }
    
    sreenRect = [[UIScreen mainScreen] applicationFrame];
    
    self.modelScrollView = [[UIScrollView alloc] initWithFrame:sreenRect];
    self.modelScrollView.scrollEnabled = YES;
    [self.view addSubview:self.modelScrollView];
    
    [self initFrameandView];
    
}


-(void)initFrameandView
{
    
    paddingTohSreen = 10; // 距离屏幕左右的距离
    paddng = 10; //图片之间的距离
    columncount = 4; // 显示几列
    imgwidth = (sreenRect.size.width - paddingTohSreen*2 - paddng*(columncount-1))/4;
    imgheight = imgwidth;
    paddingTovScreen = 20; //距离屏幕上下的距离
    
    row =0;
    column =-1;
    
    totalHeight = 0;
    
    for (int i=0; i<30; i++) {
        
        column ++;
        if (i!=0 && i%columncount==0) { // 每四列换行
            row++;
            column = 0;
        }
        
        CGRect imgRect = CGRectMake(paddingTohSreen + column * (paddng+imgwidth), 44+paddingTovScreen + (paddng+imgheight)*row, imgwidth, imgheight);
        
        UIDragButton *imgView;
        if (i<imgArray.count) {
            imgView = [[UIDragButton alloc] initWithFrame:imgRect andImage:[imgArray objectAtIndex:i] inView:self.modelScrollView];
        }
        else
        {
            imgView = [[UIDragButton alloc] initWithFrame:imgRect andImage:[UIImage imageNamed:@"icon1.jpg"] inView:self.modelScrollView];
        }
        
        imgView.tag = i;
        [imgView setLocation:up];
        [imgView setDelegate:self];
        [frameArray addObject:[NSValue valueWithCGRect:imgRect]];
        
        totalHeight = 44+paddingTovScreen + (paddng+imgheight)*row;

        [imgViewArray addObject:imgView];
        
        [self.modelScrollView addSubview:imgView];
    }

    self.modelScrollView.contentSize = CGSizeMake(sreenRect.size.width, totalHeight+imgheight);
    // 以上 定义了 每个frame的位置
   
}


#pragma mark - 设置按钮的frame

- (void)checkLocationOfOthersWithButton:(UIDragButton *)shakingButton
{
    switch (shakingButton.location) {
        case up:
        {
            int indexOfShakingButton = 0;
            for ( int i = 0; i < [imgViewArray count]; i++) {
                if (((UIDragButton *)[imgViewArray objectAtIndex:i]).tag == shakingButton.tag) {
                    indexOfShakingButton = i;
                    break;
                }
            }
            for (int i = 0; i < [imgViewArray count]; i++) {
                UIDragButton *button = (UIDragButton *)[imgViewArray objectAtIndex:i];
                if (button.tag != shakingButton.tag){
                    if (CGRectIntersectsRect(shakingButton.frame, button.frame)) {// 检测这两个按钮是否有交集
                        
                        originIndex = button.tag;
                        shakeIndex = shakingButton.tag;
                        isExchange = YES;
                        break;
                    }
                }
            }
            
            break;
        }
        default:
            break;
    }
}

#pragma mark-delegate
-(void)exchangeLocationofButton
{
    if (isExchange) {
        UIDragButton *originBtn = [imgViewArray objectAtIndex:originIndex];
        UIDragButton *shakeBtn = [imgViewArray objectAtIndex:shakeIndex];
        
        CGRect shakeframe = [[frameArray objectAtIndex:shakeIndex] CGRectValue];
        CGRect originframe = [[frameArray objectAtIndex:originIndex] CGRectValue];
        
        shakeBtn.frame = originframe;
        originBtn.frame = shakeframe;
        shakeBtn.tag = originIndex;
        originBtn.tag = shakeIndex;
        [imgViewArray exchangeObjectAtIndex:originIndex withObjectAtIndex:shakeIndex];
        
        isExchange = NO;
    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
