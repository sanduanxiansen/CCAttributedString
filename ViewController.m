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
    
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"给一个一个一个一个一个一个一个一个类声明属性，其实本质就是给这个类添加关联，并不是直接把这个值的内存空间添加到类存空间。"];
    
    string.textColor([UIColor redColor]).font([UIFont systemFontOfSize:10]).backgroundColor([UIColor greenColor]).all().rangeString(@[@"一",@"属性"]);
    string.textSpace(10).range(NSMakeRange(0, 10));
    string.textColor([UIColor blackColor]).font([UIFont systemFontOfSize:30]).backgroundColor([UIColor cyanColor]).rangeString(@"本质");
    string.obliqueness(YES).backgroundColor([UIColor orangeColor]).rangeString(@"关联");
    string.expansion(YES).textColor([UIColor purpleColor]).rangeString(@"直接");
    string.underline(YES).underlineColor([UIColor orangeColor]).rangeString(@"一个");
    
    string.strokeWidth(5).strokeColor([UIColor brownColor]).rangeString(@"其实本质就是");
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"knowledge"];
    attachment.bounds = CGRectMake(0, 0, 20, 20);
    string.attachment(attachment,0);
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
    label.textColor = [UIColor blueColor];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    label.attributedText = string;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
