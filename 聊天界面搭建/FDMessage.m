//
//  FDMessage.m
//  AI人工智障
//
//  Created by iOS_Awei on 01/28/2019.
//  Copyright © 2019 iOS_Awei. All rights reserved.
//

#import "FDMessage.h"

@implementation FDMessage

- (instancetype)initWithMessageDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)messageWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithMessageDictionary:dict];
}


@end
