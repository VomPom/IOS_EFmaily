//
//  SexController.m
//  Family
//
//  Created by Julis on 16/7/1.
//  Copyright © 2016年 ZHC. All rights reserved.
//

#import "changeOtherSexController.h"
#import "FZHTableViewCell.h"
#define  WidthW [UIScreen mainScreen].bounds.size.width
@interface changeOtherSexController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableViewCell *cell;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation changeOtherSexController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled=NO;//禁止tableview移动

    [self.navigationItem setTitle:@"性别选择"];
    [self initDataSource];

}
- (void)initDataSource{
    self.dataSource = @[@"男",@"女"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //分组数 也就是section数
    return 1;
}

//设置每个分组下tableview的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }
    else
        return 0;
}
//每一个分组下对应的tableview 高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 45;
    }
    return 0;
}
//设置每组上面预留高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==0)
        return [UIScreen mainScreen].bounds.size.height-20-45*2-64;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"cellID";
    FZHTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[FZHTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLabel.text = self.dataSource[indexPath.row];
    //默认选中第一个，如不想默认注释此行
    if (indexPath.row == 0) {
        [cell show_select];
    }
    return cell;
}

#pragma TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setButtonIsSelectedWithIndexPath:indexPath];
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  主要方法
 */
- (void)setButtonIsSelectedWithIndexPath:(NSIndexPath *)indexPath{
    FZHTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell.is_selected) {//如果选择cell的is_selected为yes，不做任何操作
        
    }else{//如果选择的cellis_selected为no，显示btn，隐藏其他cell的btn
        for (int i = 0; i < 2; i++) {
            
            NSIndexPath *p = [NSIndexPath indexPathForRow:i inSection:0];
            FZHTableViewCell *c = [self.tableView cellForRowAtIndexPath:p];
            
            if (![cell isEqual:c]) {//把未选中的cell的btn隐藏
                
                [c hide_select];
                
            }else{//展示选中的cell的btn
                
                [cell show_select];
            }
        }
    }
}

@end
