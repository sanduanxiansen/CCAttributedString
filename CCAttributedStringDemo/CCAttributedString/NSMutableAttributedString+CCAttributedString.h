//
//  NSMutableAttributedString+CCAttributedString.h
//  CCAttributedString
//
//  Created by CC on 2017/2/14.
//  Copyright © 2017年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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
