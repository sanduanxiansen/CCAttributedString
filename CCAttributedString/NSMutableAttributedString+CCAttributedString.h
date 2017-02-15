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

- (CCAttributedStringObjBlock)color;
- (CCAttributedStringObjBlock)font;
- (CCAttributedStringObjBlock)rangeString;
- (CCAttributedStringRangeBlock)range;
- (CCAttributedStringFolatBlock)lineSpace;
- (CCAttributedStringFolatBlock)textSpace;

@end
