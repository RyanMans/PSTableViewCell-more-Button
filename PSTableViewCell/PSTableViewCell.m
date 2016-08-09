//
//  PSTableViewCell.m
//  PSTableViewCell
//
//  Created by Ryan_Man on 16/8/8.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSTableViewCell.h"

#define Cell_Row_Height   60

@interface PSTableViewCell ()
{
    UIButton * _deleteButton;
    
     UILabel * _nameLabel;
}
@end
@implementation PSTableViewCell

+ (PSTableViewCell*)cellWithTableView:(UITableView *)tableView
{
    static NSString * cellIdentity = @"PSTableViewCellId";
    
    PSTableViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    
    if (!cell)
    {
        cell = [[PSTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdentity];
    }
    
    return cell;
}

+ (CGFloat)cellHeight
{
    return Cell_Row_Height;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        
        _avatarView = [UIImageView new];
        _avatarView.backgroundColor = [UIColor redColor];
        _avatarView.frame = CGRectMake(15, 10, 40, 40);
        [self.contentView addSubview:_avatarView];
        
        
        _nameLabel = [UILabel new];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.frame = CGRectMake(CGRectGetMaxX(_avatarView.frame) + 10, 0, [UIScreen mainScreen].bounds.size.width, Cell_Row_Height);
        [self.contentView addSubview:_nameLabel];
        
        
        self.isTop = NO;
//        _deleteButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        _deleteButton.backgroundColor = [UIColor redColor];
//        _deleteButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, 60, 60);
//        [self.contentView addSubview:_deleteButton];
    }
    
    return self;
    
}

- (void)setName:(NSString *)name
{
    _name = name;
    
    _nameLabel.text = _name;
}

- (void)setTargetId:(NSString *)targetId
{
    _targetId = targetId;
}

- (void)setIsTop:(BOOL)isTop
{
    _isTop = isTop;
    
    if (_isTop == YES)
    {
        self.contentView.backgroundColor = [UIColor orangeColor];
    }else
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
