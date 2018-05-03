//
//  LYBaseTableView.m
//  PureGarden
//
//  Created by xie dason on 2017/9/11.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import "LYBaseTableView.h"
#import "UIScrollView+EmptyDataSet.h"

@interface LYBaseTableView () <DZNEmptyDataSetSource>


@end

@implementation LYBaseTableView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.emptyDataSetSource = self;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    if (self = [super initWithFrame:frame style:style]) {
        self.emptyDataSetSource = self;
    }
    return self;
}

- (void)awakeFromNib{

    [super awakeFromNib];
    
    self.emptyDataSetSource = self;

}

#pragma mark - DZNEmptyDataSetSource Methods
//提示文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"抱歉,没有查到数据";
    UIFont *font = Font16;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//显示的图案
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{

    return [UIImage imageNamed:@"smile"];

}

@end
