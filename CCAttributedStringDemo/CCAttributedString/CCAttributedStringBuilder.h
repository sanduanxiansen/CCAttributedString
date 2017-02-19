//
//  CCAttributedStringBuilder.h
//  CCAttributedString
//
//  Created by CC on 2017/2/16.
//  Copyright © 2017年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CCAttributedStringBuilder : NSObject

@property (nonatomic, strong) UIColor *currentTextColor;
@property (nonatomic, strong) UIColor *currentBackgroundColor;
@property (nonatomic, strong) UIFont *currentFont;
@property (nonatomic, strong) NSNumber *obliqueness;
@property (nonatomic, strong) NSNumber *Expansion;
@property (nonatomic, strong) NSNumber *textSpace;
@property (nonatomic, strong) NSNumber *underline;
@property (nonatomic, strong) UIColor *underLineColor;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) NSNumber *strokeWidth;
@property (nonatomic, strong) NSNumber *strikethrough;
@property (nonatomic, strong) UIColor *strikethroughColor;
@property (nonatomic, strong) NSNumber *ligature;
@property (nonatomic, strong) NSShadow *shadow;
@property (nonatomic, strong) NSNumber *effectLetterpressStyle;
@property (nonatomic, strong) NSNumber *baselineOffset;
@property (nonatomic, strong) NSURL *link;
/**
 @[@(NSWritingDirectionLeftToRight | NSTextWritingDirectionEmbedding)]
 @[@(NSWritingDirectionLeftToRight | NSTextWritingDirectionOverride)]
 @[@(NSWritingDirectionRightToLeft | NSTextWritingDirectionEmbedding)]
 @[@(NSWritingDirectionRightToLeft | NSTextWritingDirectionOverride)]
 */
@property (nonatomic, strong) id writingDirection;
@property (nonatomic, strong) NSNumber *all;
@property (nonatomic, strong) NSNumber *rangeIndex;
@property (nonatomic, assign) BOOL isAddingInArray;

@end
