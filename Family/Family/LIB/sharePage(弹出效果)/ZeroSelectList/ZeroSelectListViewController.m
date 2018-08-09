//
//  SelectListViewController.m
//  SelectList
//
//  Created by ZWX on 16/6/15.
//  Copyright © 2016年 ZWX. All rights reserved.
//

#import "ZeroSelectListViewController.h"
#import "ZeroSelectListItem.h"
#import "ZeroSelectListCell.h"
#import "sendPhotosViewController.h"
#import "MessageMineController.h"
@interface ZeroSelectListViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
{
    UIButton *coverView;
}
@property (nonatomic, strong) UIView * selectListView;
@property (nonatomic, strong) UITableView * selectListTableView;
@end

@implementation ZeroSelectListViewController

- (instancetype)initWithItems:(NSArray<ZeroSelectListItem *> *)items
{
    if (self = [super init]) {
        self.items          = items;
        self.alphaComponent = 0.25;
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:_alphaComponent];

    [self createSelectListView];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createSelectListView
{
    //root view
    self.selectListView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120, 64 + 5, 100, 5 + 40 * _items.count)];

    [self.view addSubview:_selectListView];
    
    //background image
    UIImage * bgImage = [UIImage imageNamed:@"activity_add_bg"];
    bgImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(25, 10, 10, 22)];

    UIImageView * bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _selectListView.frame.size.width, _selectListView.frame.size.height)];
    bgImageView.image = bgImage;
    [_selectListView addSubview:bgImageView];
    
    //tableView
    self.selectListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, _selectListView.frame.size.width, _selectListView.frame.size.height) style:UITableViewStylePlain];
    
    _selectListTableView.delegate        = self;
    _selectListTableView.dataSource      = self;
    _selectListTableView.scrollEnabled   = NO;
    _selectListTableView.backgroundColor = [UIColor clearColor];
    [_selectListView addSubview:_selectListTableView];
    
    
    if ([_selectListTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_selectListTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_selectListTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_selectListTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    coverView = [UIButton buttonWithType:UIButtonTypeCustom];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha=0.3;
    coverView.frame = self.view.bounds;
    
    [self.view addSubview:coverView];
    [self.view bringSubviewToFront:_selectListView];
    //TapGesture
    UITapGestureRecognizer * dismissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    
    [coverView addTarget:self action:@selector(dismissBtn) forControlEvents:UIControlEventTouchUpInside];
    dismissTap.delegate = self;
    [self.view addGestureRecognizer:dismissTap];
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZeroSelectListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[ZeroSelectListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellId"];
        cell.backgroundColor = [UIColor clearColor];
    }
    UILabel *decibeLabel = [[UILabel alloc]initWithFrame:CGRectMake(45,5,100,30)];
    [cell addSubview:decibeLabel];
    ZeroSelectListItem * item    = [_items objectAtIndex:indexPath.row];
    decibeLabel.font          =  [UIFont systemFontOfSize:12.0f];
    cell.imageView.image     = item.iconImage;
    switch (indexPath.row) {
        case 0:
        {
             decibeLabel.text = @"发照片";
        }
            break;
        case 1:
        {
            decibeLabel.text = @"写故事";
        }
            break;
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self dismissWithAnimate:NO];
    
    if (self.clickBlock) {
        self.clickBlock(indexPath.row);
    }
}

#pragma mark - gesture delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.selectListView]) {
        return NO;
    }
    return YES;
}
-(void)dismissBtn
{
    [self dismissWithAnimate:NO];
}
- (void)dismiss
{
    [self dismissWithAnimate:YES];
}

#pragma mark - public method

- (void)show
{
    
    if (floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_8_0) {
        // iOS 8+
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
       
    }else{
        // iOS7
        UIViewController *root = _showListViewControl;
        while (root.parentViewController) {
            root = root.parentViewController;
        }
        root.modalPresentationStyle = UIModalPresentationCurrentContext;
    }
    
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [_showListViewControl presentViewController:self animated:YES completion:nil];
   
    
}

- (void)dismissWithAnimate:(BOOL)animate
{
    
    if (animate) {
        
        //设置缩放的原点(必须配置)
        //这个point，应该是按照比例来的。0是最左边，1是最右边
        [self setAnchorPoint:CGPointMake(0.9, 0) forView:_selectListView];
        
        [UIView animateWithDuration:0.3 animations:^{
            
            _selectListView.transform = CGAffineTransformMakeScale(0.01, 0.01);
            
            
        } completion:^(BOOL finished) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
           
        }];
    }else
        [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
   
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
