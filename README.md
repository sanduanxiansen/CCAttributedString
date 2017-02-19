# CCAttributedString
#CCAttributedString
CCAttributedString是整理NSMutableAttributedString中AttributedName属性封装好的一个分类，通过链式编程，可以轻松完成对富文本的编辑。效果如下。
###代码：
```
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"通过NSRange添加效果\n给第三个123123123加特效\n给所有的123123123加特效\n拉开距离\n扁平\n脉动不回来了\n一条线两条线删除线\n空心 实心\nfl是连在一起的\n听说代写多了，眼睛会花\n凸版印刷效果\n正常状态和设置偏移量后\n让我打一套组合拳\n这句话是反的\n最后我选择滑稽"];
    
    string.textColor([UIColor redColor]).font([UIFont systemFontOfSize:30]).range(NSMakeRange(2, 7));
    
    string.textColor([UIColor redColor]).font([UIFont systemFontOfSize:10]).backgroundColor([UIColor darkGrayColor]).rangeIndex(2).rangeString(@[@"3",@"1"]);
    string.textColor([UIColor blackColor]).font([UIFont boldSystemFontOfSize:30]).all().rangeString(@"2");
    string.textSpace(10).rangeString(@"拉开距离");
    string.textColor([UIColor blackColor]).font([UIFont systemFontOfSize:30]).backgroundColor([UIColor cyanColor]).rangeString(@"本质");
    string.obliqueness(YES).textColor([UIColor orangeColor]).rangeString(@"脉动不回来了");
    string.expansion(YES).textColor([UIColor purpleColor]).rangeString(@"扁平");
    string.underline(YES).underlineColor([UIColor orangeColor]).rangeString(@"一条线");
    string.underline(NSUnderlineStyleDouble).underlineColor([UIColor blueColor]).rangeString(@"两条线");
    string.strikethrough(YES).strikethroughColor([UIColor redColor]).rangeString(@"删除线");
    string.strokeWidth(5).strokeColor([UIColor brownColor]).font([UIFont systemFontOfSize:30]).rangeString(@"空心");
    string.strokeWidth(-5).strokeColor([UIColor brownColor]).font([UIFont systemFontOfSize:30]).rangeString(@"实心");
    string.ligature(YES).font([UIFont fontWithName: @"futura" size: 30]).textColor([UIColor redColor]).rangeIndex(0).rangeString(@"fl");
    string.effectLetterpressStyle(YES).rangeString(@"凸版印刷效果");
    string.textColor([UIColor darkGrayColor]).font([UIFont systemFontOfSize:8]).baselineOffset(10).rangeString(@"设置偏移量后");
    string.textColor([UIColor grayColor]).backgroundColor([UIColor orangeColor]).textSpace(10).obliqueness(YES).expansion(YES).underline(YES).underlineColor([UIColor blueColor]).strikethrough(YES).rangeString(@"让我打一套组合拳");
    string.writingDirection(@[@(NSWritingDirectionRightToLeft | NSTextWritingDirectionOverride)]).rangeString(@"这句话是反的");
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"huaji"];
    attachment.bounds = CGRectMake(0, -4, 20, 20);
    string.attachment(attachment,string.length);
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor darkGrayColor];
    shadow.shadowOffset = CGSizeMake(2, 2);
    string.shadow(shadow).rangeString(@"听说代写多了，眼睛会花");
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*4/5)];
    label.textColor = [UIColor blueColor];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    label.attributedText = string;
    
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*4/5, self.view.frame.size.width, self.view.frame.size.height/5)];
    textView.delegate = self;
    textView.editable = NO;
    [self.view addSubview:textView];
    NSMutableAttributedString *linkString = [[NSMutableAttributedString alloc] initWithString:@"textview\n这是一条链接"];
    linkString.link([NSURL URLWithString:@"https://www.baidu.com"]).textColor([UIColor orangeColor]).font([UIFont systemFontOfSize:20]).underline(YES).rangeString(@"链接");
    textView.attributedText = linkString;

}
```
###效果：

![效果图](https://ofc13b4jy.bkt.clouddn.com/Simulator%20Screen%20Shot%202017%E5%B9%B42%E6%9C%8817%E6%97%A5%20%E4%B8%8B%E5%8D%885.58.58.png)
属性一览：
```
@interface NSMutableAttributedString (CCAttributedString)

- (NSMutableAttributedString *(^)(UIColor *))textColor;//字体颜色
- (NSMutableAttributedString *(^)(UIColor *))backgroundColor;//背景颜色
- (NSMutableAttributedString *(^)(UIFont *))font;//字号
- (NSMutableAttributedString *(^)(NSUnderlineStyle))underline;//下划线
- (NSMutableAttributedString *(^)(UIColor *))underlineColor;//下划线颜色
- (NSMutableAttributedString *(^)(UIColor *))strokeColor;//描边
- (NSMutableAttributedString *(^)(CGFloat))strokeWidth;//描边宽度
- (NSMutableAttributedString *(^)(BOOL))obliqueness;//斜体
- (NSMutableAttributedString *(^)(BOOL))expansion;//扁平体
- (NSMutableAttributedString *(^)(BOOL))strikethrough;//删除线
- (NSMutableAttributedString *(^)(UIColor *))strikethroughColor;//删除线颜色
- (NSMutableAttributedString *(^)(BOOL))ligature;//连体
- (NSMutableAttributedString *(^)(NSShadow *))shadow;//字体阴影
- (NSMutableAttributedString *(^)(BOOL))effectLetterpressStyle;//凸版印刷体
- (NSMutableAttributedString *(^)(CGFloat))baselineOffset;//字体偏移
- (NSMutableAttributedString *(^)(NSURL *))link;//URL链接
- (NSMutableAttributedString *(^)(id))writingDirection;//书写方向
- (NSMutableAttributedString *(^)(CGFloat))lineSpace;//行间距
- (NSMutableAttributedString *(^)(CGFloat))textSpace;//字间距
- (NSMutableAttributedString *(^)(NSTextAttachment *,NSInteger))attachment;//插入图片
- (NSMutableAttributedString *(^)(id))rangeString;//根据一串或一组字符串添加效果
- (NSMutableAttributedString *(^)(NSRange))range;//根据range添加效果
- (NSMutableAttributedString *(^)())all;//匹配所有的rangeString,添加效果
- (NSMutableAttributedString *(^)(NSInteger))rangeIndex;//给第几个rangeString添加效果

@end
```
