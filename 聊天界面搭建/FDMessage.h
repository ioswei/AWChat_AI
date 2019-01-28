//
//  FDMessage.h
//  AI人工智障
//
//  Created by iOS_Awei on 01/28/2019.
//  Copyright © 2019 iOS_Awei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    FDMessageTypeMine = 0,
    FDMessageTypeOthers
} FDMessageType;

typedef enum : NSUInteger {
    AWProductShowType_others = 0,
    AWProductShowType_product = 1,
    AWProductShowType_activity
} AWProductShowType;

@interface FDMessage : NSObject

// 时间
@property (nonatomic,copy) NSString *time;

// 正文
@property (nonatomic,copy) NSString *text;

// 类型（标记自己发送的还是别人发送的)
@property (nonatomic,assign) FDMessageType type;

// 展示类型（商品还是活动)
@property (nonatomic,assign) AWProductShowType product_showType;

// 判断是否显示时间label,如果时间一样的话就不显示
@property (nonatomic,assign) BOOL isHidden;

// 产品名称
@property (nonatomic,copy) NSString *product_name;

// 产品类型
@property (nonatomic,copy) NSString *product_type;

// 产品原价格
@property (nonatomic,copy) NSString *product_oldPrice;

// 产品现价格
@property (nonatomic,copy) NSString *product_price;

// 产品图标
@property (nonatomic,copy) NSString *product_icon;

- (instancetype)initWithMessageDictionary:(NSDictionary *)dict;

+ (instancetype)messageWithDictionary:(NSDictionary *)dict;

@end
