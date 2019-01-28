//
//  FDMessageCell.m
//  AI人工智障
//
//  Created by iOS_Awei on 01/28/2019.
//  Copyright © 2019 iOS_Awei. All rights reserved.
//

#import "FDMessageCell.h"
#import "FDMessageFrame.h"
#import "FDMessage.h"


@interface FDMessageCell ()

@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UIButton *textBtn;

@end

@implementation FDMessageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 创建时间label
        UILabel *timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:timeLabel];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel = timeLabel;
        
        // 创建头像
        UIImageView *iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconImageView];
        self.iconImageView = iconImageView;
        
        // 创建正文label
        UIButton *textBtn = [[UIButton alloc] init];
        [textBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        textBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        textBtn.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:textBtn];
        self.textBtn = textBtn;
        // 设置让按钮变大，但是titleLabel不要变大，所以设置一个内边距,内边距的设置需要和frame里面的相吻合，否则会出现错误
        self.textBtn.contentEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
        
        self.backgroundColor = [UIColor clearColor];
                
    }
    return self;
}


- (void)setMessageFrame:(FDMessageFrame *)messageFrame {
    _messageFrame = messageFrame;
    
    // 设置timelabel的内容和frame
    self.timeLabel.text = _messageFrame.message.time;
    self.timeLabel.frame = _messageFrame.timeLabelFrame;
    
    // 设置头像的内容和frame
    if (_messageFrame.message.type == FDMessageTypeMine) {
        self.iconImageView.backgroundColor = [UIColor purpleColor];
    }else {
        self.iconImageView.backgroundColor = [UIColor greenColor];
    }
    self.iconImageView.frame = _messageFrame.iconFrame;
    
    // 设置正文的内容和frame
    [self.textBtn setTitle:_messageFrame.message.text forState:UIControlStateNormal];
    self.textBtn.frame = _messageFrame.textLabelFrame;
    
    
    NSString *imageString;
    if (messageFrame.message.type == FDMessageTypeMine) {
        imageString = @"balloon_right_blue";
    }else {
        imageString = @"balloon_left_yellow";
    }
    UIImage *bgImage = [UIImage imageNamed:imageString];
    
    // 拉伸设置，设置为图片的宽高的各一半
    bgImage = [bgImage stretchableImageWithLeftCapWidth:bgImage.size.width * 0.5 topCapHeight:bgImage.size.height * 0.5];
    
    // 设置按钮的背景图
    [self.textBtn setBackgroundImage:bgImage forState:UIControlStateNormal];
    
       
    
}


+ (instancetype)messageCellWithTableView:(UITableView *)tableView {
    static NSString *cellId = @"messageCell";
    FDMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[FDMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
