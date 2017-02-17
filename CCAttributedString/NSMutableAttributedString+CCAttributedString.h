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

- (NSMutableAttributedString *(^)(UIColor *))textColor;
- (NSMutableAttributedString *(^)(UIColor *))backgroundColor;
- (NSMutableAttributedString *(^)(UIFont *))font;
- (NSMutableAttributedString *(^)(NSUnderlineStyle))underline;
- (NSMutableAttributedString *(^)(UIColor *))underlineColor;
- (NSMutableAttributedString *(^)(UIColor *))strokeColor;
- (NSMutableAttributedString *(^)(CGFloat))strokeWidth;
- (NSMutableAttributedString *(^)(BOOL))obliqueness;
- (NSMutableAttributedString *(^)(BOOL))expansion;
- (NSMutableAttributedString *(^)(BOOL))strikethrough;
- (NSMutableAttributedString *(^)(UIColor *))strikethroughColor;
- (NSMutableAttributedString *(^)(BOOL))ligature;
- (NSMutableAttributedString *(^)(NSShadow *))shadow;
- (NSMutableAttributedString *(^)(BOOL))effectLetterpressStyle;
- (NSMutableAttributedString *(^)(CGFloat))baselineOffset;
- (NSMutableAttributedString *(^)(NSURL *))link;
- (NSMutableAttributedString *(^)(id))writingDirection;
- (NSMutableAttributedString *(^)(id))rangeString;
- (NSMutableAttributedString *(^)(NSRange))range;
- (NSMutableAttributedString *(^)(CGFloat))lineSpace;
- (NSMutableAttributedString *(^)(CGFloat))textSpace;
- (NSMutableAttributedString *(^)(NSTextAttachment *,NSInteger))attachment;
- (NSMutableAttributedString *(^)())all;
- (NSMutableAttributedString *(^)(NSInteger))rangeIndex;

@end
