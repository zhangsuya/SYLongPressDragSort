//
//  SYLTabBarViewController.m
//  SYLongPressDragSort
//
//  Created by 张苏亚 on 16/5/26.
//  Copyright © 2016年 张苏亚. All rights reserved.
//

#import "SYLTabBarViewController.h"
#import "SYLHomePageViewController.h"
#import "SYLTabBar.h"
#import "SYLTabBarButton.h"
#import "UIView+Additions.h"
#import "SYLSecondHomePageViewController.h"
@interface SYLTabBarViewController ()<SYLTabBarDelegate>

@property (nonatomic,strong) NSArray *imageNameArr;
@property (nonatomic,strong) NSArray *imageSelectNameArr;
@property (nonatomic,strong) NSArray *titleNameArr;
@end

#define BTN_START_TAG 100
#define TABBAR_TAG 500

@implementation SYLTabBarViewController

- (NSArray *)imageNameArr
{
    if (!_imageNameArr) {
        _imageNameArr = [NSArray arrayWithObjects:@"icon_workbench_a",@"icon_notice_a",@"icon_service_a",@"icon_my_a",nil];
    }
    return _imageNameArr;
}

- (NSArray *)imageSelectNameArr
{
    if (!_imageSelectNameArr) {
        _imageSelectNameArr = [NSArray arrayWithObjects:@"icon_workbench_b",@"icon_notice_b",@"icon_service_b",@"icon_my_b", nil];
    }
    return _imageSelectNameArr;
}

-(NSArray *)titleNameArr
{
    if (!_titleNameArr) {
        _titleNameArr = @[@"工作台",@"通知",@"客服",@"我的"];
    }
    return _titleNameArr;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViewControllers];
    [self createTabBar];
}

- (void)createViewControllers {
    
    //工作台
    SYLHomePageViewController   *homeVC = [[SYLHomePageViewController alloc] init];
    UINavigationController  *homeNC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    //通知
    SYLSecondHomePageViewController   *fcVC   = [[SYLSecondHomePageViewController alloc] init];
    UINavigationController  *vcNC   = [[UINavigationController alloc] initWithRootViewController:fcVC];
    
    
    //客服
    SYLHomePageViewController *carVC = [[SYLHomePageViewController alloc] init];
    UINavigationController *carNC=[[UINavigationController alloc]initWithRootViewController:carVC];
    
    //我的
    SYLHomePageViewController *personVC = [[SYLHomePageViewController alloc]init];
    UINavigationController *personNC = [[UINavigationController alloc] initWithRootViewController:personVC];
    
    NSArray *array = @[homeNC,vcNC,carNC,personNC];
    self.viewControllers = array;
    self.selectedViewController = homeNC;
    
}

- (void)createTabBar {
    
    SYLTabBar *tabBar  = [[SYLTabBar alloc] init];
    tabBar.frame = CGRectMake(2.5f, 0, self.tabBar.fwidth - 5, self.tabBar.fheight);
//    tabBar.sd_height = 98/2;
    tabBar.delegate = self;
    tabBar.tag      = TABBAR_TAG;
    [self.tabBar addSubview:tabBar];
    
    
    
    //创建tabbar上的分栏按钮
    for (int i=0 ; i<self.imageNameArr.count ; i++) {
        
        [tabBar addButtonWithImageName:self.imageNameArr[i] selImageName:self.imageSelectNameArr[i] titleName:self.titleNameArr[i]];
    }
    
    
}

#pragma mark -- SYLTabBarDelegate
- (void)tabBar:(SYLTabBar *)tabBar didSelectButtonIndexFromTag:(NSInteger)fromTag toTag:(NSInteger)toTag
{
    
    
    //改变选项卡按钮的颜色
    SYLTabBarButton *fromBtn = [tabBar viewWithTag:fromTag + BTN_START_TAG];
    fromBtn.selected = NO;
    
    SYLTabBarButton *toBtn   = [tabBar viewWithTag:toTag + BTN_START_TAG];
    toBtn.selected = YES;
    [tabBar changeSelectdeBtn:toBtn];
    
    self.selectedIndex = toTag;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
