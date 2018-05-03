//
//  MKAreaPickerView.m
//  PickerView省市区三级联动
//
//  Created by 原鹏飞 on 2017/2/18.
//  Copyright © 2017年 Miku. All rights reserved.
//

#import "MKAreaPickerVC.h"
#import "ProvinceModel.h"
#import <YYModel.h>

@interface MKAreaPickerVC ()<UIPickerViewDataSource,UIPickerViewDelegate>

//地理选择器
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

//按钮栏的背景视图
@property (weak, nonatomic) IBOutlet UIView *btnBGView;

//取消按钮
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

//确定按钮
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;



//只装省份的数组
@property(nonatomic,strong) NSMutableArray *ProvinceAry;

//只装城市的数组
@property(nonatomic,strong) NSMutableArray *CityAry;

//只装区的数组（还有县）
@property(nonatomic,strong) NSMutableArray *DistrictAry;

//用于记录选中哪个省的索引
@property (nonatomic, assign) NSInteger proIndex;

//用于记录选中哪个省的索引
@property (nonatomic, assign) NSInteger cityIndex;

//用于记录选中哪个区的索引
@property (nonatomic, assign) NSInteger districtIndex;

@property (nonatomic, assign) NSInteger selectedRow;

//模型数组
@property (nonatomic, strong) NSMutableArray *locationArr;

@end

@implementation MKAreaPickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    
    //准备三个保存省市区模型的数组
    _ProvinceAry = [NSMutableArray array];
    _CityAry = [NSMutableArray array];
    _DistrictAry = [NSMutableArray array];
    
    
    //默认选中0组0行
    [self pickerView:_pickerView didSelectRow:0 inComponent:0];
    [self pickerView:_pickerView didSelectRow:0 inComponent:1];
    [self pickerView:_pickerView didSelectRow:0 inComponent:2];
    
}

#pragma mark - UI相关

- (void)setupUI {
    
    //设置半透明遮罩背景色
    self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7f];
    
    [self myAddConstraints];
}

/**
 设置子控件的约束
 */
- (void)myAddConstraints {
    
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(APPWidth * 0.576);  //216
    }];
    
    [_btnBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.pickerView.mas_top);
        make.height.mas_equalTo(APPWidth * 0.096);  //36
    }];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.btnBGView);
        make.left.equalTo(self.view).offset(APPWidth * 0.048);  //18
        make.height.mas_equalTo(APPWidth * 0.08);   //30
        make.width.mas_equalTo(APPWidth * 0.12);    //45
    }];
    
    [_doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.btnBGView);
        make.right.equalTo(self.view).offset(- APPWidth * 0.048);  //18
        make.height.mas_equalTo(APPWidth * 0.08);   //30
        make.width.mas_equalTo(APPWidth * 0.12);    //45
    }];
}

#pragma mark - 点击事件

- (IBAction)cancelBtnClick:(id)sender {
    NSLog(@"取消");
    
    if(self.cancelBlock){
        self.cancelBlock();
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)doneBtnClick:(id)sender {
    
    NSLog(@"完成");
    
    // 如果 label 没值就 return
    if (_proStr.length == 0 && _cityStr.length == 0 && _districtStr.length == 0) {
        return;
    }
    
    // 利用 block 传值出去
    if(self.doneBlock){
        
        self.doneBlock(self.regionDict);
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}


#pragma mark - UIPickViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        
        //记录第一列 有多少行--也就是省的个数
        _proIndex = row;
        _cityIndex = 0;
        _districtIndex = 0;
        
        //遍历出城市名字保存到数组--最后装了全部的市
        ProvinceModel *provM = self.locationArr[_proIndex];
        for (CityModel *cityM in provM.data) {
            [_CityAry addObject:cityM.name];
        }
        //刷新第二列数据
        [pickerView reloadComponent:1];
        //选择第二列的第一行
        [pickerView selectRow:0 inComponent:1 animated:YES];
        
        
        //取出对应省的第一个市模型，遍历出对应的区的名字保存起来---这里最好装了全部的区
        CityModel *cityM = provM.data[0];
        for (DistrictModel *distM in cityM.data) {
            [_DistrictAry addObject:distM.name];
        }
        //刷新第三列数据
        [pickerView reloadComponent:2];
        //选择第三列的第一行
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
        //取出对应省的第一个市的第一个区
        ProvinceModel *selProM = self.locationArr[_proIndex];
        CityModel *selCityM = selProM.data[0];
        DistrictModel *selDistM = selCityM.data[0];
        
        //拿到id
        self.proID = [selProM.id integerValue];
        self.cityID = [selCityM.id integerValue];
        self.districtID = [selDistM.id integerValue];
        
        //拿到字符串
        self.proStr = selProM.name;
        self.cityStr = selCityM.name;
        self.districtStr = selDistM.name;
        
        //生成字典
        self.regionDict = @{@"proID":@(_proID),
                            @"cityID":@(_cityID),
                            @"districtID":@(_districtID),
                            @"proStr":_proStr,
                            @"cityStr":_cityStr,
                            @"districtStr":_districtStr
                            };
    }
    else if (component == 1) {
        
        _cityIndex = row;
        _districtIndex = 0;
        
        //根据滑动省份列是记录的省份,根据row获取
        ProvinceModel *provM = self.locationArr[_proIndex];
        CityModel *cityM = provM.data[row];
        for (DistrictModel *distM in cityM.data) {
            [_DistrictAry addObject:distM.name];
        }
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
        //赋值
        ProvinceModel *selProM = self.locationArr[_proIndex];
        CityModel *selCityM = selProM.data[_cityIndex];
        DistrictModel *selDistM = selCityM.data[_districtIndex];
        
        //拿到id
        self.proID = [selProM.id integerValue];
        self.cityID = [selCityM.id integerValue];
        self.districtID = [selDistM.id integerValue];
        
        //拿到字符串
        self.proStr = selProM.name;
        self.cityStr = selCityM.name;
        self.districtStr = selDistM.name;
        
        //生成字典
        self.regionDict = @{@"proID":@(_proID),
                            @"cityID":@(_cityID),
                            @"districtID":@(_districtID),
                            @"proStr":_proStr,
                            @"cityStr":_cityStr,
                            @"districtStr":_districtStr
                            };
    }
    
    else if (component == 2) {
        
        _districtIndex = row;
        
        //赋值
        ProvinceModel *selProM = self.locationArr[_proIndex];
        CityModel *selCityM = selProM.data[_cityIndex];
        DistrictModel *selDistM = selCityM.data[_districtIndex];
        
        //拿到id
        self.proID = [selProM.id integerValue];
        self.cityID = [selCityM.id integerValue];
        self.districtID = [selDistM.id integerValue];
        
        //拿到字符串
        self.proStr = selProM.name;
        self.cityStr = selCityM.name;
        self.districtStr = selDistM.name;
        
        //生成字典
        self.regionDict = @{@"proID":@(_proID),
                            @"cityID":@(_cityID),
                            @"districtID":@(_districtID),
                            @"proStr":_proStr,
                            @"cityStr":_cityStr,
                            @"districtStr":_districtStr
                            };
    }
}

#pragma mark - UIPickViewDataSource

// 有几列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}

// 每列有几行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component==0) {
        
        return self.locationArr.count;
    } else if (component == 1) {
        ProvinceModel *provM = self.locationArr[_proIndex];
        
        return provM.data.count;
    } else if (component == 2) {
        ProvinceModel *provM = self.locationArr[_proIndex];
        CityModel *cityM = provM.data[_cityIndex];
        
        return cityM.data.count;
    }
    
    return 0;
}

// 告诉pickerView每一行要显示什么内容
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
        
        ProvinceModel *provM = self.locationArr[row];
        return provM.name;
        
    }
    else if (component == 1){
        
        ProvinceModel *provM = self.locationArr[_proIndex];
        
        CityModel *cityM = provM.data[row];
        
        return cityM.name;
        
    }
    else if (component == 2){
        ProvinceModel *provM = self.locationArr[_proIndex];
        CityModel *cityM = provM.data[_cityIndex];
        DistrictModel *distM = cityM.data[row];
        
        return distM.name;
        
    }
    
    return nil;
}


#pragma mark - 懒加载

/**
 加载省市区数据
 
 @return 保存省市区地址信息的可变数组
 */
- (NSMutableArray *)locationArr {
    
    if (!_locationArr) {
        
        //创建用来保存地址信息的空数组（可变）
        _locationArr  = [[NSMutableArray alloc] init];
        
        //加载全部省市区数据
        NSString *path = [[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSError *error = nil;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        for (NSDictionary *dic in jsonObj) {
            //因为我在每个模型里面都使用了modelContainerPropertyGenericClass来解析嵌套模型。
            ProvinceModel *model = [ProvinceModel yy_modelWithDictionary:dic];
            NSLog(@"%@",model.name);
            [_locationArr addObject:model];
        }
    }
    
    return _locationArr;
}


#pragma mark - dealloc

-(void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
