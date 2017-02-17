//
//  ViewController.m
//  CCAttributedString
//
//  Created by CC on 2017/2/14.
//  Copyright © 2017年 CC. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableAttributedString+CCAttributedString.h"

@interface ViewController ()<UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"给一个一个一个一个一个一个一个一个类声明属性，其实本质就是给这个类添加关联，并不是直接把这个值的内存空间添加到类存空间。fl是连在一起的\n听说代写多了，眼睛会花\n凸版印刷效果\n正常状态和设置偏移量后\n这句话是反的"];
    
    string.textColor([UIColor redColor]).font([UIFont systemFontOfSize:10]).backgroundColor([UIColor greenColor]).all().rangeString(@[@"一",@"属性"]);
    string.textSpace(10).range(NSMakeRange(0, 10));
    string.textColor([UIColor blackColor]).font([UIFont systemFontOfSize:30]).backgroundColor([UIColor cyanColor]).rangeString(@"本质");
    string.obliqueness(YES).backgroundColor([UIColor orangeColor]).rangeString(@"关联");
    string.expansion(YES).textColor([UIColor purpleColor]).rangeString(@"直接");
    string.underline(YES).underlineColor([UIColor orangeColor]).rangeString(@"一个");
    string.strokeWidth(-5).strokeColor([UIColor brownColor]).rangeString(@"其实本质就是");
    string.ligature(YES).font([UIFont fontWithName: @"futura" size: 30]).textColor([UIColor redColor]).rangeIndex(0).rangeString(@"fl");
    string.effectLetterpressStyle(YES).rangeString(@"凸版印刷效果");
    string.textColor([UIColor darkGrayColor]).font([UIFont systemFontOfSize:8]).baselineOffset(10).rangeString(@"设置偏移量后");
    string.writingDirection(@[@(NSWritingDirectionRightToLeft | NSTextWritingDirectionOverride)]).rangeString(@"这句话是反的");
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"knowledge"];
    attachment.bounds = CGRectMake(0, 0, 20, 20);
    string.attachment(attachment,0);
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor darkGrayColor];
    shadow.shadowOffset = CGSizeMake(2, 2);
    string.shadow(shadow).rangeString(@"听说代写多了，眼睛会花");
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2)];
    label.textColor = [UIColor blueColor];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    label.attributedText = string;
    
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.height/2)];
    textView.delegate = self;
    textView.editable = NO;
    [self.view addSubview:textView];
    NSMutableAttributedString *linkString = [[NSMutableAttributedString alloc] initWithString:@"textview\n这是一条链接"];
    linkString.link([NSURL URLWithString:@"https://www.baidu.com"]).textColor([UIColor orangeColor]).font([UIFont systemFontOfSize:20]).underline(YES).rangeString(@"链接");
    textView.attributedText = linkString;

}


- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    NSLog(@"%@",URL);
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
