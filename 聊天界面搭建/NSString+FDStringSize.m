//
//  NSString+FDStringSize.m
//  AI人工智障
//
//  Created by iOS_Awei on 01/28/2019.
//  Copyright © 2019 iOS_Awei. All rights reserved.
//

#import "NSString+FDStringSize.h"

@implementation NSString (FDStringSize)

- (CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont*)font {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont*)font {
    return [text sizeOfTextWithMaxSize:maxSize font:font];
}

@end
