//
//  UIColor+JRAdd.m
//  10-JRPickerDemo
//
//  Created by jackfrow on 2019/4/16.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import "UIColor+JRAdd.h"

@implementation UIColor (JRAdd)

+ (UIColor *)textGrayColor
{
    return [UIColor colorWithHexString:@"#494949"];
}

+(UIColor *)CommonYellowColor{
    
    return [UIColor colorWithHexString:@"FECA2F"];
}

+ (UIColor *)lineColor {
    return [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.1];
}

#pragma mark - HelperMethod

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    
    return [UIColor colorWithHexString:hexString alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    if ([hexString length] <= 0)
        return nil;
    
    // Remove '#'
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
    
    // Invalid if not 3, or 6 characters
    NSUInteger length = [hexString length];
    if (length != 3 && length != 6) {
        return nil;
    }
    
    NSUInteger digits = length / 3;
    CGFloat maxValue = ((digits == 1) ? 15.0 : 255.0);
    
    NSString *redString = [hexString substringWithRange:NSMakeRange(0, digits)];
    NSString *greenString = [hexString substringWithRange:NSMakeRange(digits, digits)];
    NSString *blueString = [hexString substringWithRange:NSMakeRange(2 * digits, digits)];
    
    NSUInteger red = 0;
    NSUInteger green = 0;
    NSUInteger blue = 0;
    
    sscanf([redString UTF8String], "%lx", (unsigned long *)&red);
    sscanf([greenString UTF8String], "%lx", (unsigned long *)&green);
    sscanf([blueString UTF8String], "%lx", (unsigned long *)&blue);
    
    return [UIColor colorWithRed:red/maxValue green:green/maxValue blue:blue/maxValue alpha:alpha];
}

@end
