//
//  NSString+FDStringSize.h
//  AI人工智障
//
//  Created by iOS_Awei on 01/28/2019.
//  Copyright © 2019 iOS_Awei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (FDStringSize)


- (CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont*)font;


+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont*)font;

@end
