//
//  TransformModeViewController.m
//  iOSPrinciple_CGAffineTransform
//
//  Created by WhatsXie on 2018/5/30.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

#import "TransformModeViewController.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface TransformModeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *textModeLabel;
@property (assign, nonatomic) int indexType;
@end

@implementation TransformModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.indexType = 0;
}

- (IBAction)actionTransform:(id)sender {
    [self changeTransform:_indexType];
    self.indexType ++;
}

- (void)changeTransform:(NSInteger)type {
    CGFloat time = 0.5;
    WS(ws);

    [UIView animateWithDuration:time animations:^{
        CGAffineTransform transform;
        switch (type) {
            case 0:{
                transform = CGAffineTransformMakeTranslation(-100, 150);
                ws.textModeLabel.text = @"移动";
            }
                break;
            case 1: {
                transform = CGAffineTransformMakeScale(2, 2);
                ws.textModeLabel.text = @"缩放";
            }
                break;
            case 2: {
                transform = CGAffineTransformMakeRotation(M_PI);
                ws.textModeLabel.text = @"旋转";
            }
                break;
            case 3: {
                transform = CGAffineTransformMakeScale(3, 3);
                transform = CGAffineTransformInvert(transform);
                //  transform = CGAffineTransformMakeTranslation(-100, 150);
                //  transform = CGAffineTransformInvert(transform);
                ws.textModeLabel.text = @"相反动画 缩小至1/3";
            }
                break;
            case 4: {
                CGAffineTransform transform_A = CGAffineTransformMakeTranslation(0, 200);
                CGAffineTransform transform_B = CGAffineTransformMakeScale(0.2, 0.2);
                transform = CGAffineTransformConcat(transform_B, transform_A);
                ws.textModeLabel.text = @"从移动到缩放";
            }
                break;
            case 5: {
                transform = CGAffineTransformMakeRotation(M_PI);                //旋转
                transform = CGAffineTransformTranslate(transform, -50, 150);    //加移动
                transform = CGAffineTransformScale(transform, 2, 2);            //加缩放
                ws.textModeLabel.text = @"旋转->移动->缩放";
                ws.indexType = -1;
            }
                break;
            default:
                break;
        }
        ws.imageView.transform = transform;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:time animations:^{
            ws.imageView.transform =  CGAffineTransformIdentity;              //回到最初
        } completion:^(BOOL finished) {
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
