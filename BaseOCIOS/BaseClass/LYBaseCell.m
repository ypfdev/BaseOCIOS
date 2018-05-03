//
//  LYBaseCell.m
//  PureGarden
//
//  Created by xie dason on 2017/7/11.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import "LYBaseCell.h"

@implementation LYBaseCell

//视图创建
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //取消cell的选中样式
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

//代码创建
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        //取消cell的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

//缓存池创建
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //取消cell的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
