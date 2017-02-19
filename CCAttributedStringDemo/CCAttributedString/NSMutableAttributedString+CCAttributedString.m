//
//  NSMutableAttributedString+CCAttributedString.m
//  CCAttributedString
//
//  Created by CC on 2017/2/14.
//  Copyright © 2017年 CC. All rights reserved.
//

#import "NSMutableAttributedString+CCAttributedString.h"
#import <objc/runtime.h>
#import "CCAttributedStringBuilder.h"


@interface NSMutableAttributedString ()

@property (nonatomic, strong) CCAttributedStringBuilder *attributedBuilder;

@end

static const char *attributedBuilderKey = "attributedBuilder";

@implementation NSMutableAttributedString (CCAttributedString)

#pragma mark - initialize

- (instancetype)init {
    if (self = [super init]) {
        self.attributedBuilder = [[CCAttributedStringBuilder alloc] init];
    }
    return self;
}

#pragma mark - property

- (CCAttributedStringBuilder *)attributedBuilder {
    return objc_getAssociatedObject(self, attributedBuilderKey);
}

- (void)setAttributedBuilder:(CCAttributedStringBuilder *)attributedBuilder {
    objc_setAssociatedObject(self, attributedBuilderKey, attributedBuilder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - public

- (NSMutableAttributedString *(^)(UIColor *))textColor {
    return ^ id (UIColor *color) {
        self.attributedBuilder.currentTextColor = color;
        return self;
    };
}

- (NSMutableAttributedString *(^)(UIColor *))backgroundColor {
    return ^ id (UIColor *color) {
        self.attributedBuilder.currentBackgroundColor = color;
        return self;
    };
}

- (NSMutableAttributedString *(^)(UIFont *))font {
    return ^ id (UIFont *font) {
        self.attributedBuilder.currentFont = font;
        return self;
    };
}

- (NSMutableAttributedString *(^)(BOOL))obliqueness {
    return ^ id (BOOL obliqueness) {
        self.attributedBuilder.obliqueness = @(obliqueness);
        return self;
    };
}

- (NSMutableAttributedString *(^)(BOOL))expansion {
    return ^ id (BOOL expansion) {
        self.attributedBuilder.Expansion = @(expansion);
        return self;
    };
}

- (NSMutableAttributedString *(^)(NSUnderlineStyle))underline {
    return ^ id (NSUnderlineStyle underline) {
        self.attributedBuilder.underline = @(underline);
        return self;
    };
}

- (NSMutableAttributedString *(^)(UIColor *))underlineColor {
    return ^ id (UIColor *underlineColor) {
        self.attributedBuilder.underLineColor = underlineColor;
        return self;
    };
}

- (NSMutableAttributedString *(^)(UIColor *))strokeColor {
    return ^ id (UIColor *strokeColor) {
        self.attributedBuilder.strokeColor = strokeColor;
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))strokeWidth {
    return ^ id (CGFloat strokeWidth) {
        self.attributedBuilder.strokeWidth = @(strokeWidth);
        return self;
    };
}

- (NSMutableAttributedString *(^)(BOOL))strikethrough {
    return ^ id (BOOL strikethrough) {
        self.attributedBuilder.strikethrough = @(strikethrough);
        return self;
    };
}
- (NSMutableAttributedString *(^)(UIColor *))strikethroughColor {
    return ^ id (UIColor *strikethroughColor) {
        self.attributedBuilder.strikethroughColor = strikethroughColor;
        return self;
    };
}

- (NSMutableAttributedString *(^)(BOOL))ligature {
    return ^ id (BOOL ligature) {
        self.attributedBuilder.ligature = @(ligature);
        return self;
    };
}

- (NSMutableAttributedString *(^)(NSShadow *))shadow {
    return ^ id (NSShadow *shadow) {
        self.attributedBuilder.shadow = shadow;
        return self;
    };
}

- (NSMutableAttributedString *(^)(BOOL))effectLetterpressStyle {
    return ^ id (BOOL effectLetterpressStyle) {
        self.attributedBuilder.effectLetterpressStyle = @(effectLetterpressStyle);
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))baselineOffset {
    return ^ id (CGFloat baselineOffset) {
        self.attributedBuilder.baselineOffset = @(baselineOffset);
        return self;
    };
}

- (NSMutableAttributedString *(^)(id))writingDirection {
    return ^ id (id writingDirection) {
        self.attributedBuilder.writingDirection = writingDirection;
        return self;
    };
}

- (NSMutableAttributedString *(^)(NSURL *))link {
    return ^ id (NSURL *link) {
        self.attributedBuilder.link = link;
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))lineSpace {
    return ^ id (CGFloat space) {
        [self lineSpaceWithSpace:space];
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))textSpace {
    return ^ id (CGFloat space) {
        self.attributedBuilder.textSpace = @(space);
        return self;
    };
}

- (NSMutableAttributedString *(^)(id))rangeString {
    return ^ id (id rangeObj) {
        
        void(^addBlock)(NSString *) = ^ (NSString *targetString) {
            if (self.attributedBuilder.rangeIndex) {
                [self addAttributesAtRangeIndexWithObj:targetString];
            } else if (self.attributedBuilder.all && [self.attributedBuilder.all boolValue]) {
                [self addAttributesAllWithObj:targetString];
            } else {
                [self addAttributesWithObj:targetString];
            }
        };
        
        if ([rangeObj isKindOfClass:[NSString class]]) {
            addBlock(rangeObj);
        } else if ([rangeObj isKindOfClass:[NSArray class]]) {
            for (id obj in rangeObj) {
                if ([obj isKindOfClass:[NSString class]]) {
                    self.attributedBuilder.isAddingInArray = !([obj isEqual:[rangeObj lastObject]]);
                    addBlock(obj);
                }
            }
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(NSRange))range {
    return ^ id (NSRange range) {
        [self addAttributesWithRange:range];
        return self;
    };
}

- (NSMutableAttributedString * (^)(NSTextAttachment *,NSInteger))attachment {
    return ^ id (NSTextAttachment *attachment,NSInteger index) {
        [self insertAttachment:attachment atIndex:index];
        return self;
    };
}

- (NSMutableAttributedString * (^)())all {
    return ^ id {
        self.attributedBuilder.all = @(YES);
        return self;
    };
}
- (NSMutableAttributedString * (^)(NSInteger))rangeIndex {
    return ^ id (NSInteger index) {
        self.attributedBuilder.rangeIndex = @(index);
        return self;
    };
}

#pragma mark - private

- (NSArray *)rangeOfSubString:(NSString *)targetString {
    
    NSMutableArray *rangeArray = [NSMutableArray array];
    NSString *totalString = [NSString stringWithFormat:@"%@%@",self.string,targetString];
    NSString *temp;
    for (int i = 0; i < self.string.length; i ++) {
        temp = [totalString substringWithRange:NSMakeRange(i, targetString.length)];
        if ([temp isEqualToString:targetString]) {
            NSRange range = {i,targetString.length};
            [rangeArray addObject:NSStringFromRange(range)];
        }
    }
    return rangeArray;
}

- (NSRange)getRangeWithObj:(NSString *)targetString {
    return [[self string] rangeOfString:targetString options:NSCaseInsensitiveSearch];
}

- (void)addAttributesAllWithObj:(NSString *)targetString {
    NSArray *rangeArray = [self rangeOfSubString:targetString];
    for (NSString *rangeString in rangeArray) {
        self.attributedBuilder.isAddingInArray = ![rangeString isEqual:[rangeArray lastObject]];
        NSRange range = NSRangeFromString(rangeString);
        [self addAttributesWithRange:range];
    }
    self.attributedBuilder.all = nil;
}

- (void)addAttributesAtRangeIndexWithObj:(NSString *)targetString {
    NSArray *rangeArray = [self rangeOfSubString:targetString];
    NSRange range;
    if (self.attributedBuilder.rangeIndex.integerValue > rangeArray.count - 1) {
        range = NSRangeFromString([rangeArray lastObject]);
    } else {
        range = NSRangeFromString([rangeArray objectAtIndex:self.attributedBuilder.rangeIndex.integerValue]);
    }
    [self addAttributesWithRange:range];
    if (self.attributedBuilder.isAddingInArray) return;
    self.attributedBuilder.rangeIndex = nil;
    self.attributedBuilder.all = nil;
}

- (void)addAttributesWithObj:(NSString *)targetString {
    [self textColorWithObj:targetString];
    [self textFontWithObj:targetString];
    [self backgroundColorWithObj:targetString];
    [self textObliquenessWithObj:targetString];
    [self textExpansionWithObj:targetString];
    [self textSpaceWithObj:targetString];
    [self textUnderLineWithObj:targetString];
    [self textUnderLineColorWithObj:targetString];
    [self textStrokeColorWithObj:targetString];
    [self textStrokeWidthWithObj:targetString];
    [self textStrikethroughWithObj:targetString];
    [self textStrikethroughColorWithObj:targetString];
    [self textLigatureWithObj:targetString];
    [self textShadowWithObj:targetString];
    [self textEffectLetterpressStyleWithObj:targetString];
    [self textBaselineOffsetWithObj:targetString];
    [self textWriteDirectionWithObj:targetString];
    [self textLinkWithObj:targetString];
}

- (void)addAttributesWithRange:(NSRange)range {
    [self textColorWithRange:range];
    [self textFontWithRange:range];
    [self backgroundColorWithRange:range];
    [self textObliquenessWithRange:range];
    [self textExpansionWithRange:range];
    [self textSpaceWithRange:range];
    [self textUnderLineWithRange:range];
    [self textUnderLineColorWithRange:range];
    [self textStrokeColorWithRange:range];
    [self textStrokeWidthWithRange:range];
    [self textStrikethroughWithRange:range];
    [self textStrikethroughColorWithRange:range];
    [self textLigatureWithRange:range];
    [self textShadowWithRange:range];
    [self textEffectLetterpressStyleWithRange:range];
    [self textBaselineOffsetWithRange:range];
    [self textWriteDirectionWithRange:range];
    [self textLinkWithRange:range];
}



- (void)textColorWithRange:(NSRange)range {
    if (!self.attributedBuilder.currentTextColor) return;
    [self addAttribute:NSForegroundColorAttributeName value:self.attributedBuilder.currentTextColor range:range];
    if (!self.attributedBuilder.isAddingInArray) self.attributedBuilder.currentTextColor = nil;
}

- (void)textColorWithObj:(NSString *)targetString {
    [self textColorWithRange:[self getRangeWithObj:targetString]];
}


- (void)backgroundColorWithRange:(NSRange)range {
    if (!self.attributedBuilder.currentBackgroundColor) return;
    [self addAttribute:NSBackgroundColorAttributeName value:self.attributedBuilder.currentBackgroundColor range:range];
    if (!self.attributedBuilder.isAddingInArray) self.attributedBuilder.currentBackgroundColor = nil;
}

- (void)backgroundColorWithObj:(NSString *)targetString {
    [self backgroundColorWithRange:[self getRangeWithObj:targetString]];
}


- (void)textFontWithRange:(NSRange)range {
    if (!self.attributedBuilder.currentFont) return;
    [self addAttribute:NSFontAttributeName value:self.attributedBuilder.currentFont range:range];
    if (!self.attributedBuilder.isAddingInArray) self.attributedBuilder.currentFont = nil;
}

- (void)textFontWithObj:(NSString *)targetString {
    [self textFontWithRange:[self getRangeWithObj:targetString]];
}


- (void)textObliquenessWithRange:(NSRange)range {
    if (!self.attributedBuilder.obliqueness) return;
    [self addAttribute:NSObliquenessAttributeName value:self.attributedBuilder.obliqueness range:range];
    if (!self.attributedBuilder.isAddingInArray) self.attributedBuilder.obliqueness = nil;
}

- (void)textObliquenessWithObj:(NSString *)targetString {
    [self textObliquenessWithRange:[self getRangeWithObj:targetString]];
}


- (void)textExpansionWithRange:(NSRange)range {
    if (!self.attributedBuilder.Expansion) return;
    [self addAttribute:NSExpansionAttributeName value:self.attributedBuilder.Expansion range:range];
    if (!self.attributedBuilder.isAddingInArray) self.attributedBuilder.Expansion = nil;
}

- (void)textExpansionWithObj:(NSString *)targetString {
    [self textExpansionWithRange:[self getRangeWithObj:targetString]];
}


- (void)lineSpaceWithSpace:(CGFloat)space {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:[self getRangeWithObj:self.string]];
}


- (void)textSpaceWithObj:(NSString *)targetString {
    [self textSpaceWithRange:[self getRangeWithObj:targetString]];
}

- (void)textSpaceWithRange:(NSRange)range {
    if (!self.attributedBuilder.textSpace) return;
    [self addAttribute:NSKernAttributeName value:self.attributedBuilder.textSpace range:range];
    if (!self.attributedBuilder.isAddingInArray) self.attributedBuilder.textSpace = nil;
}


- (void)textUnderLineWithObj:(NSString *)targetString {
    [self textUnderLineWithRange:[self getRangeWithObj:targetString]];
}

- (void)textUnderLineWithRange:(NSRange)range {
    if (!self.attributedBuilder.underline) return;
    [self addAttribute:NSUnderlineStyleAttributeName value:self.attributedBuilder.underline range:range];
    if (!self.attributedBuilder.isAddingInArray) self.attributedBuilder.underline = nil;
}


- (void)textUnderLineColorWithObj:(NSString *)targetString {
    [self textUnderLineColorWithRange:[self getRangeWithObj:targetString]];
}

- (void)textUnderLineColorWithRange:(NSRange)range {
    if (!self.attributedBuilder.underLineColor) return;
    [self addAttribute:NSUnderlineColorAttributeName value:self.attributedBuilder.underLineColor range:range];
    if (!self.attributedBuilder.isAddingInArray) self.attributedBuilder.underLineColor = nil;
}


- (void)textStrokeColorWithObj:(NSString *)targetString {
    [self textStrokeColorWithRange:[self getRangeWithObj:targetString]];
}

- (void)textStrokeColorWithRange:(NSRange)range {
    if (!self.attributedBuilder.strokeColor) return;
    [self addAttribute:NSStrokeColorAttributeName value:self.attributedBuilder.strokeColor range:range];
    if (!self.attributedBuilder.isAddingInArray) self.attributedBuilder.strokeColor = nil;
}


- (void)textStrokeWidthWithObj:(NSString *)targetString {
    [self textStrokeWidthWithRange:[self getRangeWithObj:targetString]];
}

- (void)textStrokeWidthWithRange:(NSRange)range {
    if (!self.attributedBuilder.strokeWidth) return;
    [self addAttribute:NSStrokeWidthAttributeName value:self.attributedBuilder.strokeWidth range:range];
    if (!self.attributedBuilder.isAddingInArray) self.attributedBuilder.strokeWidth = nil;
}


- (void)textStrikethroughWithObj:(NSString *)targetString {
    [self textStrikethroughWithRange:[self getRangeWithObj:targetString]];
}

- (void)textStrikethroughWithRange:(NSRange)range {
    if (!self.attributedBuilder.strikethrough) return;
    [self addAttribute:NSStrikethroughStyleAttributeName value:self.attributedBuilder.strikethrough range:range];
    if (!self.attributedBuilder.isAddingInArray) self.attributedBuilder.strikethrough = nil;
}


- (void)textStrikethroughColorWithObj:(NSString *)targetString {
    [self textStrikethroughColorWithRange:[self getRangeWithObj:targetString]];
}

- (void)textStrikethroughColorWithRange:(NSRange)range {
    if (!self.attributedBuilder.strikethroughColor) return;
    [self addAttribute:NSStrikethroughColorAttributeName value:self.attributedBuilder.strikethroughColor range:range];
    if (!self.attributedBuilder.isAddingInArray) self.attributedBuilder.strikethroughColor = nil;
}


- (void)textLigatureWithObj:(NSString *)targetString {
    [self textStrikethroughColorWithRange:[self getRangeWithObj:targetString]];
}

- (void)textLigatureWithRange:(NSRange)range {
    if (!self.attributedBuilder.ligature) return;
    [self addAttribute:NSLigatureAttributeName value:self.attributedBuilder.ligature range:range];
    if (!self.attributedBuilder.isAddingInArray) self.attributedBuilder.ligature = nil;
}


- (void)textShadowWithObj:(NSString *)targetString {
    [self textShadowWithRange:[self getRangeWithObj:targetString]];
}

- (void)textShadowWithRange:(NSRange)range {
    if (!self.attributedBuilder.shadow) return;
    [self addAttribute:NSShadowAttributeName value:self.attributedBuilder.shadow range:range];
    if (!self.attributedBuilder.isAddingInArray) self.attributedBuilder.shadow = nil;
}


- (void)textEffectLetterpressStyleWithObj:(NSString *)targetString {
    [self textEffectLetterpressStyleWithRange:[self getRangeWithObj:targetString]];
}

- (void)textEffectLetterpressStyleWithRange:(NSRange)range {
    if (!self.attributedBuilder.effectLetterpressStyle) return;
    if ([self.attributedBuilder.effectLetterpressStyle boolValue]) [self addAttribute:NSTextEffectAttributeName value:NSTextEffectLetterpressStyle range:range];
    if (!self.attributedBuilder.isAddingInArray) self.attributedBuilder.effectLetterpressStyle = nil;
}


- (void)textBaselineOffsetWithObj:(NSString *)targetString {
    [self textBaselineOffsetWithRange:[self getRangeWithObj:targetString]];
}

- (void)textBaselineOffsetWithRange:(NSRange)range {
    if (!self.attributedBuilder.baselineOffset) return;
    [self addAttribute:NSBaselineOffsetAttributeName value:self.attributedBuilder.baselineOffset range:range];
    if (!self.attributedBuilder.isAddingInArray) self.attributedBuilder.baselineOffset = nil;
}


- (void)textWriteDirectionWithObj:(NSString *)targetString {
    [self textWriteDirectionWithRange:[self getRangeWithObj:targetString]];
}

- (void)textWriteDirectionWithRange:(NSRange)range {
    if (!self.attributedBuilder.writingDirection) return;
    [self addAttribute:NSWritingDirectionAttributeName value:self.attributedBuilder.writingDirection range:range];
    if (!self.attributedBuilder.isAddingInArray) self.attributedBuilder.writingDirection = nil;
}


- (void)textLinkWithObj:(NSString *)targetString {
    [self textLinkWithRange:[self getRangeWithObj:targetString]];
}

- (void)textLinkWithRange:(NSRange)range {
    if (!self.attributedBuilder.link) return;
    [self addAttribute:NSLinkAttributeName value:self.attributedBuilder.link range:range];
    if (!self.attributedBuilder.isAddingInArray) self.attributedBuilder.link = nil;
}

- (void)insertAttachment:(NSTextAttachment *)attachment atIndex:(NSInteger)index {
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
    [self insertAttributedString:attachmentString atIndex:index];
}

@end
