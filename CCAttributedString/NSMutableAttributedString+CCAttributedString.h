//
//  NSMutableAttributedString+CCAttributedString.h
//  CCAttributedString
//
//  Created by Daniujia on 2017/2/14.
//  Copyright © 2017年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NSMutableAttributedString * (^CCAttributedStringVoidBlock)();
typedef NSMutableAttributedString * (^CCAttributedStringObjBlock)(id);
typedef NSMutableAttributedString * (^CCAttributedStringRangeBlock)(NSRange);
typedef NSMutableAttributedString * (^CCAttributedStringFolatBlock)(CGFloat);

@interface NSMutableAttributedString (CCAttributedString)

- (NSMutableAttributedString *(^)(UIColor *))textColor;
- (NSMutableAttributedString *(^)(UIColor *))backgroundColor;
- (NSMutableAttributedString *(^)(UIFont *))font;
- (NSMutableAttributedString *(^)(BOOL))obliqueness;
- (NSMutableAttributedString *(^)(BOOL))expansion;
- (NSMutableAttributedString *(^)(BOOL))underline;
- (NSMutableAttributedString *(^)(UIColor *))underlineColor;
- (NSMutableAttributedString *(^)(UIColor *))strokeColor;
- (NSMutableAttributedString *(^)(CGFloat))strokeWidth;
- (NSMutableAttributedString *(^)(BOOL))strikethrough;
- (NSMutableAttributedString *(^)(UIColor *))strikethroughColor;
- (CCAttributedStringObjBlock)rangeString;
- (CCAttributedStringRangeBlock)range;
- (CCAttributedStringFolatBlock)lineSpace;
- (NSMutableAttributedString *(^)(CGFloat))textSpace;
- (NSMutableAttributedString *(^)(NSTextAttachment *,NSInteger))attachment;

- (NSMutableAttributedString *(^)())all;
- (NSMutableAttributedString *(^)(NSInteger))rangeIndex;


- (NSArray *)rangeOfSubString:(NSString *)subString;

@end
