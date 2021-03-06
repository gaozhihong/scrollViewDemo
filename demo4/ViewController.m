//
//  ViewController.m
//  demo4
//
//  Created by gzh on 2021/8/19.
//

#import "ViewController.h"
#import "BaseTypeTabCell.h"
#import "ATypeTabCell.h"
#import "UIColor+Extension.h"
#import <UIImageView+WebCache.h>

#define  SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

#define  SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

#define  Top_Vertical_Height  250
#define mc_Is_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define mc_Is_iphoneX SCREEN_WIDTH >=375.0f && SCREEN_HEIGHT >=812.0f&& mc_Is_iphone
    
/*底部安全区域远离高度*/
#define BottomSafeAreaHeight (CGFloat)(mc_Is_iphoneX?(34.0):(0))
//##获取导航条状态条高度 ##
#define GetRectNavAndStatusHight \
({\
    CGFloat statusBar_height =0; \
    if (@available(iOS 13.0, *)) { \
    UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager; \
     statusBar_height = statusBarManager.statusBarFrame.size.height; \
    }else{  \
        statusBar_height =[UIApplication sharedApplication].statusBarFrame.size.height;\
    } ;\
    CGRect rectNav = self.navigationController.navigationBar.frame;\
    ( statusBar_height + rectNav.size.height);\
})\

@interface ViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>{
     
}

@property(nonatomic,strong)UIScrollView *mainScrollV;

@property(nonatomic,strong)UIScrollView *childScrollV;

@property(nonatomic,strong)UIView *menuView;

@property(nonatomic,strong) UIView *smallMoveLine; //小滑动条

@property(nonatomic, strong)NSMutableArray *btnsMutArr; //

@property(nonatomic, strong)UIButton *previousBtn; //记录上一个view
@end

@implementation ViewController{
//    UIScrollView *_mainScrollV;
//
//    UIScrollView *_chidScrollV;
    
    UITableView *_firstTabV; //
    
    UITableView *_secondTabV; //
    
}

+ (CGFloat)getStatusBarHight {
   float statusBarHeight = 0;
   if (@available(iOS 13.0, *)) {
       UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
       statusBarHeight = statusBarManager.statusBarFrame.size.height;
   }else {
       statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
   }
   return statusBarHeight;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     //写完这个Demo 后天研究数据可视化
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    if (@available(iOS 13.0, *)) {
        NSLog(@" 13 ==");
    }else{
        NSLog(@"小于13  ");
    }
   
    self.view.backgroundColor =[ UIColor lightGrayColor];
   
    
    self.title = @"ScrollDemoTest";
    
    [self setupMainScrollV];
    
}

-(void)setupMainScrollV{
    _mainScrollV = [[UIScrollView alloc] init];
    
    NSLog(@"%@",NSStringFromCGRect(self.view.bounds));
    
    _mainScrollV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-GetRectNavAndStatusHight-BottomSafeAreaHeight);
    
    _mainScrollV.backgroundColor = [UIColor linkColor];
    
    _mainScrollV.scrollEnabled = YES;
    
    _mainScrollV.contentSize = CGSizeMake(0, _mainScrollV.bounds.size.height);
    
    _mainScrollV.delegate = self;
    
    [self.view addSubview:_mainScrollV];

    UILabel * lab= [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 200, 40)];
    
    lab.text = @"人生在世不称意";
    
    lab.textAlignment = NSTextAlignmentCenter;
    
    [_mainScrollV addSubview:lab];
     //TopView
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Top_Vertical_Height)];
    
    topView.backgroundColor = [UIColor cz_colorWithHex:0xFFFFFF];
    
    NSString *atImgUrl = @"https://img1.baidu.com/it/u=2491541248,154379013&fm=15&fmt=auto&gp=0.jpg";
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:topView.bounds];
    
    [imgV sd_setImageWithURL:[NSURL URLWithString:atImgUrl] placeholderImage:[UIImage new] options:(SDWebImageRefreshCached)];
    
    [topView addSubview:imgV];
    
    [_mainScrollV addSubview:topView];
    
    [topView addSubview:self.menuView];
    
    [_mainScrollV addSubview:self.childScrollV];
    
}



#pragma mark -- 交互
-(void)btnTap:(UIButton*)sender{
    [_previousBtn setTitleColor:[UIColor linkColor] forState:(UIControlStateNormal)];
    
    NSInteger  curIndex =(NSInteger)sender.tag;

    [_childScrollV setContentOffset:CGPointMake(curIndex *SCREEN_WIDTH, 0) animated:YES];
    
    CGPoint  cen =  _smallMoveLine.center;
    
    cen.x = sender.center.x;
    
    [UIView animateWithDuration:0.05 animations:^{
        self->_smallMoveLine.center = cen;
    }];
    
    [sender setTitleColor:[UIColor greenColor] forState:(UIControlStateNormal)];
    _previousBtn  = sender;
    
    
}

#pragma mark -- scrollV delgate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ( [scrollView isKindOfClass:UITableView.class]) {
        NSLog(@"offset_y == %f",scrollView.contentOffset.y);
        if (scrollView.contentOffset.y > 0 ) {
          
            CGFloat tab_offset_y = scrollView.contentOffset.y;
            
            _mainScrollV.contentOffset = CGPointMake(0,  _mainScrollV.contentOffset.y + tab_offset_y);
            
            if (_mainScrollV.contentOffset.y > 200) {
                _mainScrollV.contentOffset = CGPointMake(0, 200);
                return;
            }
            scrollView.contentOffset = CGPointZero;
            
        }else{
            _mainScrollV.contentOffset = CGPointMake(0, _mainScrollV.contentOffset.y +scrollView.contentOffset.y);
            
            if (_mainScrollV.contentOffset.y < 0) {
                _mainScrollV.contentOffset = CGPointZero;
            }
            
        }
       
        
        
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _childScrollV) {
       
        NSInteger curIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
        UIView *view = [self.btnsMutArr objectAtIndex:curIndex];
        
        CGPoint center = _smallMoveLine.center;
        
        center.x = view.center.x ;
        
        [UIView animateWithDuration:0.05 animations:^{
           self->_smallMoveLine.center = center;
        }];;
        
        [_previousBtn setTitleColor:[UIColor linkColor] forState:(UIControlStateNormal)];
        
        [(UIButton*)view setTitleColor:[UIColor greenColor] forState:(UIControlStateNormal)];
        _previousBtn  = (UIButton*)view;
    }
}
 //设置小滑动条
-( void)setupMoveLineWithLength:(CGFloat)length{
    if (!_smallMoveLine) {
        return;
    }
    CGRect  vFrame= CGRectMake(0, 0, length, 1);
    
    _smallMoveLine = [[UIView alloc] initWithFrame:vFrame];
    
    _smallMoveLine.backgroundColor =[UIColor greenColor];
    
}
#pragma mark --lazy
-(UIView *)menuView{
    if (!_menuView) {
        CGFloat viewH = 50;
        _menuView =[[UIView alloc] initWithFrame:CGRectMake(0, Top_Vertical_Height-viewH, SCREEN_WIDTH ,viewH)];
        
        _menuView.backgroundColor =[UIColor cz_colorWithHex:0xFDF5E6];
        _btnsMutArr =[NSMutableArray array];
        
        NSArray *titles = @[@"page1",@"page2",@"page3"];
        
        CGFloat margin_x =15;
        CGFloat perW = (SCREEN_WIDTH -4*margin_x)/3;
        CGFloat x = 0;
        for (int i=0; i <titles.count; i++) {
            UIButton *btn =[[UIButton alloc] init];
            x = margin_x + i*(margin_x + perW);
            
            btn.frame = CGRectMake(x, 0,perW , 50);
            
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            [btn setTitleColor:[UIColor linkColor] forState:(UIControlStateNormal)];
            
            btn.tag = i;
            
            [btn setTitle:titles[i] forState:(UIControlStateNormal)];
            [btn addTarget:self action:@selector(btnTap:) forControlEvents:(UIControlEventTouchUpInside)];
            [_menuView addSubview:btn];
            
            [_btnsMutArr addObject:btn];
            
        } //
        //
       CGRect  vFrame= CGRectMake(0,viewH -1 , perW , 1);
       
       _smallMoveLine = [[UIView alloc] initWithFrame:vFrame];
       
       _smallMoveLine.backgroundColor =[UIColor greenColor];
        
        [_menuView addSubview:_smallMoveLine];
        
        [self btnTap: _btnsMutArr.firstObject];
    }
    
    return _menuView;
}
-(UIScrollView *)childScrollV{
    if (!_childScrollV) {
        CGFloat h0 =  SCREEN_HEIGHT-GetRectNavAndStatusHight -BottomSafeAreaHeight -50;
        
        _childScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, Top_Vertical_Height, SCREEN_WIDTH, h0)];
        _childScrollV.contentSize = CGSizeMake(3*SCREEN_WIDTH, 0);
        _childScrollV.scrollEnabled = YES;
        
        _childScrollV.delegate = self;
        
        _childScrollV.pagingEnabled = YES;
        
        for (int i=0; i<3; i++) {
            UITableView *tabV = [self singleTableView];
            
            tabV.frame = CGRectMake(i *SCREEN_WIDTH, 0 ,SCREEN_WIDTH, _childScrollV.bounds.size.height);
            
            [_childScrollV addSubview:tabV];
            
            if (i == 0 ) {
                _firstTabV = tabV;
            }else if(i ==1){
                _secondTabV = tabV;
            }
        }
    }
    return _childScrollV ;
}

-(UITableView*)singleTableView{
    UITableView *tabV= [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    
    tabV.delegate = self;
    tabV.dataSource = self;
    
    [tabV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    [tabV registerClass:BaseTypeTabCell.class forCellReuseIdentifier:@"BaseTypeTabCell"];
    
    [tabV registerClass: ATypeTabCell.class forCellReuseIdentifier:@"ATypeTabCell"];
    
    return  tabV;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _firstTabV) {
        return 120;
    }else if(tableView == _secondTabV){
        return  250 ;
    }else{
        return 80;
    }
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20 ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ( tableView == _firstTabV) {
        BaseTypeTabCell *cell  = [ tableView dequeueReusableCellWithIdentifier:@"BaseTypeTabCell"];
        NSString *url0=  @"https://img0.baidu.com/it/u=696007388,1161768643&fm=26&fmt=auto&gp=0.jpg";
        
        NSString *url1 = @"https://img2.baidu.com/it/u=1460337559,461722240&fm=26&fmt=auto&gp=0.jpg";
        cell.picUrl = indexPath.row %2 == 0 ? url0 : url1;
        
        return cell;
    }else if(tableView == _secondTabV){
        ATypeTabCell *cell  = [ tableView dequeueReusableCellWithIdentifier:@"ATypeTabCell"];
        
        NSString *url0= @"https://img1.baidu.com/it/u=2579940132,1296036844&fm=11&fmt=auto&gp=0.jpg";
        cell.imgUrl = url0;
        
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%ld-- ",indexPath.row];
        
        return cell;
    }
    return nil;
    
}



@end
