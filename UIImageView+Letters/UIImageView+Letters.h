//
//  UIImageView+Letters.h
//
//  Created by Tom Bachant on 6/17/14.
//  Copyright (c) 2014 Tom Bachant. All rights reserved.
//
//  Some code attributed to Nick Lockwood on 25/08/2013.
//  Copyright (c) 2013 Charcoal Design
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

#import <UIKit/UIKit.h>

@interface UIImageView (Letters)

/**
 Sets the image property of the view based on initial text. A random background color is automatically generated.
 
 @param string The string used to generate the initials. This should be a user's full name if available
 */
- (void)ivl_setImageWithString:(NSString *)string;

/**
 Sets the image property of the view based on initial text and a specified background color.
 
 @param string The string used to generate the initials. This should be a user's full name if available
 @param color (optional) This optional paramter sets the background of the image. If not provided, a random color will be generated
 */

- (void)ivl_setImageWithString:(NSString *)string color:(UIColor *)color;

/**
 Sets the image property of the view based on initial text, a specified background color, and a circular clipping
 
 @param string The string used to generate the initials. This should be a user's full name if available
 @param color (optional) This optional paramter sets the background of the image. If not provided, a random color will be generated
 @param isCircular This boolean will determine if the image view will be clipped to a circular shape
 */
- (void)ivl_setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular;

/**
 Sets the image property of the view based on initial text, a specified background color, a custom font, and a circular clipping
 
 @param string The string used to generate the initials. This should be a user's full name if available
 @param color (optional) This optional paramter sets the background of the image. If not provided, a random color will be generated
 @param isCircular This boolean will determine if the image view will be clipped to a circular shape
 @param fontName This will use a custom font attribute. If not provided, it will default to system font
 */
- (void)ivl_setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular fontName:(NSString *)fontName;

/**
 Sets the image property of the view based on initial text, a specified background color, custom text attributes, and a circular clipping

 @param string The string used to generate the initials. This should be a user's full name if available
 @param color (optional) This optional paramter sets the background of the image. If not provided, a random color will be generated
 @param isCircular This boolean will determine if the image view will be clipped to a circular shape
 @param textAttributes This dictionary allows you to specify font, text color, shadow properties, etc., for the letters text, using the keys found in NSAttributedString.h
 */
- (void)ivl_setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular textAttributes:(NSDictionary *)textAttributes;

/**
 Generates a circular image from the given parameters.
 @param string The string used to generate the initials. This should be a user's full name if available
 @param size The size of the image to generate
 */
+ (UIImage *)ivl_imageSnapshotWithString:(NSString *)string size:(CGSize)size;

/**
 Generates a circular image from the given parameters.
 @param string The string used to generate the initials. This should be a user's full name if available
 @param size The size of the image to generate
 @param isCircular This boolean will determine if the image view will be clipped to a circular shape
 */
+ (UIImage *)ivl_imageSnapshotWithString:(NSString *)string size:(CGSize)size circular:(BOOL)isCircular;

/**
 Generates a circular image from the given parameters.
 @param string The string used to generate the initials. This should be a user's full name if available
 @param size The size of the image to generate
 @param isCircular This boolean will determine if the image view will be clipped to a circular shape
 @param textAttributes This dictionary allows you to specify font, text color, shadow properties, etc., for the letters text, using the keys found in NSAttributedString.h
 */
+ (UIImage *)ivl_imageSnapshotWithString:(NSString *)string
                                    size:(CGSize)size
                                circular:(BOOL)isCircular
                          textAttributes:(NSDictionary *)textAttributes;

/**
 Generates a circular image from the given parameters.
 @param text This is the text that will be drawn into the image, as is
 @param size The size of the image to generate
 @param isCircular This boolean will determine if the image view will be clipped to a circular shape
 @param textAttributes This dictionary allows you to specify font, text color, shadow properties, etc., for the letters text, using the keys found in NSAttributedString.h
 @param color This parameter sets the background of the image
 @param contentMode This parameter sets the content mode used to draw the image
 */
+ (UIImage *)ivl_imageSnapshotFromText:(NSString *)text
                                  size:(CGSize)size
                              circular:(BOOL)isCircular
                        textAttributes:(NSDictionary *)textAttributes
                       backgroundColor:(UIColor *)color
                           contentMode:(UIViewContentMode)contentMode;

+ (UIColor *)ivl_randomColor;

+ (UIColor *)ivl_randomColorWithSeedString:(NSString *)seedString;

+ (NSString *)ivl_initialsFromString:(NSString *)string;

+ (NSDictionary *)ivl_defaultTextAttributesForSize:(CGSize)size;

@end
