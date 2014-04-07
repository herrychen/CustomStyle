//
//  ChangLocationViewController.m
//  CustomStyle
//
//  Created by  陈文娟 on 14-4-7.
//  Copyright (c) 2014年 heinqi. All rights reserved.
//

#import "ChangLocationViewController.h"

@interface ChangLocationViewController ()
{
    UIButton *btn1;
    UIButton *btn2;
    UIButton *changeBtn;
}
@end

@implementation ChangLocationViewController

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
    btn1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 100, 100)];
    btn1.backgroundColor = [UIColor redColor];
    
    btn2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 200, 100, 100)];
    btn2.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    
    changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 350, 200, 50)];
    [changeBtn setTitle:@"change" forState:UIControlStateNormal];
    changeBtn.backgroundColor = [UIColor yellowColor];
    [changeBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];
}

-(void)changeAction:(id)sender
{
    CGRect btn1frame = btn1.frame;
    CGRect btn2frame = btn2.frame;
    
    btn2.frame = btn1frame;
    btn1.frame = btn2frame;
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
