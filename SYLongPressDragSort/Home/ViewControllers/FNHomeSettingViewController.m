//
//  FNHomeSettingViewController.m
//  FNMerchant
//
//  Created by 张苏亚 on 16/6/20.
//  Copyright © 2016年 suya. All rights reserved.
//

#import "FNHomeSettingViewController.h"
#import "FNGetStoreManagementSettingModel.h"
#import "FNGetBiSettingModel.h"
#import "FNSaveBiSettingModel.h"
#import "FNSaveStoreManagementSettingModel.h"
#import "UIView+Additions.h"
#import "FNSwitch.h"
NSString *const FNManagementSettingVisibleChange = @"managementSettingVisibleChange";
NSString *const FNBiSettingVisibleChange = @"biSettingVisibleChange";

@interface FNHomeSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

//@property (nonatomic, strong) NSRecursiveLock *lock;
@property (nonatomic,strong) UITableView *settingTableView;
@property (nonatomic,strong) UILabel *titleLabel;
//@property (nonatomic,strong) MDHomeAddItemVM *addItemVM;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,assign)FNHomeSettingViewControllerStyle settingViewControllerStyle;
@property (nonatomic, assign) BOOL changeSucced;

@end

@implementation FNHomeSettingViewController

#pragma mark - Lifecycle

-(instancetype)initWithViewControllerStyle:(FNHomeSettingViewControllerStyle )settingViewControllerStyle
{
    self = [super init];
    _settingViewControllerStyle = settingViewControllerStyle;
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //    _lock = [NSRecursiveLock new];
    
    [self initNavigationBar];
    [self.view addSubview:self.settingTableView];
    
    //    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
    [self initRequest];
    //    }];
    //
    //    [header.lastUpdatedTimeLabel setFont:[UIFont systemFontOfSize:10]];
    //    [header.lastUpdatedTimeLabel setTextColor:LightGrayStringColor];
    //    header.backgroundColor = GrayBackgroundColor;
    //    self.settingTableView.mj_header = header;
    //
    //    [self.settingTableView.mj_header beginRefreshing];
    //    [self initRequest];
    // Do any additional setup after loading the view.
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_changeSucced) {
        
        if (self.settingViewControllerStyle == FNHomeSettingViewControllerStyleBi) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:FNBiSettingVisibleChange object:self userInfo:nil];
            
        }else if (self.settingViewControllerStyle == FNHomeSettingViewControllerStyleManagement)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:FNManagementSettingVisibleChange object:self userInfo:nil];
        }
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    
}

#pragma mark - Custom Accessors

- (UITableView *)settingTableView
{
    if (!_settingTableView) {
        _settingTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight ) style:UITableViewStylePlain];
        _settingTableView.delegate = self;
        _settingTableView.userInteractionEnabled=YES;
        _settingTableView.dataSource = self;
        _settingTableView.scrollsToTop=YES;
        _settingTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _settingTableView.backgroundColor = WhiteStringColor;
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        _settingTableView.tableHeaderView = tableHeaderView;
        _settingTableView.tableFooterView = [UIView new];
        //        _settingTableView.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0);
    }
    return _settingTableView;
}



#pragma -mark Actions
//重写夫类方法
- (void)backButtonClicked:(UIButton *)sender
{
    //    if (self.settingViewControllerStyle == FNHomeSettingViewControllerStyleBi) {
    //
    //        [[NSNotificationCenter defaultCenter] postNotificationName:FNBiSettingVisibleChange object:self userInfo:nil];
    //
    //    }else if (self.settingViewControllerStyle == FNHomeSettingViewControllerStyleManagement)
    //    {
    //        [[NSNotificationCenter defaultCenter] postNotificationName:FNManagementSettingVisibleChange object:self userInfo:nil];
    //    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clicked
{
    
}

-(void)switchValueChanged:(UISwitch *)switchView
{
    
    
    switchView.userInteractionEnabled = NO;
    
    
    //不同的iOS版本下的view层级是不一样的
    if (switchView.isOn) {
        [switchView setOn:NO animated:NO];
    }else
    {
        [switchView setOn:YES animated:NO];
        
    }
    
    UITableViewCell *cell = (UITableViewCell *)[switchView superview] ;
    
    NSIndexPath *indexPath = [self.settingTableView indexPathForCell:cell];
    WS(weakSelf);
    
    //先请求接口，接口请求成功后。再进行下面操作。(因为接口还不能调用，就先跳过这个步骤)
    if (self.settingViewControllerStyle == FNHomeSettingViewControllerStyleBi) {
        FNSaveBiSettingModel *saveModel = [[FNSaveBiSettingModel alloc] init];
        NSMutableArray *vcDataArray = [self.dataArray mutableCopy];
        FNBiSettingModel *originalModel = self.dataArray[indexPath.row];
        //        NSLog(@"--------------------------------requestCount%@",@(originalModel.requestCount));
        if (originalModel.requestCount == 1) {
            return;
        }
        originalModel.requestCount = 1;
        FNBiSettingModel *model = [vcDataArray[indexPath.row] copy];
        if (switchView.isOn) {
            
            model.isVisible = [NSNumber numberWithInteger:0];
            
        }else
        {
            model.isVisible = [NSNumber numberWithInteger:1];
        }
        
        saveModel.datalist = @[model];
        
        //        WS(weakSelf);
//        __weak typeof(FNBiSettingModel *)weakModel = originalModel;
//        __weak typeof(UISwitch *) weakSwitch = switchView;
//        [self.server requestSaveBiSettingWithParameterModel:saveModel success:^(id responseModel, BOOL isCache) {
//            weakSwitch.userInteractionEnabled = YES;
//            weakSelf.changeSucced = YES;
//            weakModel.requestCount = 0;
//            //            FNBiSettingModel *settingModel = weakSelf.dataArray[indexPath.row];
//            if (weakSwitch.isOn) {
//                
//                weakModel.isVisible = [NSNumber numberWithInteger:0];
//                [weakSwitch setOn:NO animated:YES];
//            }else
//            {
//                weakModel.isVisible = [NSNumber numberWithInteger:1];
//                [weakSwitch setOn:YES animated:YES];
//            }
//            
//        } failure:^(FNBaseResponseModel *responseModel, NSError *error) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                weakModel.requestCount = 0;
//                
//                weakSwitch.userInteractionEnabled = YES;
//                //                if (weakSwitch.isOn) {
//                //                    [weakSwitch setOn:NO animated:YES];
//                //                    weakModel.isVisible = [NSNumber numberWithInteger:0];
//                //                    //                weakSwitch.isOn = NO;
//                //                }else
//                //                {
//                //                    [weakSwitch setOn:YES animated:YES];
//                //                    weakModel.isVisible = [NSNumber numberWithInteger:1];
//                //                }
//                
//                
//                if (responseModel&&[responseModel.errorCode integerValue] ==1000) {
//                    [weakSelf startProgressText:responseModel.errorDesc delay:1];
//                }
//                
//                if (error) {
//                    if ((error.code == FNNoNetworkConnectError)||(error.code == FNServerUnReachabilityError)) {
//                        [weakSelf startProgressText:[error.userInfo objectForKey:@"NSLocalizedDescription"] delay:1];
//                    }
//                    
//                    
//                }
//                
//            });
//            
//            //            [[NSNotificationCenter defaultCenter] postNotificationName:FNBiSettingVisibleChange object:weakSelf userInfo:nil];
//            
//        }];
//        
        
        
    }else if (self.settingViewControllerStyle == FNHomeSettingViewControllerStyleManagement)
    {
        FNSaveStoreManagementSettingModel *saveModel = [[FNSaveStoreManagementSettingModel alloc] init];
        
        FNStoreManagementSettingModel *model = self.dataArray[indexPath.row];
        
        NSArray *vcDataArray = [self.dataArray copy];
        FNStoreManagementSettingModel *originalModel = [vcDataArray[indexPath.row] copy];
        if (originalModel.requestCount == 1) {
            return;
        }
        originalModel.requestCount = 1;
        
        if (switchView.isOn) {
            
            model.isVisible = [NSNumber numberWithInteger:0];
            
        }else
        {
            model.isVisible = [NSNumber numberWithInteger:1];
        }
        
        saveModel.datalist = @[model];
        
//        __weak typeof(FNStoreManagementSettingModel *)weakModel = originalModel;
//        __weak typeof(UISwitch *) weakSwitch = switchView;
//        //        WS(weakSelf);
//        [self.server requestSaveStoreManagementWithParameterModel:saveModel success:^(id responseModel, BOOL isCache) {
//            weakSwitch.userInteractionEnabled = YES;
//            weakModel.requestCount = 0;
//            weakSelf.changeSucced = YES;
//            //            FNStoreManagementSettingModel *settingModel = weakSelf.dataArray[indexPath.row];
//            if (weakSwitch.isOn) {
//                
//                weakModel.isVisible = [NSNumber numberWithInteger:0];
//                [weakSwitch setOn:NO animated:YES];
//            }else
//            {
//                weakModel.isVisible = [NSNumber numberWithInteger:1];
//                [weakSwitch setOn:YES animated:YES];
//            }
//            
//            
//        } failure:^(FNBaseResponseModel *responseModel, NSError *error) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                weakSwitch.userInteractionEnabled = YES;
//                weakModel.requestCount = 0;
//                
//                if (responseModel&&[responseModel.errorCode integerValue] ==1000) {
//                    [weakSelf startProgressText:responseModel.errorDesc delay:1];
//                }
//                
//                if (error) {
//                    if ((error.code == FNNoNetworkConnectError)||(error.code == FNServerUnReachabilityError)) {
//                        [weakSelf startProgressText:[error.userInfo objectForKey:@"NSLocalizedDescription"] delay:1];
//                    }
//                    
//                    
//                }
//                
//            });
//            
//            //            [[NSNotificationCenter defaultCenter] postNotificationName:FNManagementSettingVisibleChange object:weakSelf userInfo:nil];
//            
//        }];;
//        
    }
    
    //    [_lock unlock];
}

#pragma mark - Private

-(void)initRequest
{
    WS(weakSelf);
    
    if (self.settingViewControllerStyle == FNHomeSettingViewControllerStyleBi) {
        
//        [self.server requestBiSetting:^(FNGetBiSettingModel *responseModel, BOOL isCache) {
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                [weakSelf stopProgress];
//                
//                weakSelf.dataArray = [responseModel.dataList mutableCopy];
//                
//                [weakSelf.settingTableView reloadData];
//            });
//            
//        } failure:^(FNBaseResponseModel *responseModel, NSError *error) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakSelf stopProgress];
//                
//                //                DLog(@"error%@",error);
//                if (error) {
//                    if ((error.code == FNNoNetworkConnectError)||(error.code == FNServerUnReachabilityError)) {
//                        [weakSelf startProgressText:[error.userInfo objectForKey:@"NSLocalizedDescription"] delay:1];
//                    }
//                    
//                    
//                }
//                //                if (([responseModel.errorCode integerValue] == FNNoNetworkConnectError)||([responseModel.errorCode integerValue] == FNServerUnReachabilityError)) {
//                //                    [weakSelf startProgressText:responseModel.errorDesc delay:1];
//                //                }
//            });
//        }];
        
    }else if (self.settingViewControllerStyle == FNHomeSettingViewControllerStyleManagement)
    {
//        [self.server requestStoreManagementSetting:^(FNGetStoreManagementSettingModel *responseModel, BOOL isCache) {
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                [weakSelf stopProgress];
//                
//                weakSelf.dataArray = [responseModel.dataList mutableCopy];
//                
//                [weakSelf.settingTableView reloadData];
//            });
//            
//        } failure:^(FNBaseResponseModel *responseModel, NSError *error) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakSelf stopProgress];
//                
//                if (error) {
//                    if ((error.code == FNNoNetworkConnectError)||(error.code == FNServerUnReachabilityError)) {
//                        [weakSelf startProgressText:[error.userInfo objectForKey:@"NSLocalizedDescription"] delay:1];
//                    }
//                    
//                    
//                }
//            });
//        }];
        
    }
    
    
}



-(void)initNavigationBar
{
    self.navigationController.navigationBarHidden = NO;
    //    UINavigationBar *coustomeBar = [self.navigationController.view viewWithTag:100001];
    //    [coustomeBar removeFromSuperview];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 30, 30);
    if (self.settingViewControllerStyle == FNHomeSettingViewControllerStyleBi) {
        
        [titleLabel setText:@"数据管理"];
        
    }else if (self.settingViewControllerStyle == FNHomeSettingViewControllerStyleManagement)
    {
        [titleLabel setText:@"首页工作台"];
    }
    
    [titleLabel setTextColor:BlackStringColor];
    [titleLabel setFont:[UIFont systemFontOfSize:17]];
    
    self.navigationItem.titleView = titleLabel;
    self.titleLabel = titleLabel;
    
    
}



#pragma -mark UITableViewDelegate UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID ];
    }
    
    FNSwitch *switchs = [[FNSwitch alloc] initWithFrame:CGRectMake(0, 0, 50, 10)];
    //    switchs.fleft = SCREEN_WIDTH -50;
    switchs.onTintColor = GreenBackgroundColor;
    cell.accessoryView = switchs;
    //    [cell addSubview:switchs];
    if (self.settingViewControllerStyle ==FNHomeSettingViewControllerStyleBi) {
        FNBiSettingModel *biSettingInfoModel = self.dataArray[indexPath.item];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",biSettingInfoModel.name];
        DLog(@"labelFont%@",cell.textLabel.font);
        if ([biSettingInfoModel.isVisible integerValue] ==0) {
            switchs.on = NO;
        }else if ([biSettingInfoModel.isVisible integerValue] ==1)
        {
            switchs.on = YES;
        }
        
    }else if (self.settingViewControllerStyle ==FNHomeSettingViewControllerStyleManagement)
    {
        FNStoreManagementSettingModel *modelSettingInfoModel = self.dataArray[indexPath.item];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",modelSettingInfoModel.name];
        if ([modelSettingInfoModel.isVisible integerValue] ==0) {
            
            switchs.on = NO;
            
        }else if ([modelSettingInfoModel.isVisible integerValue] ==1)
        {
            switchs.on = YES;
        }
    }
    switchs.exclusiveTouch = YES;
    [switchs addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
