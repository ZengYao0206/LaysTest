//
//  UIColor+Common.m
//  HappyShare
//
//  Created by Lin Pan on 13-3-14.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//

#import "UIColor+YW.h"
@interface NSString (ToolkitPrivateAdditions)
- (NSUInteger)_hexValue;
@end

@implementation NSString (ToolkitPrivateAdditions)
- (NSUInteger)_hexValue {
	NSUInteger result = 0;
	sscanf([self UTF8String], "%x", &result);
	return result;
}
@end

@implementation UIColor (YW)

+ (UIColor *)colorWithR:(float)r G:(float)g B:(float)b A:(float)a
{
    return  [UIColor colorWithRed:r/256.f green:g/256.f blue:b/256.f alpha:a];
}
/**
 *	@brief	获取颜色对象
 *
 *	@param 	string 	颜色描述字符串，带“＃”开头 或者 "0X" 
 *
 *	@return	颜色对象
 */
+ (UIColor *)colorWithString:(NSString *)string
{
    NSString *cString = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}



+ (UIColor *)colorWithHex:(NSString *)hex {
	// Remove `#` and `0x`
	if ([hex hasPrefix:@"#"]) {
		hex = [hex substringFromIndex:1];
	} else if ([hex hasPrefix:@"0x"]) {
		hex = [hex substringFromIndex:2];
	}
	
	// Invalid if not 3, 6, or 8 characters
	NSUInteger length = [hex length];
	if (length != 3 && length != 6 && length != 8) {
		return nil;
	}
	
	// Make the string 8 characters long for easier parsing
	if (length == 3) {
		NSString *r = [hex substringWithRange:NSMakeRange(0, 1)];
		NSString *g = [hex substringWithRange:NSMakeRange(1, 1)];
		NSString *b = [hex substringWithRange:NSMakeRange(2, 1)];
		hex = [NSString stringWithFormat:@"%@%@%@%@%@%@ff",
			   r, r, g, g, b, b];
	} else if (length == 6) {
		hex = [hex stringByAppendingString:@"ff"];
	}
	
	CGFloat red = [[hex substringWithRange:NSMakeRange(0, 2)] _hexValue] / 255.0f;
	CGFloat green = [[hex substringWithRange:NSMakeRange(2, 2)] _hexValue] / 255.0f;
	CGFloat blue = [[hex substringWithRange:NSMakeRange(4, 2)] _hexValue] / 255.0f;
	CGFloat alpha = [[hex substringWithRange:NSMakeRange(6, 2)] _hexValue] / 255.0f;
    
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


@end
