//
//  PSTableViewController.m
//  PSTableViewCell
//
//  Created by Ryan_Man on 16/8/8.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSTableViewController.h"
#import "PSTableViewCell.h"

@interface PSObject : NSObject
@property (nonatomic,copy)NSString * name;
@property (nonatomic,strong)NSString * objectId;
@end
@implementation PSObject
+ (PSObject*)modelWithDictionary:(NSDictionary*)dictionary
{
    PSObject * object = [[self alloc] init];
    
    [object setValuesForKeysWithDictionary:dictionary];
    
    return object;
}

- (void)setName:(NSString *)name
{
    _name = name;
}

- (void)setObjectId:(NSString *)objectId
{
    _objectId = objectId;
}

@end


@interface PSTableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * _allDataSource;
    
    NSString * _key;
    
}
@property (nonatomic,strong)UITableView * displayTableView;
@end

@implementation PSTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    [self.view addSubview:self.displayTableView];
    
    [self  loadAllDataSource];
}

- (UITableView*)displayTableView
{
    if (!_displayTableView)
    {
        _displayTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _displayTableView.delegate = self;
        _displayTableView.dataSource = self;
        _displayTableView.showsVerticalScrollIndicator = NO;
        
    }
    return _displayTableView;
}

- (void)loadAllDataSource
{
   
    _allDataSource = [NSMutableArray array];

    NSInteger index = 0 ;
    while (_allDataSource.count < 20)
    {
        PSObject * object = [[PSObject alloc] init];
        object.name =[NSString stringWithFormat:@"测试左滑多按钮功能 -- %ld",index];
        object.objectId = [NSString stringWithFormat:@"%ld",index];

        [_allDataSource addObject:object];
        index ++;
        
    }
    
    [_displayTableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [PSTableViewCell cellHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PSObject * object = _allDataSource[indexPath.row];
    
    PSTableViewCell * cell = [PSTableViewCell cellWithTableView:tableView];
    
    cell.name = object.name;
    cell.targetId = object.objectId;
    
    cell.isTop = [_key isEqualToString:object.objectId];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"click cell ");
}



#pragma mark - edit -

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PSTableViewCell * cell = (PSTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];

    UITableViewRowAction * topRowAction ;
    
    __weak typeof(self) ws = self;

    if (cell.isTop)
    {
        //取消置顶
         topRowAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"取消置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            
            NSLog(@"点击了取消置顶");
            
             _key = @"";
             
             [ws isCancelTop];
            
            [tableView reloadData];
        }];
        topRowAction.backgroundColor = [UIColor blueColor];

    }
    else
    {
        //置顶
        
        topRowAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            
            NSLog(@"点击了置顶");
            
            cell.isTop = YES;
            
            _key = cell.targetId;
            
            [ws isTop];
   
        }];
        topRowAction.backgroundColor = [UIColor lightGrayColor];

        
    }
    
    
    UITableViewRowAction * deleteRowAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSLog(@"点击了删除");
        
        [_allDataSource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationMiddle)];

    }];
    
    return @[deleteRowAction,topRowAction];
}

- (void)isTop
{
    
    NSMutableArray * temp = _allDataSource.mutableCopy;
    [_allDataSource removeAllObjects];
    
    for (PSObject * object in temp)
    {
        if ([object.objectId isEqualToString:_key])
        {
            [_allDataSource insertObject:object atIndex:0];
        }else
        {
            [_allDataSource addObject:object];
            
        }
    }
    
    [_displayTableView reloadData];
}

- (void)isCancelTop
{
    
    NSArray * temp = _allDataSource.mutableCopy;
    [_allDataSource removeAllObjects];
    
    temp = [temp sortedArrayUsingComparator:^NSComparisonResult(PSObject *obj1, PSObject * obj2) {
        
        if (obj1.objectId.integerValue > obj2.objectId.integerValue) return NSOrderedDescending;
        else if (obj1.objectId.integerValue < obj2.objectId.integerValue)return NSOrderedAscending;
        
        return NSOrderedSame;
    }];
    
    _allDataSource = temp.mutableCopy;
    
    [_displayTableView reloadData];

}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
