//
//  UIImageView+Letters.m
//
//  Created by Tom Bachant on 6/17/14.
//  Copyright (c) 2014 Tom Bachant. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "UIImageView+Letters.h"

// This multiplier sets the font size based on the view bounds
static const CGFloat kFontResizingProportion = 0.42f;

@implementation UIImageView (Letters)

- (void)ivl_setImageWithString:(NSString *)string {
    [self ivl_setImageWithString:string color:nil circular:NO textAttributes:nil];
}

- (void)ivl_setImageWithString:(NSString *)string color:(UIColor *)color {
    [self ivl_setImageWithString:string color:color circular:NO textAttributes:nil];
}

- (void)ivl_setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular {
    [self ivl_setImageWithString:string color:color circular:isCircular textAttributes:nil];
}

- (void)ivl_setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular fontName:(NSString *)fontName {
    [self ivl_setImageWithString:string color:color circular:isCircular textAttributes:@{
                                                                                     NSFontAttributeName:[[self class] ivl_fontForFontName:fontName size:self.bounds.size],
                                                                                     NSForegroundColorAttributeName: [UIColor whiteColor]
                                                                                     }];
}

- (void)ivl_setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular textAttributes:(NSDictionary *)textAttributes {
    if (!textAttributes) {
        textAttributes = [[self class] ivl_defaultTextAttributesForSize:self.bounds.size];
    }
    
    UIColor *backgroundColor = color ? color : [[self class] ivl_randomColorWithSeedString:string];

    self.image = [[self class] ivl_imageSnapshotFromText:[[self class] ivl_initialsFromString:string]
                                                    size:self.bounds.size
                                                circular:isCircular
                                          textAttributes:textAttributes
                                         backgroundColor:backgroundColor
                                             contentMode:self.contentMode];
}

#pragma mark - Helpers

+ (UIFont *)ivl_fontForFontName:(NSString *)fontName size:(CGSize)size {
    
    CGFloat fontSize = size.width * kFontResizingProportion;
    if (fontName) {
        return [UIFont fontWithName:fontName size:fontSize];
    }
    else {
        return [UIFont systemFontOfSize:fontSize];
    }
    
}

+ (UIColor *)ivl_randomColor {
    return [self ivl_randomColorWithSeedString:nil];
}

+ (UIColor *)ivl_randomColorWithSeedString:(NSString *)seedString {
    
    srand48(seedString ? seedString.hash : arc4random());
    
    float red = 0.0;
    while (red < 0.1 || red > 0.84) {
        red = drand48();
    }
    
    float green = 0.0;
    while (green < 0.1 || green > 0.84) {
        green = drand48();
    }
    
    float blue = 0.0;
    while (blue < 0.1 || blue > 0.84) {
        blue = drand48();
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

+ (NSString *)ivl_initialsFromString:(NSString *)string {
    NSMutableString *displayString = [NSMutableString stringWithString:@""];

    NSMutableArray *words = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] mutableCopy];

    //
    // Get first letter of the first and last word
    //
    if ([words count]) {
        NSString *firstWord = [words firstObject];
        if ([firstWord length]) {
            // Get character range to handle emoji (emojis consist of 2 characters in sequence)
            NSRange firstLetterRange = [firstWord rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 1)];
            [displayString appendString:[firstWord substringWithRange:firstLetterRange]];
        }

        if ([words count] >= 2) {
            NSString *lastWord = [words lastObject];

            while ([lastWord length] == 0 && [words count] >= 2) {
                [words removeLastObject];
                lastWord = [words lastObject];
            }

            if ([words count] > 1) {
                // Get character range to handle emoji (emojis consist of 2 characters in sequence)
                NSRange lastLetterRange = [lastWord rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 1)];
                [displayString appendString:[lastWord substringWithRange:lastLetterRange]];
            }
        }
    }
    
    return [displayString uppercaseString];
}

+ (NSDictionary *)ivl_defaultTextAttributesForSize:(CGSize)size {
    return @{
            NSFontAttributeName : [self ivl_fontForFontName:nil size:size],
            NSForegroundColorAttributeName : [UIColor whiteColor]
    };
}

+ (UIImage *)ivl_imageSnapshotWithString:(NSString *)string size:(CGSize)size {
    return [self ivl_imageSnapshotWithString:string
                                        size:size
                                    circular:YES];
}

+ (UIImage *)ivl_imageSnapshotWithString:(NSString *)string size:(CGSize)size circular:(BOOL)isCircular {
    return [self ivl_imageSnapshotWithString:string
                                        size:size
                                    circular:isCircular
                              textAttributes:[self ivl_defaultTextAttributesForSize:size]];
}

+ (UIImage *)ivl_imageSnapshotWithString:(NSString *)string size:(CGSize)size circular:(BOOL)isCircular textAttributes:(NSDictionary *)textAttributes {
    return [self ivl_imageSnapshotFromText:[self ivl_initialsFromString:string]
                                      size:size
                                  circular:isCircular
                            textAttributes:textAttributes
                           backgroundColor:[[self class] ivl_randomColorWithSeedString:string]
                               contentMode:UIViewContentModeScaleAspectFill];
}

+ (UIImage *)ivl_imageSnapshotFromText:(NSString *)text size:(CGSize)size circular:(BOOL)isCircular textAttributes:(NSDictionary *)textAttributes backgroundColor:(UIColor *)color contentMode:(UIViewContentMode)contentMode {
    CGFloat scale = [UIScreen mainScreen].scale;
    
    if (contentMode == UIViewContentModeScaleToFill ||
        contentMode == UIViewContentModeScaleAspectFill ||
        contentMode == UIViewContentModeScaleAspectFit ||
        contentMode == UIViewContentModeRedraw)
    {
        size.width = floorf(size.width * scale) / scale;
        size.height = floorf(size.height * scale) / scale;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGRect rect = CGRectMake(0, 0, size.width, size.height);

    if (isCircular) {
        //
        // Clip context to a circle
        //
        CGPathRef path = CGPathCreateWithEllipseInRect(rect, NULL);
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGPathRelease(path);
    }
    
    //
    // Fill background of context
    //
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    //
    // Draw text in the context
    //
    CGSize textSize = [text sizeWithAttributes:textAttributes];
    
    [text drawInRect:CGRectMake(size.width/2 - textSize.width/2,
                                size.height/2 - textSize.height/2,
                                textSize.width,
                                textSize.height)
      withAttributes:textAttributes];
    
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshot;
}

@end
