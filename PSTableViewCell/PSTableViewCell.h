//
//  PSTableViewCell.h
//  PSTableViewCell
//
//  Created by Ryan_Man on 16/8/8.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSTableViewCell : UITableViewCell
@property (nonatomic,strong,readonly)UIImageView * avatarView;
@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSString * targetId;
@property (nonatomic,assign)BOOL isTop;


+ (PSTableViewCell*)cellWithTableView:(UITableView*)tableView;

+ (CGFloat)cellHeight;

@end
