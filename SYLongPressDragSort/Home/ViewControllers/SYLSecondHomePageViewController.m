//
//  SYLSecondHomePageViewController.m
//  SYLongPressDragSort
//
//  Created by 张苏亚 on 17/5/26.
//  Copyright © 2017年 张苏亚. All rights reserved.
//

#import "SYLSecondHomePageViewController.h"
#import "FNStoreBiInfoCollectionViewCell.h"
#import "FNHomeViewModel.h"
#import "FNGetPermissionInfoModel.h"
#import "FNSaveBiSortParameterModel.h"
#import "FNStoreManagementInfoCollectionViewCell.h"
#import "FNStoreDsrInfosCollectionViewCell.h"
#import "FNStoreDsrInfoHeaderReusableView.h"
#import "FNStoreAddBiInfoCollectionViewCell.h"
#import "FNHomeSettingViewController.h"
#import "UIView+Additions.h"
#import "UIImageView+WebCache.h"
#import "FNSaveStoreManagementSettingModel.h"
#import "FNGetStoreManagementSettingModel.h"
#import "FNSaveBiSettingModel.h"
#import "FNGetBiSettingModel.h"
#import "SYLTabBarViewController.h"
#import "FNHomeCoverView.h"
#import "FNDsrInfoFooterView.h"
#import "FNPermissionInfoResponseModel.h"
#import "FNHomeNoPermissionViewController.h"
#import "NSData+Add.h"
//#import "UIScrollView+UITouch.h"
//#import "FNMyAccountSettingViewController.h"
//#import "FNNetWorkCache.h"
//#import "FNEnvironmentConfigure.h"
//@class FNMyAccountSettingViewController;

static NSString *biInfoCollectionCell = @"biInfoCell";
static NSString *biModelInfoCollectionCell = @"biModelInfoCell";
static NSString *biDsrInfoCollectionCell = @"biDsrInfoCell";
static NSString *biDsrInfoHeader = @"biDsrInfoHeader";
static NSString *biDsrInfoFooter = @"biDsrInfoFooter";
static NSString *noramlHeader = @"normalHeader";
static NSString *normalFooter = @"normalFooter";
static NSString *biAddInfoCollectionCell = @"biAddInfoCell";

@interface SYLSecondHomePageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong)UINavigationBar *navigatioBar;

@property (nonatomic, strong) UICollectionView *mainView;
@property (nonatomic, strong) FNHomeViewModel *homeVM ;
//@property (nonatomic, strong) FNHomeService *server;

@property (nonatomic, strong) UIImageView *storeImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) FNStoreCollectionViewCell *selectedBiInfoCell;
@property (nonatomic, assign) BOOL autoRefreshed;

@property (nonatomic, assign) BOOL isCanSort;//是否支持排序功能
@property (nonatomic, strong) NSMutableArray *rowSeparatorArray;
@property (nonatomic, strong) NSMutableArray *columnSeparatorArray;
@property (nonatomic, strong) NSMutableArray *cellAttributesArray;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) NSIndexPath *finalToIndexPath;
@property (nonatomic, strong) NSIndexPath *didSelectedIndexPath;
@property (nonatomic, assign) NSInteger changedCount;
@property (nonatomic, assign) BOOL isChanged;//判断长按后的cell的位置是否发生了变化
@property (nonatomic, strong) FNHomeCoverView *coverView;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation SYLSecondHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //去除状态栏的20对mainView的影响
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.autoRefreshed = NO;
    //    [self initTabBarRequest];
    
    [self setUpNotification];
    
    [self setupMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(instancetype)init
{
    if (self = [super init]) {
        _cellAttributesArray = @[].mutableCopy;
        _rowSeparatorArray = @[].mutableCopy;
        _columnSeparatorArray = @[].mutableCopy;
        _isCanSort = YES;
        _isChanged = NO;
        _changedCount = 1;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initRequest];
    
    //添加自定义navigationBar
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController.view addSubview:self.navigatioBar];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //去掉自定义navigationBar
    //    [_coverView close];
    if (self.selectedBiInfoCell) {
        self.selectedBiInfoCell.transform = CGAffineTransformIdentity;
        self.selectedBiInfoCell.center = [self.mainView layoutAttributesForItemAtIndexPath:self.finalToIndexPath].center;
        [self saveSortInfoBySection:self.selectedIndexPath.section];
        [self.selectedBiInfoCell setHidenIcon:YES];
        self.selectedIndexPath = nil;
        self.finalToIndexPath = nil;
        self.selectedBiInfoCell = nil;
    }
    //    [self cancelTap];
    self.navigationController.navigationBarHidden = NO;
    [self.navigatioBar removeFromSuperview];
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - Custom Accessors

-(UINavigationBar *)navigatioBar
{
    if (!_navigatioBar) {
        _navigatioBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 90)];
        _navigatioBar.tag = 100001;
        //        _navigatioBar.tintColor = [UIColor fn_color:FNColor_main_color];
        //        _navigatioBar.barTintColor = [UIColor fn_color:FNColor_main_color];
        //        [_navigatioBar setBackgroundColor:[UIColor fn_color:FNColor_main_color]];
        //
        UIImageView *outerStoreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 28, 54, 54)];
        [outerStoreImageView setImage:[UIImage imageNamed:@"iconfeiniu_bg"]];
        
        UIImageView *storeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 50, 50)];
        
        storeImageView.backgroundColor = [UIColor whiteColor];
        storeImageView.layer.masksToBounds = YES;
        storeImageView.layer.cornerRadius = 50/2;
        //没有这个色，再调
        //        storeImageView.layer.borderColor = [UIColor fn_color:FNColor_background_color].CGColor;
        //        storeImageView.layer.borderWidth = 4;
        //        [storeImageView setImage:[UIImage imageNamed:@"icon_feiniu"]];
        [storeImageView sd_setImageWithURL:[NSURL URLWithString:self.homeVM.store.iconImageUrl] placeholderImage:[UIImage imageNamed:@"icon_feiniu"]];
        [outerStoreImageView addSubview:storeImageView];
        [_navigatioBar addSubview:outerStoreImageView];
        _storeImageView = storeImageView;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(12 + 54 + 7.5f, 28  , kScreenWidth -(12 + 54 + 7.5f) , 54)];
        [nameLabel setFont: [UIFont systemFontOfSize:14]];
        //        [nameLabel setTextColor:[UIColor fn_color:FNColor_white]];
        [nameLabel setText:self.homeVM.store.shopName];
        nameLabel.numberOfLines = 1;
        [nameLabel setTextAlignment:NSTextAlignmentLeft];
        [_navigatioBar addSubview:nameLabel];
        
        //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTap)];
        //        tap.cancelsTouchesInView = NO;
        ////        tap.delegate = self;
        //        [_navigatioBar addGestureRecognizer:tap];
        _nameLabel = nameLabel;
        
    }
    
    return _navigatioBar;
}

//-(FNHomeService *)server
//{
//    if (!_server) {
//        _server = [[FNHomeService alloc] init];
//    }
//    return _server;
//}




-(UICollectionView *)mainView
{
    if (!_mainView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //    layout.minimumLineSpacing = 0.0;
        
        layout.minimumInteritemSpacing = 0.0;
        layout.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
        
        CGFloat tabbarHeight = [self.tabBarController tabBar].frame.size.height ;
        _mainView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 90, kScreenWidth, kScreenHeight -90 -tabbarHeight) collectionViewLayout:layout];
        
        _mainView.delegate = self;
        _mainView.dataSource = self;
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.showsVerticalScrollIndicator = NO;
        _mainView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight -90 -tabbarHeight +1);
        [_mainView registerClass:[FNStoreBiInfoCollectionViewCell class] forCellWithReuseIdentifier:biInfoCollectionCell];
        [_mainView registerNib:[UINib nibWithNibName:@"FNStoreAddBiInfoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:biAddInfoCollectionCell];
        
        [_mainView registerClass:[FNStoreManagementInfoCollectionViewCell class] forCellWithReuseIdentifier:biModelInfoCollectionCell];
        
        [_mainView registerNib:[UINib nibWithNibName:@"FNStoreDsrInfosCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:biDsrInfoCollectionCell];
        
        [_mainView registerNib:[UINib nibWithNibName:@"FNStoreDsrInfoHeaderReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:biDsrInfoHeader];
        [_mainView registerNib:[UINib nibWithNibName:@"FNDsrInfoFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:biDsrInfoFooter];
        
        [_mainView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:noramlHeader];
        
        [_mainView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:normalFooter];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesture:)];
        //        longPress.cancelsTouchesInView = NO;
        longPress.delegate = self;
        longPress.minimumPressDuration = 2;
        [_mainView addGestureRecognizer:longPress];
        
        
    }
    return _mainView;
}

-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        CGFloat tabbarHeight = [self.tabBarController tabBar].frame.size.height ;
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 90, kScreenWidth, kScreenHeight -90 -tabbarHeight)];
        _scrollView = scrollView;
        _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight -90 -tabbarHeight + 1);
        _scrollView.showsVerticalScrollIndicator = NO;
        
    }
    return _scrollView;
}
#pragma mark - Private
-(void)useCache
{
    
    
}
-(void)setUpNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(biSettingVisibleChange:) name:FNBiSettingVisibleChange object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modelSettingVisibleChange:) name:FNManagementSettingVisibleChange object:nil];
    
}

-(void)logout:(NSNotification *)notify
{
    self.autoRefreshed = NO;
    if (self.didSelectedIndexPath) {
        self.didSelectedIndexPath = nil;
    }
}

-(void)biSettingVisibleChange:(NSNotification *)notify
{
    
}

-(void)modelSettingVisibleChange:(NSNotification *)notify
{
    
}

-(void)initRequest
{
    WS(weakSelf);
    [self cancelTap];
    NSData *data = [NSData dataNamed:@"HomeData.json"];
    
    NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    FNHomeInfoModel *responseModel = [MTLJSONAdapter modelOfClass:[FNHomeInfoModel class] fromJSONDictionary:dataDict error:nil ];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (responseModel.bi.dataList != nil) {
            weakSelf.homeVM.biInfoArray = [responseModel.bi.dataList mutableCopy];
        }
        
        if (responseModel.dsr.dataList !=nil) {
            weakSelf.homeVM.dsrInfoArray = [responseModel.dsr.dataList mutableCopy];
        }else
        {
            weakSelf.homeVM.dsrInfoArray = @[].mutableCopy;
        }
        if (responseModel.manage.dataList != nil) {
            weakSelf.homeVM.modelInfoArray = [responseModel.manage.dataList mutableCopy];
            
        }
        
        weakSelf.homeVM.store = responseModel.store;
        [weakSelf initNavigationInfo];
        
        
        if (weakSelf.homeVM.biInfoArray.count ==0 &&weakSelf.homeVM.dsrInfoArray.count ==0 &&weakSelf.homeVM.modelInfoArray.count ==0) {
            
        }else
        {
            weakSelf.scrollView.hidden = YES;
            
            [weakSelf.homeVM calculateLayoutInfo];
            
            [weakSelf.mainView reloadData];
            //                [weakSelf addLineToSuperView:weakSelf.mainView withArray:weakSelf.homeVM.biInfoArray];
            
        }
        
        
    });
    
}


- (void)scanButtonClicked
{
    
}

- (void)setupMainView
{
    
    self.homeVM = [[FNHomeViewModel alloc] init];
    
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.scrollView];
    [self.view bringSubviewToFront:self.scrollView];
    
    //    _mainViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTap)];
    //    _mainViewTap.delegate = self;
    //    [self.mainView addGestureRecognizer:_mainViewTap];
}

-(void)initNavigationInfo
{
    [self.nameLabel setText:self.homeVM.store.shopName];
    [self.storeImageView sd_setImageWithURL:[NSURL URLWithString:self.homeVM.store.iconImageUrl] placeholderImage:[UIImage imageNamed:@"icon_feiniu"]];
    
}

- (void )longPressGesture:(UILongPressGestureRecognizer *)sender view:(UICollectionView *)mainView dataMutableArray:(NSMutableArray *)dataArray
{
    if (!_isCanSort) {
        return ;
    }
    
    
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [sender locationInView:mainView];
        self.selectedIndexPath = [mainView indexPathForItemAtPoint:point];
        if (self.selectedIndexPath.section == 0) {
            dataArray = self.homeVM.biInfoArray;
        }else if (self.selectedIndexPath.section == 2)
        {
            dataArray = self.homeVM.modelInfoArray;
        }
        //最后一个不能长按,section1不能长按
        if (self.selectedIndexPath.row == [dataArray count] || self.selectedIndexPath.section ==1) {
            //            sender.state == UIGestureRecognizerStateFailed;
            self.selectedIndexPath = nil;
            return;
        }
        //        DLog(@"我开始长按了");
        
        
        UICollectionViewCell *cell = [mainView cellForItemAtIndexPath:self.selectedIndexPath];
        [mainView bringSubviewToFront:cell];
        self.isChanged = NO;
        
        if (self.selectedBiInfoCell) {
            [self.selectedBiInfoCell setHidenIcon:YES];
            self.selectedBiInfoCell = nil;
        }
        
        FNStoreBiInfoCollectionViewCell *biInfoCell = (FNStoreBiInfoCollectionViewCell *)cell;
        [biInfoCell setHidenIcon:NO];
        self.selectedBiInfoCell = biInfoCell;
        self.selectedBiInfoCell.transform = CGAffineTransformMakeScale(1.1, 1.1);
        self.finalToIndexPath = self.selectedIndexPath;
        [self registerForKVO];
        
        
    }else if (sender.state == UIGestureRecognizerStateChanged){
        if (self.selectedIndexPath.section == 0) {
            dataArray = self.homeVM.biInfoArray;
        }else if (self.selectedIndexPath.section == 2)
        {
            dataArray = self.homeVM.modelInfoArray;
        }
        
        //最后一个不能长按,section1不能长按
        if (self.selectedIndexPath.row == [dataArray count] || self.selectedIndexPath.section ==1) {
            return;
        }
        [self.cellAttributesArray removeAllObjects];
        for (int i = 0;i < dataArray.count; i++) {
            [self.cellAttributesArray addObject:[mainView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:self.selectedIndexPath.section]]];
        }
        
        
        CGPoint locationPoint = [sender locationInView:mainView];
        self.selectedBiInfoCell.center = [sender locationInView:mainView];
        //考虑到有时移动cell时需要collecionview的上下滚动
        //        DLog(@"%@",self.cellAttributesArray);
        //        DLog(@"x%@",@(locationPoint.x));
        for (UICollectionViewLayoutAttributes *attributes in self.cellAttributesArray) {
            
            if (CGRectContainsPoint(attributes.frame,locationPoint) && (self.selectedIndexPath != attributes.indexPath)) {
                
                //对数组中存放的元素重新排序
                if (self.selectedIndexPath.section == attributes.indexPath.section) {
                    self.isChanged = YES;
                    
                    [dataArray moveObjectFromIndex:self.selectedIndexPath.item toIndex:attributes.indexPath.item];
                    
                    //                    if ([self.mainView cellForItemAtIndexPath:attributes.indexPath] != nil) {
                    [mainView moveItemAtIndexPath:self.selectedIndexPath toIndexPath:attributes.indexPath];
                    //                    }
                    self.selectedIndexPath = attributes.indexPath;
                    self.finalToIndexPath = attributes.indexPath;
                }
                
            }
        }
        
    }else if (sender.state == UIGestureRecognizerStateEnded ||sender.state == UIGestureRecognizerStateCancelled) {
        
        if (self.selectedIndexPath.section == 0) {
            
            dataArray = self.homeVM.biInfoArray;
            
        }else if (self.selectedIndexPath.section == 2)
        {
            dataArray = self.homeVM.modelInfoArray;
        }
        [self unregisterFromKVO];
        
        //修正导致contentOffset.y<0的问题.
        if (self.mainView.contentOffset.y
            < 0) {
            self.mainView.contentOffset = CGPointZero;
        }
        //最后一个不能长按,section1不能长按
        if (self.selectedIndexPath.row == [dataArray count] || self.selectedIndexPath.section ==1) {
            return;
        }
        DLog(@"selectedBiInfoCell%@selectedIndexPath%@",self.selectedBiInfoCell,self.selectedIndexPath);
        
        _changedCount ++;
        DLog(@"changeCount%@",@(_changedCount));
        if (self.selectedIndexPath.section == 0) {
            
            for (UIView *columnSeparator in _columnSeparatorArray) {
                [mainView bringSubviewToFront:columnSeparator];
            }
        }
        
        WS(weakSelf);
        [UIView animateWithDuration:0.4 animations:^{
            
            weakSelf.selectedBiInfoCell.transform = CGAffineTransformIdentity;
            weakSelf.selectedBiInfoCell.center = [mainView layoutAttributesForItemAtIndexPath:weakSelf.finalToIndexPath].center;
            
        } completion:^(BOOL finished) {
            
            
            if (!weakSelf.isChanged) {
                
                if (self.selectedIndexPath.section == 2) {
                    
                    
                }
                
            }else
            {
                [weakSelf.selectedBiInfoCell setHidenIcon:YES];
                weakSelf.selectedBiInfoCell = nil;
                
                //保存排序信息到服务器
                [weakSelf saveSortInfoBySection:self.selectedIndexPath.section];
                weakSelf.selectedIndexPath = nil;
                weakSelf.finalToIndexPath = nil;
            }
            
            
            
        }];
        
    }
}


-(void)collectionView:(UICollectionView *)collectionView clickedItemAtIndexPath:(NSIndexPath *)indexPath
{
    //如果当前有长按选中的item，则把长按选中的item设为nil，并且不跳转
    if (self.selectedBiInfoCell) {
        [self.selectedBiInfoCell setHidenIcon:YES];
        self.selectedBiInfoCell = nil;
        self.selectedIndexPath = nil;
        self.finalToIndexPath = nil;
        return;
    }
    //如果一个item被点击了，（在这个item跳转之前）不能同时点击第二个。
    if (self.didSelectedIndexPath) {
        //        self.didSelectedIndexPath = nil;
        return;
    }
    
    if (indexPath.section ==0) {
        
        
        if (indexPath.item == [self.homeVM.biInfoArray count]) {
            
            self.didSelectedIndexPath = indexPath;
            
            FNHomeSettingViewController *homeSettingVC = [[FNHomeSettingViewController alloc] initWithViewControllerStyle:FNHomeSettingViewControllerStyleBi];
            homeSettingVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:homeSettingVC animated:YES];
            //            self.didSelectedIndexPath = nil;
            
        }else
        {
            
        }
        
    }else if (indexPath.section ==2)
    {
        self.didSelectedIndexPath = indexPath;
        FNStoreManagementInfoCollectionViewCell *biModelInfoCell =(FNStoreManagementInfoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        biModelInfoCell.userInteractionEnabled = NO;
        
        __weak typeof(FNStoreManagementInfoCollectionViewCell *) weakBiModelInfoCell = biModelInfoCell;
        if ([biModelInfoCell.nameLabel.text isEqualToString:@"设置"]) {
            
            FNHomeSettingViewController *homeSettingVC = [[FNHomeSettingViewController alloc] initWithViewControllerStyle:FNHomeSettingViewControllerStyleManagement];
            homeSettingVC.hidesBottomBarWhenPushed = YES;
            
            biModelInfoCell.userInteractionEnabled = YES;
            [self.navigationController pushViewController:homeSettingVC animated:YES];
            
            //            self.didSelectedIndexPath = nil;
            
        }else
        {
            FNStoreManagementInfoModel *biModel =  self.homeVM.modelInfoArray[indexPath.item];
            
            FNGetPermissionInfoModel *permissionInfoModel = [[FNGetPermissionInfoModel alloc] init];
            permissionInfoModel.code = biModel.code;
            permissionInfoModel.name = biModel.name;
            
            
            
            FNHomeNoPermissionViewController *noPermissionVC = [[FNHomeNoPermissionViewController alloc] init];
            noPermissionVC.title = biModel.name;
            noPermissionVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:noPermissionVC animated:YES];
            //                    [weakSelf startProgressText:@"对不起，获取功能使用权限失败" delay:1];
            //                weakSelf.didSelectedIndexPath = nil;
            
            //            biModelInfoCell.userInteractionEnabled = YES;
            
        }
        
    }
}

-(void)addLineToSuperView:(UICollectionView *)mainView withArray:(NSArray *)dataArray{
    
    UIColor *lineColor = WhiteStringColor;
    NSInteger columnCount = 3;
    for (UIView *subView in _rowSeparatorArray) {
        [subView removeFromSuperview];
    }
    for (UIView *subView in _columnSeparatorArray) {
        [subView removeFromSuperview];
    }
    
    [_rowSeparatorArray removeAllObjects];
    [_columnSeparatorArray removeAllObjects];
    //横线需调整
    for (int i = 0; i < ([dataArray count]/columnCount + 1); i++) {
        UIView *rowSeparator = [[UIView alloc] init];
        rowSeparator.backgroundColor = lineColor;
        rowSeparator.frame = CGRectMake(0, (64 +0.5) *(i +1) -0.5 , kScreenWidth, 0.5);
        [mainView addSubview:rowSeparator];
        //        [mainView insertSubview:rowSeparator atIndex:1001+i];
        [_rowSeparatorArray addObject:rowSeparator];
    }
    //竖线
    
    for (int i = 0; i < ([dataArray count]/columnCount + 1); i++) {
        //行
        for (int j = 0; j < columnCount -1 ; j++) {
            //列
            //保证最后一个cell右面有竖线，而不是整个最后一行始终有两条竖线
            if (i == (NSInteger)[dataArray count]/columnCount) {// 最后一行
                if (j == ([dataArray count]%columnCount ) +1) {
                    
                    break;//跳出循环
                }
            }
            //添加竖线
            UIView *columnSeparator = [[UIView alloc] init];
            columnSeparator.tag = i*j;
            columnSeparator.backgroundColor = lineColor;
            //线的坐标x很重要。否则会被掩盖
            columnSeparator.frame = CGRectMake(floorf((kScreenWidth )/3) *(j + 1) , 12.5f + 64 *i, 0.4f, (64 - 25));
            [mainView addSubview:columnSeparator];
            //            [mainView insertSubview:columnSeparator atIndex:2001+i*j
            //             +1];
            [mainView bringSubviewToFront:columnSeparator];
            [_columnSeparatorArray addObject:columnSeparator];
        }
        
    }
    
}

#pragma mark - Private

-(void)cancelTap
{
    
    if (self.selectedBiInfoCell) {
        for (UIGestureRecognizer *recognizer in self.mainView.gestureRecognizers) {
            if ([recognizer isKindOfClass:[UILongPressGestureRecognizer class]]&&( recognizer.state == UIGestureRecognizerStateChanged )) {//当长按手势为change状态时不可单击
                //                break;
                return;
            }
        }
        
        [self.selectedBiInfoCell setHidenIcon:YES];
        self.selectedIndexPath = nil;
        self.finalToIndexPath = nil;
        self.selectedBiInfoCell = nil;
    }
}

-(void)saveSortInfoBySection:(NSInteger )section
{
    FNSaveBiSortParameterModel *biSortModel = [[FNSaveBiSortParameterModel alloc] init];
    
    biSortModel.sort = [self sortStringWithSection:section];
}

-(NSString *)sortStringWithSection:(NSInteger )section
{
    NSMutableString *sortString = [NSMutableString string];
    if (section ==0 ) {
        for (NSInteger i = 0 ; i< [self.homeVM.biInfoArray count]; i ++) {
            
            FNStoreBiInfoModel *biModel = self.homeVM.biInfoArray[i];
            if (i ==0) {
                [sortString appendString:biModel.code];
            }else
            {
                [sortString appendString:[NSString stringWithFormat:@",%@",biModel.code]];
            }
            
        }
    }else if (section ==2)
    {
        for (NSInteger i = 0 ; i< [self.homeVM.modelInfoArray count]; i ++) {
            
            FNStoreManagementInfoModel *managementModel = self.homeVM.modelInfoArray[i];
            if (i ==0) {
                [sortString appendString:managementModel.code];
            }else
            {
                [sortString appendString:[NSString stringWithFormat:@",%@",managementModel.code]];
            }
            
        }
    }
    
    return [sortString copy];
}

#pragma -mark action

- (void)longPressGesture:(UILongPressGestureRecognizer *)sender{
    //长按拖动排序
    //    DLog(@"state%@",sender);
    NSMutableArray *infoArray;
    //长按会走两次
    [self longPressGesture:sender view:self.mainView dataMutableArray:infoArray  ];
    
    
}

//-(void)bottomLongPressGesture:(UILongPressGestureRecognizer *)sender
//{
//
//    [self longPressGesture:sender superView:self.mainView dataMutableArray:self.homeVM.modelInfoArray section:2 ];
//
//}

#pragma mark -UICollectionViewDelegate  UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //三个全空才显示空白页
    if (self.homeVM.dsrInfoArray.count==0 && self.homeVM.biInfoArray.count ==0 && self.homeVM.modelInfoArray.count ==0) {
        
        return 0;
        
    }else
    {
        return 3;
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        return self.homeVM.biInfoArray.count +1;
    }else if (section == 1)
    {
        if (self.homeVM.dsrInfoArray==nil) {
            return 0;
        }else
        {
            return self.homeVM.dsrInfoArray.count;
            
        }
    }
    else
    {
        return self.homeVM.modelInfoArray.count +1;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.homeVM.cellSizeArrray[indexPath.section] CGSizeValue];
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return [self.homeVM.headerSizeArray[section] CGSizeValue];
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return [self.homeVM.footerSizeArray[section] CGSizeValue];
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.item == [self.homeVM.biInfoArray count] ) {
            
            FNStoreAddBiInfoCollectionViewCell *biAddInfoCell = [collectionView dequeueReusableCellWithReuseIdentifier:biAddInfoCollectionCell forIndexPath:indexPath];
            biAddInfoCell.userInteractionEnabled = YES;
            
            return biAddInfoCell;
            
        }else
        {
            FNStoreBiInfoCollectionViewCell *biInfoCell = [collectionView dequeueReusableCellWithReuseIdentifier:biInfoCollectionCell forIndexPath:indexPath];
            biInfoCell.userInteractionEnabled = YES;
            
            [biInfoCell setBiInfoModel:self.homeVM.biInfoArray[indexPath.item]];
            
            for (UIGestureRecognizer *gesture in _mainView.gestureRecognizers) {
                if ([gesture isKindOfClass:[UILongPressGestureRecognizer class]]) {
                    if (gesture.state == UIGestureRecognizerStatePossible) {
                        
                        if (self.selectedIndexPath && indexPath ==self.selectedIndexPath ) {
                            [biInfoCell setHidenIcon:NO];
                            self.selectedBiInfoCell = biInfoCell;
                        }else
                        {
                            [biInfoCell setHidenIcon:YES];
                        }
                        
                    }
                    //                    DLog(@"%@",[gesture state]);
                }
            }
            
            
            
            
            
            return biInfoCell;
            
        }
        
        
    }else if (indexPath.section ==1)
    {
        FNStoreDsrInfosCollectionViewCell *dsrInfoCell = [collectionView dequeueReusableCellWithReuseIdentifier:biDsrInfoCollectionCell forIndexPath:indexPath];
        [dsrInfoCell setDsrInfoModel:self.homeVM.dsrInfoArray[indexPath.item]];
        return dsrInfoCell;
        
    }
    else if (indexPath.section ==2)
    {
        
        FNStoreManagementInfoCollectionViewCell *biModelInfoCell = [collectionView dequeueReusableCellWithReuseIdentifier:biModelInfoCollectionCell forIndexPath:indexPath];
        
        
        if (indexPath.item == self.homeVM.modelInfoArray.count) {
            
            [biModelInfoCell setModelInfoModel:self.homeVM.lastManagementInfoModel];
            
        }else
        {
            [biModelInfoCell setModelInfoModel:self.homeVM.modelInfoArray[indexPath.item]];
            
            
        }
        biModelInfoCell.userInteractionEnabled = YES;
        //        biModelInfoCell.exclusiveTouch = YES;
        
        if (self.selectedIndexPath && indexPath ==self.selectedIndexPath ) {
            [biModelInfoCell setHidenIcon:NO];
            self.selectedBiInfoCell = biModelInfoCell;
        }else
        {
            [biModelInfoCell setHidenIcon:YES];
        }
        
        return biModelInfoCell;
    }
    return nil;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            
            FNStoreDsrInfoHeaderReusableView *dsrInfoHeaderView = (FNStoreDsrInfoHeaderReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:biDsrInfoHeader forIndexPath:indexPath];
            
            return dsrInfoHeaderView;
            
        }else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
        {
            FNDsrInfoFooterView *collectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:biDsrInfoFooter forIndexPath:indexPath];
            return collectionReusableView;
        }
        
    }else
    {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            
            UICollectionReusableView *collectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:noramlHeader forIndexPath:indexPath];
            
            return collectionReusableView;
            
        }else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
        {
            if (indexPath.section ==0) {
                UICollectionReusableView *collectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:normalFooter forIndexPath:indexPath];
                collectionReusableView.backgroundColor = BlackStringColor;
                
                
                return collectionReusableView;
                
            }else
            {
                UICollectionReusableView *collectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:normalFooter forIndexPath:indexPath];
                collectionReusableView.backgroundColor = WhiteStringColor;
                
                
                return collectionReusableView;
            }
            
        }
    }
    
    return nil;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //如果当前有长按选中的item，则把长按选中的item设为nil，并且不跳转
    if (self.selectedBiInfoCell) {
        [self.selectedBiInfoCell setHidenIcon:YES];
        self.selectedBiInfoCell = nil;
        self.selectedIndexPath = nil;
        self.finalToIndexPath = nil;
        return;
    }
    //如果一个item被点击了，（在这个item跳转之前）不能同时点击第二个。
    if (self.didSelectedIndexPath) {
                self.didSelectedIndexPath = nil;
        return;
    }
    
    if (indexPath.section ==0) {
        
        
        if (indexPath.item == [self.homeVM.biInfoArray count]) {
            
            self.didSelectedIndexPath = indexPath;
            
            FNHomeSettingViewController *homeSettingVC = [[FNHomeSettingViewController alloc] initWithViewControllerStyle:FNHomeSettingViewControllerStyleBi];
            homeSettingVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:homeSettingVC animated:YES];
            //            self.didSelectedIndexPath = nil;
            
        }else
        {
            
        }
        
    }else if (indexPath.section ==2)
    {
        self.didSelectedIndexPath = indexPath;
        FNStoreManagementInfoCollectionViewCell *biModelInfoCell =(FNStoreManagementInfoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        biModelInfoCell.userInteractionEnabled = NO;
        
        __weak typeof(FNStoreManagementInfoCollectionViewCell *) weakBiModelInfoCell = biModelInfoCell;
        if ([biModelInfoCell.nameLabel.text isEqualToString:@"设置"]) {
            
            FNHomeSettingViewController *homeSettingVC = [[FNHomeSettingViewController alloc] initWithViewControllerStyle:FNHomeSettingViewControllerStyleManagement];
            homeSettingVC.hidesBottomBarWhenPushed = YES;
            
            biModelInfoCell.userInteractionEnabled = YES;
            [self.navigationController pushViewController:homeSettingVC animated:YES];
            
            //            self.didSelectedIndexPath = nil;
            
        }else
        {
            FNStoreManagementInfoModel *biModel =  self.homeVM.modelInfoArray[indexPath.item];
            
            FNGetPermissionInfoModel *permissionInfoModel = [[FNGetPermissionInfoModel alloc] init];
            permissionInfoModel.code = biModel.code;
            permissionInfoModel.name = biModel.name;
            
            
            
            FNHomeNoPermissionViewController *noPermissionVC = [[FNHomeNoPermissionViewController alloc] init];
            noPermissionVC.title = biModel.name;
            noPermissionVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:noPermissionVC animated:YES];
            //                    [weakSelf startProgressText:@"对不起，获取功能使用权限失败" delay:1];
            //                weakSelf.didSelectedIndexPath = nil;
            
            //            biModelInfoCell.userInteractionEnabled = YES;
            
        }
        
    }
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section ==0) {
        return 0.5f;
    }else
    {
        return 0.0f;
    }
}

#pragma mark - KVO

- (void)registerForKVO {
    
    [self.selectedBiInfoCell addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    //    DLog(@"注册成功");
}

- (void)unregisterFromKVO {
    if (self.selectedBiInfoCell) {//5s中section==2的cell停留在navigationbar后面几秒钟松手kvo莫名被提前remove，所以再次重新添加修正
        //        if (self.selectedIndexPath.section ==2) {
        [self.selectedBiInfoCell addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
        //        }
        
        [self.selectedBiInfoCell removeObserver:self forKeyPath:@"center"];
    }
    
    
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"center"]) {
        
        CGPoint newCenter = [[change objectForKey:@"new"] CGPointValue];
        CGPoint oldCenter = [[change objectForKey:@"old"] CGPointValue];
        //cell相对于self.view的坐标
        CGPoint point = [self.mainView convertPoint:self.selectedBiInfoCell.frame.origin toView:self.mainView.superview];
        
        DLog(@"point%@",@(point.y));
        CGFloat scrollerValue = newCenter.y - oldCenter.y;
        CGPoint mainViewPoint = self.mainView.contentOffset;
        DLog(@"scrollerValue%@",@(scrollerValue));
        DLog(@"mainPointy%@x%@",@(mainViewPoint.y),@(mainViewPoint.x));
        DLog(@"self.mainView.contentOffset.y%@",@(self.mainView.contentOffset.y));
        
        //向上滚动的条件与向下滚动的条件
        if (((point.y <= 70.0)&&(mainViewPoint.y  > 0)&&(scrollerValue<0))||((point.y + self.selectedBiInfoCell.frame.size.height/2 >= kScreenHeight - 46.0)&&(mainViewPoint.y  + self.mainView.bounds.size.height<=self.mainView.contentSize.height )&&(scrollerValue>0)&&(mainViewPoint.y  >=0)&&(self.mainView.contentOffset.y  + self.mainView.bounds.size.height <=self.mainView.contentSize.height))) {
            
            CGPoint  viewPoint = CGPointMake(mainViewPoint.x, mainViewPoint.y + scrollerValue);
            self.mainView.contentOffset = viewPoint;
            
            if (self.mainView.contentOffset.y  + self.mainView.bounds.size.height >= self.mainView.contentSize.height )
            {
                self.mainView.contentOffset = CGPointMake(0, self.mainView.contentSize.height - self.mainView.bounds.size.height);
            }else if (mainViewPoint.y <= 0)
            {
                self.mainView.contentOffset = CGPointMake(0, 0);
            }
            
        }
        
        //首页长按上移时刷新控件漏出的问题的解决
        if (fabs(newCenter.y - oldCenter.y) > 0.5f && mainViewPoint.y <= 0) {
            self.mainView.contentOffset = CGPointMake(0, 0);
        }
        
    }
    
    
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
