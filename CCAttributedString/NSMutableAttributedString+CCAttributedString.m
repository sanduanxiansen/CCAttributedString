//
//  NSMutableAttributedString+CCAttributedString.m
//  CCAttributedString
//
//  Created by Daniujia on 2017/2/14.
//  Copyright © 2017年 CC. All rights reserved.
//

#import "NSMutableAttributedString+CCAttributedString.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>

@interface NSMutableAttributedString ()

@property (nonatomic, strong) NSString *lastString;
@property (nonatomic, assign) NSRange lastRange;

@property (nonatomic, strong) UIColor *lastColor;
@property (nonatomic, strong) UIFont *lastFont;

@property (nonatomic, assign) BOOL isAddingInArray;

@end

static const char *lastStringKey = "lastString";
static const char *lastColorKey = "lastColor";
static const char *lastFontKey = "lastFont";
static const char *isAddingInArrayKey = "isAddingInArray";

@implementation NSMutableAttributedString (CCAttributedString)

#pragma mark - property

- (UIColor *)lastColor {
    return objc_getAssociatedObject(self, lastColorKey);
}

- (void)setLastColor:(UIColor *)lastColor {
    objc_setAssociatedObject(self, lastColorKey, lastColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIFont *)lastFont {
    return objc_getAssociatedObject(self, lastFontKey);
}

- (void)setLastFont:(UIFont *)lastFont {
    objc_setAssociatedObject(self, lastFontKey, lastFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isAddingInArray {
    return objc_getAssociatedObject(self, isAddingInArrayKey);
}

- (void)setIsAddingInArray:(BOOL)isAddingInArray {
    objc_setAssociatedObject(self, isAddingInArrayKey, @(isAddingInArray), OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - public

- (CCAttributedStringObjBlock)color {
    return ^ id (UIColor *color) {
        self.lastColor = color;
        return self;
    };
}

- (CCAttributedStringObjBlock)font {
    return ^ id (UIFont *font) {
        self.lastFont = font;
        return self;
    };
}

- (CCAttributedStringFolatBlock)lineSpace {
    return ^ id (CGFloat space) {
        [self addLineSpaceWithSpace:space];
        return self;
    };
}
- (CCAttributedStringFolatBlock)textSpace {
    return ^ id (CGFloat space) {
        [self addTextSpaceWithSpace:space];
        return self;
    };
}

- (CCAttributedStringObjBlock)rangeString {
    return ^ id (id rangeObj) {
        if ([rangeObj isKindOfClass:[NSString class]]) {
            [self addTextColorWithObj:rangeObj];
            [self addTextFontWithObj:rangeObj];
        } else if ([rangeObj isKindOfClass:[NSArray class]]) {
            for (id obj in rangeObj) {
                if ([obj isKindOfClass:[NSString class]]) {
                    self.isAddingInArray = YES;
                    [self addTextColorWithObj:obj];
                    [self addTextFontWithObj:obj];
                }
            }
            self.isAddingInArray = NO;
        }
        return self;
    };
}

- (CCAttributedStringRangeBlock)range {
    return ^ id (NSRange range) {
        [self addTextColorWithRange:range];
        [self addTextFontWithRange:range];
        return self;
    };
}


#pragma mark - private

- (void)removeAllAttribute {
    self.lastColor = nil;
}

- (NSRange)getRangeWithObj:(NSString *)targetString {
    return [[self string] rangeOfString:targetString options:NSBackwardsSearch];
}

- (void)addTextColorWithRange:(NSRange)range {
    if (!self.lastColor) return;
    [self addAttribute:NSForegroundColorAttributeName value:self.lastColor range:range];
    if (!self.isAddingInArray) self.lastColor = nil;
}

- (void)addTextColorWithObj:(NSString *)targetString {
    if (!self.lastColor) return;
    [self addTextColorWithRange:[self getRangeWithObj:targetString]];
}

- (void)addTextFontWithRange:(NSRange)range {
    if (!self.lastFont) return;
    [self addAttribute:NSFontAttributeName value:self.lastFont range:range];
    if (!self.isAddingInArray) self.lastFont = nil;
}

- (void)addTextFontWithObj:(NSString *)targetString {
    if (!self.lastFont) return;
    [self addTextFontWithRange:[self getRangeWithObj:targetString]];
}

- (void)addLineSpaceWithSpace:(CGFloat)space {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:[self getRangeWithObj:[self string]]];
}

- (void)addTextSpaceWithSpace:(CGFloat)space {
    long number = space;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [self addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:[self getRangeWithObj:[self string]]];
    CFRelease(num);
}

@end
