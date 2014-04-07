//
//  ViewController.m
//  CustomStyle
//
//  Created by  陈文娟 on 14-3-29.
//  Copyright (c) 2014年 heinqi. All rights reserved.
//

#import "ViewController.h"
#import "DoImagePickerController.h"
#import "AssetHelper.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "MoveButtonView.h"
#define MAX_PICCOUNT 9

#define ASSETHELPER    [AssetHelper sharedAssetHelper]

@interface ViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,DoImagePickerControllerDelegate>
{
    NSMutableArray *imageViewAry;
    NSMutableArray *imageAry;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    imageViewAry = [[NSMutableArray alloc] init];
    imageAry = [[NSMutableArray alloc] init];

    CGRect sreenRect = [[UIScreen mainScreen] applicationFrame];
    
    
    
    
    int paddingTohSreen = 20; // 距离屏幕左右的距离
    int paddng = 10; //图片之间的距离
    int columncount = 3; // 显示几列
    int rowcount = 3; // 显示几行
    int imgwidth = (sreenRect.size.width - paddingTohSreen*2 - paddng*(columncount-1))/rowcount;
    int imgheight = imgwidth +20;
    int paddingTovScreen = (sreenRect.size.height - imgheight *3 - paddng *(rowcount-1) )/2; //距离屏幕上下的距离
    
    int row =0;
    int column =-1;
    for (int i=0; i<9; i++) {
        
        column ++;
        if (i!=0 && i%3==0) { // 每三列换行
            row++;
            column = 0;
        }
        
        CGRect imgRect = CGRectMake(paddingTohSreen + column * (paddng+imgwidth), 44+paddingTovScreen + (paddng+imgheight)*row, imgwidth, imgheight);
        MoveButtonView *imgView = [[MoveButtonView alloc] initWithFrame:imgRect];
        imgView.tag = i;
        //button长按事件
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        [imgView addTarget:self action:@selector(handleUp:) forControlEvents:UIControlEventTouchUpOutside];
    
        // 旋转手势
        UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
        [imgView addGestureRecognizer:rotationGestureRecognizer];
        
        // 缩放手势
        UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
        [imgView addGestureRecognizer:pinchGestureRecognizer];
        
        // 移动手势
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
        [imgView addGestureRecognizer:panGestureRecognizer];
        
        longPress.minimumPressDuration = 0.8; //定义按的时间
        [imgView addGestureRecognizer:longPress];
        [imgView addGestureRecognizer:rotationGestureRecognizer];
//        imgView.dragEnable = YES;
        [imageViewAry addObject:imgView];
        
        
    }
    
    
    NSString*_imagePath=[NSHomeDirectory() stringByAppendingPathComponent:@"images/"];
    NSLog(@"_imagepath is %@",_imagePath);
    
    NSArray *fileList = [[NSArray alloc] init];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    //    以下这段代码则可以列出给定一个文件夹里的所有子文件夹名
    fileList = [fileManager contentsOfDirectoryAtPath:_imagePath error:&error];
    
    
    
    
    if (fileList.count>0) {
        int count = 0;
        for (NSString *filename in fileList){
            if ([[filename lastPathComponent] hasSuffix:@"png"]) {
                NSString *path = [[_imagePath stringByAppendingString:@"/"] stringByAppendingString:filename];
                
                UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:path];
                [imageAry addObject:imgFromUrl3];
                count ++;
            }
            
        }
        
        for (int i=0; i<MIN(MAX_PICCOUNT, count) ; i++) {
            MoveButtonView *imgview = [imageViewAry objectAtIndex:i];
            
            UIImage *img = [imageAry objectAtIndex:i];
            [imgview setBackgroundImage:img forState:UIControlStateNormal];
            
            [self.view addSubview:imgview];
        }
    }
    else
    {
        NSLog(@"no images");
    }

}
// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        NSLog(@"panGestureRecognizer...");
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}

// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
    }
}

// 处理旋转手势
- (void) rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    UIView *view = rotationGestureRecognizer.view;
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
}

-(IBAction)handleUp:(id)sender
{
    MoveButtonView *button=(MoveButtonView*)[(UILongPressGestureRecognizer *)sender view];
    button.layer.borderWidth = 0.0;
    
}
-(IBAction)handleLongPress:(id)sender{
    
    MoveButtonView *button=(MoveButtonView*)[(UILongPressGestureRecognizer *)sender view];
    button.layer.borderWidth = 1.0;
    button.layer.borderColor = [UIColor orangeColor].CGColor;
}

//-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognizer selIndex:(int)selIndex{
//    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
//      
//        if (selIndex == 2) {
//            NSLog(@"dd");
//        }
//        
//    }
//}


-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

-(void)readFiles:(NSString *)imagepath
{
    UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:imagepath];
    UIImageView* imageView3=[[UIImageView alloc]initWithImage:imgFromUrl3];
    imageView3.frame = CGRectMake(20, 40, 200, 100);
    [self.view addSubview:imageView3];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)customBgAction:(id)sender {
    
    UIActionSheet *sheetview = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相机中选择", nil];
    [sheetview showInView:self.view];
    
}

#pragma mark actionsheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {// 拍照
        [self openCamera];
    }
    if (buttonIndex == 1) {
        [self openPics];
    }
    
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    
}

// 打开摄像头
-(void)openCamera
{
    // UIImagePickerControllerCameraDeviceRear 后置摄像头
    // UIImagePickerControllerCameraDeviceFront 前置摄像头
    
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera) {
        return ;
        
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    [self  presentViewController:imagePicker animated:YES completion:^{
        
    }];
    
}



// 打开相册
- (void)openPics {
    DoImagePickerController *cont = [[DoImagePickerController alloc] initWithNibName:@"DoImagePickerController" bundle:nil];
    cont.delegate = self;
    cont.nResultType = DO_PICKER_RESULT_ASSET;
    cont.nMaxCount = 9;
    cont.nColumnCount = 3;
    
    [self presentViewController:cont animated:YES completion:nil];

}

#pragma mark - DoImagePickerControllerDelegate
- (void)didCancelDoImagePickerController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didSelectPhotosFromDoImagePickerController:(DoImagePickerController *)picker result:(NSArray *)aSelected
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (picker.nResultType == DO_PICKER_RESULT_UIIMAGE)
    {
        for (int i = 0; i < MIN(MAX_PICCOUNT, aSelected.count); i++)
        {
            UIImageView *iv = [imageViewAry objectAtIndex:i];
            iv.image = aSelected[i];
        }
    }
    else if (picker.nResultType == DO_PICKER_RESULT_ASSET)
    {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            for (int i=0; i<MIN(MAX_PICCOUNT, aSelected.count); i++) {
                UIImage *img = [ASSETHELPER getImageFromAsset:aSelected[i] type:ASSET_PHOTO_SCREEN_SIZE];
                NSString*_imageString=[NSString stringWithFormat:@"win_%d.png",i];
                NSString*_imagePath=[[NSHomeDirectory() stringByAppendingPathComponent:@"images/"] stringByAppendingPathComponent:_imageString];
                
                NSData* _imageData=UIImageJPEGRepresentation(img, 0.2);
                [_imageData writeToFile:_imagePath atomically:YES];
            }
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                for (int i = 0; i < MIN(MAX_PICCOUNT, aSelected.count); i++)
                {
                    UIImageView *iv = [imageViewAry objectAtIndex:i];
                    iv.image = [ASSETHELPER getImageFromAsset:aSelected[i] type:ASSET_PHOTO_SCREEN_SIZE];
                }
                
                [ASSETHELPER clearData];
            });  
        });
        
        
    }
}


#pragma mark uiimagepicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImageView  *imageView = (UIImageView *)[self.view viewWithTag:101];
    // UIImagePickerControllerOriginalImage 原始图片
    
    // UIImagePickerControllerEditedImage 编辑后图片
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    imageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
