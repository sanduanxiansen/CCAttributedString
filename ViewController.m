//
//  ViewController.m
//  CCAttributedString
//
//  Created by Daniujia on 2017/2/14.
//  Copyright © 2017年 CC. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableAttributedString+CCAttributedString.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"给一个类声明属性，其实本质就是给这个类添加关联，并不是直接把这个值的内存空间添加到类存空间。"];
    
    string.color([UIColor redColor]).font([UIFont systemFontOfSize:10]).rangeString(@[@"一个",@"属性"]).lineSpace(10).textSpace(5);
    
//    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor whiteColor];
//    view.frame = CGRectMake(0, 0, 200, 200);
//    [self.view addSubview:view];
//    
    
//    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
//    label.textColor = [UIColor blueColor];
//    label.attributedText = string;
//    
//    label.numberOfLines = 0;
//    [self.view addSubview:label];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 300)];
    textView.font = [UIFont systemFontOfSize:15];
    textView.attributedText = string;
    [self.view addSubview:textView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
