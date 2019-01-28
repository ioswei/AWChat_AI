//
//  ViewController.m
//  AI人工智障
//
//  Created by iOS_Awei on 01/28/2019.
//  Copyright © 2019 iOS_Awei. All rights reserved.
//

#import "ViewController.h"
#import "FDMessage.h"
#import "FDMessageFrame.h"
#import "FDMessageCell.h"
#import "FDProductTableViewCell.h"
#import "FDActivityTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *modelArray;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *messageTableView;
@end

@implementation ViewController

- (NSMutableArray *)modelArray {
    if (_modelArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"message.plist" ofType:nil];
        NSArray *dataArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *messageArray = [NSMutableArray array];
        for (NSDictionary *dict in dataArray) {
            // 创建一个数据模型
            FDMessage *message = [FDMessage messageWithDictionary:dict];
            
            // 创建一个frame模型
            FDMessageFrame *messageFrame = [[FDMessageFrame alloc] init];
            
            // 判断上一个message的时间和现在的是不是一样
            FDMessage *lastMessage = (FDMessage *)[[messageArray lastObject] message];
            if ([message.time isEqualToString:lastMessage.time]) {
                message.isHidden = YES;
            }
            
            // 将数据模型赋值给frame模型
            messageFrame.message = message;
            
            [messageArray addObject:messageFrame];

        }
        _modelArray = messageArray;
    }
    return _modelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self.messageTableView registerNib:[UINib nibWithNibName:NSStringFromClass([FDProductTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([FDProductTableViewCell class])];
    [self.messageTableView registerNib:[UINib nibWithNibName:NSStringFromClass([FDActivityTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([FDActivityTableViewCell class])];

}

- (void)keyboardWillChangeFrame:(NSNotification *)noteInfo {
    /**
     UIKeyboardAnimationCurveUserInfoKey = 7;
     UIKeyboardAnimationDurationUserInfoKey = "0.25";
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 258}}";
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 796}";
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 538}";
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 258}}";
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";
     UIKeyboardIsLocalUserInfoKey = 1;
     */
    NSLog(@"=== = %@",noteInfo.userInfo);
    
    // 获取键盘的Y坐标，然后减去屏幕的高度，就是键盘应该移动的距离
    CGRect keyBoard = [noteInfo.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 移动的距离
    CGFloat keyboardTransform = keyBoard.origin.y - self.view.frame.size.height;
    
    // 键盘的弹出和视图的移动同步进行一个动画。
    [UIView animateWithDuration:0.25 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, keyboardTransform);
    }];
    
    
    // 让tableView滑动到最底层

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.modelArray.count - 1 inSection:0];
    
    [self.messageTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 键盘的弹出和视图的移动同步进行一个动画。
    [self.view endEditing:YES];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    // 1.获取用户输入的信息
    NSString *textS = textField.text;
    
    [self sendMessage:textS type:FDMessageTypeMine];
    
    // 实现自动回复
    [self sendMessage:@"主人，柚子听不懂你的意思，请再说一遍。" type:FDMessageTypeOthers];
    
    textField.text = nil;
    
    return YES;
}

//  发送消息方法封装
- (void)sendMessage:(NSString *)messageStr type:(FDMessageType)type {
    
    // 2.创建数据模型和frame模型
    FDMessage *message = [[FDMessage alloc] init];
    
    /// 获取当前时间
    NSDate *currentDate = [NSDate date];
    
    /// 设置时间格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"今天 HH:mm";
    NSString *dateS = [formatter stringFromDate:currentDate];
    /// 设置数据
    message.type = type;
    message.time = dateS;
    message.text = messageStr;
    
    
    // 判断时间是否显示
    
    // 判断上一个message的时间和现在的是不是一样
    FDMessage *lastMessage = (FDMessage *)[[self.modelArray lastObject] message];
    if ([message.time isEqualToString:lastMessage.time]) {
        message.isHidden = YES;
    }
    
    // 创建frame模型
    FDMessageFrame *messageFrame = [[FDMessageFrame alloc] init];
    messageFrame.message = message;
    
    
    // 将模型添加到数组中
    
    [self.modelArray addObject:messageFrame];
    
    // 刷新tableView
    [self.messageTableView reloadData];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.modelArray.count - 1 inSection:0];
    [self.messageTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}



#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 获取数据源
    FDMessageFrame *messageFrame = self.modelArray[indexPath.row];
    
    if (messageFrame.message.product_showType == AWProductShowType_others) {
        // 创建cell
        FDMessageCell *cell = [FDMessageCell messageCellWithTableView:tableView];
        
        // 将数据源赋值给单元格
        cell.messageFrame = messageFrame;
        
        return cell;
        
    }else if (messageFrame.message.product_showType == AWProductShowType_product){
        
        FDProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FDProductTableViewCell class])];
        return cell;
        
    }else{
        
        FDActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FDActivityTableViewCell class])];
        return cell;
        
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FDMessageFrame *messageFrame = self.modelArray[indexPath.row];

    return messageFrame.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
