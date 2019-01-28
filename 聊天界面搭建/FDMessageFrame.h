//
//  FDMessageFrame.h
//  AI人工智障
//
//  Created by iOS_Awei on 01/28/2019.
//  Copyright © 2019 iOS_Awei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class FDMessage;

@interface FDMessageFrame : NSObject

// 数据模型
@property (nonatomic,strong) FDMessage *message;

// 时间label的frame
@property (nonatomic,assign) CGRect timeLabelFrame;

// 正文label的frame
@property (nonatomic,assign) CGRect textLabelFrame;

// 头像的frame
@property (nonatomic,assign) CGRect iconFrame;

// cell高度
@property (nonatomic,assign) CGFloat cellHeight;

@end
