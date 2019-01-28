//
//  FDMessageFrame.m
//  AI人工智障
//
//  Created by iOS_Awei on 01/28/2019.
//  Copyright © 2019 iOS_Awei. All rights reserved.
//

#import "FDMessageFrame.h"
#import "NSString+FDStringSize.h"
#import "FDMessage.h"

@implementation FDMessageFrame

- (void)setMessage:(FDMessage *)message {
    _message = message;
    
    // 计算frame
    // 获取屏宽
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    // 间距
    CGFloat marginW = 5;
    
    // 时间label的frame
    CGFloat timeX = 15;
    CGFloat timeY = 15;
    CGFloat timeW = screenW;
    CGFloat timeH = 20;
    
    // 判断时间是否显示
    if (message.isHidden) {
        _timeLabelFrame = CGRectMake(timeX, timeY, timeW, 0);

    }else {
        _timeLabelFrame = CGRectMake(timeX, timeY, timeW, timeH);

    }
    
    if (message.product_showType == AWProductShowType_product) {
        _cellHeight = 228.0f;
    }else if (message.product_showType == AWProductShowType_activity){
        _cellHeight = 100.0f;
    }else{
        
        // 头像的frame
        CGFloat iconW = 40;
        CGFloat iconH = 40;
        CGFloat iconY = CGRectGetMaxY(_timeLabelFrame) + marginW;
        CGFloat iconX = message.type == FDMessageTypeMine ? (screenW - marginW - iconW) : marginW;
        _iconFrame = message.type == FDMessageTypeMine ? CGRectMake(iconX - 12, iconY, iconW, iconH) : CGRectMake(iconX + 12, iconY, iconW, iconH);
        
        
        // 正文的frame
        CGSize textSize = [message.text sizeOfTextWithMaxSize:CGSizeMake(200, MAXFLOAT) font:[UIFont systemFontOfSize:14]];
        
        CGFloat textW = textSize.width + 40 ;
        CGFloat textH = textSize.height + 30;
        
        CGFloat textY = iconY;
        CGFloat textX = message.type == FDMessageTypeMine ? (screenW - marginW - iconW - textW) : CGRectGetMaxX(_iconFrame);
        _textLabelFrame = message.type == FDMessageTypeMine ? CGRectMake(textX-13, textY, textW, textH):CGRectMake(textX, textY, textW, textH);
        // 行高，头像和正文那个大，返回那个
        _cellHeight = MAX(CGRectGetMaxY(_textLabelFrame), CGRectGetMaxY(_iconFrame)) + marginW;
        
    }
    
    
}


@end
