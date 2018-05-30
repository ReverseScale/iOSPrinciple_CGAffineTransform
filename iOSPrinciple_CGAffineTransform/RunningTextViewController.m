//
//  RunningTextViewController.m
//  iOSPrinciple_CGAffineTransform
//
//  Created by WhatsXie on 2018/5/30.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

#import "RunningTextViewController.h"

@interface RunningTextViewController (){
    UILabel *label1;
    UILabel *label2;
    CGSize size;
}

@end

@implementation RunningTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.clipsToBounds = YES;
    [self runningText];
}

- (void)runningText {
    NSString *text = @"😀😁😂😃😄😅😆😉😊😋😎😍😘😗😙😚☺😇😐😑😶😏😣😥😮😯😪😫😴😌😛😜😝😒😓😔😕😲😷😖😞😟😤😢😭😦😧😨😬😰😱😳😵😡😠";
    
    NSInteger screenWidth = [UIScreen mainScreen].bounds.size.width;
    NSInteger screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    NSInteger viewH = 60;
    NSInteger viewW = screenWidth;
    NSInteger viewY = (screenHeight - viewH) * 0.5;
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.frame = CGRectMake(0, viewY, viewW, viewH);
    [self.view addSubview:bgView];
    
    NSDictionary *att = @{NSFontAttributeName : [UIFont systemFontOfSize:18]};
    size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 40) options:NSStringDrawingUsesFontLeading attributes:att context:nil].size;
    
    label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(0, 10, size.width, 40);
    label1.text = text;
    label1.textColor = [UIColor whiteColor];
    [label1 setFont:[UIFont systemFontOfSize:18]];
    [bgView addSubview:label1];
    
    label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(size.width + 50, 10, size.width, 40);
    label2.text = text;
    label2.textColor = [UIColor whiteColor];
    [label2 setFont:[UIFont systemFontOfSize:18]];
    [bgView addSubview:label2];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(labelMove)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)labelMove {
    CGAffineTransform transform1 = label1.transform;
    if (fabs(transform1.tx) >= size.width) {
        transform1 = CGAffineTransformIdentity;
    }
    label1.transform = CGAffineTransformTranslate(transform1, -1, 0);
    
    CGAffineTransform transform2 = label2.transform;
    if (fabs(transform2.tx) >= size.width + 60) {
        transform2 = CGAffineTransformIdentity;
    }
    label2.transform = CGAffineTransformTranslate(transform2, -1, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
