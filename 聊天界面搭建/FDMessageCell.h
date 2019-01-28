//
//  FDMessageCell.h
//  AI人工智障
//
//  Created by iOS_Awei on 01/28/2019.
//  Copyright © 2019 iOS_Awei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDMessageFrame;
@interface FDMessageCell : UITableViewCell

@property (nonatomic,strong) FDMessageFrame *messageFrame;


+ (instancetype) messageCellWithTableView:(UITableView *)tableView;

@end
