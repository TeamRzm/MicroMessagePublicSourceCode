//
//  MMShakeViewController.m
//  MicroMessage
//
//  Created by jason on 15/5/2.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMShakeViewController.h"

@interface MMShakeViewController ()
{
    UIImageView *shakeimage;
     SystemSoundID soundID;
    
}
@end

@implementation MMShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"摇一摇"];
    [self.view setBackgroundColor:[UIColor blackColor]];
    shakeimage = [[UIImageView alloc] initWithFrame:CGRectMake(kMM_SCREEN_W/2-117/2, (kMM_SCREEN_H-64)/2-119/2, 117.0f  , 119.0f)];
    [shakeimage setUserInteractionEnabled:YES];
    [shakeimage setImage:[UIImage imageNamed:@"ico_shake@2x"]];
    [self.view addSubview:shakeimage];
    
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setScrollEnabled:NO];
    
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GotoShake)];
    [shakeimage addGestureRecognizer:tapgesture];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shake" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
}

-(void) GotoShake
{
    [self addAnimations];
    AudioServicesPlaySystemSound (soundID);
}

-(void)addAnimations
{
    CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"transform"];
    translation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    translation.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(-M_PI_4, 0, 0, 100)];
    
    
    
    translation.duration = 0.2;
    translation.repeatCount = 2;
    translation.autoreverses = YES;
    
    [shakeimage.layer addAnimation:translation forKey:@"translation"];
    
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    
    if(motion==UIEventSubtypeMotionShake)
    {
        [self addAnimations];
        AudioServicesPlaySystemSound (soundID);
        
    }
    
}




-(BOOL)canBecomeFirstResponder{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
