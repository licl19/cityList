//
//  ViewController.m
//  CitySelected
//
//  Created by sankai on 16/12/8.
//  Copyright © 2016年 sankai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) UIPickerView *pickerViewProvince;
@property (nonatomic,strong) UIPickerView *pickerViewCity;
@property (nonatomic,strong) UIPickerView *pickerViewArea;

@property (nonatomic,strong) NSMutableArray *provinces;
@property (nonatomic,strong) NSMutableDictionary *citiesDic;
@property (nonatomic,strong) NSMutableDictionary *areasDic;

@property (nonatomic,copy) NSString *provinceSelected;
@property (nonatomic,copy) NSString *citySelected;
@property (nonatomic,copy) NSString *areaSelected;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"province&city&area.plist" ofType:nil];
    //    NSDictionary *dicProvince = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *arrProvince = [NSArray arrayWithContentsOfFile:path];
    
//    if (!_provinceChoose) {
        _provinceSelected = @"北京市";
//        _provinceSelectedCode = @"110000";
        _citySelected = @"北京市";
//        _citySelectedCode = @"110100";
        _areaSelected = @"东城区";
//        _areaSelectedCode = @"110101";
//    }else{
//        _provinceSelected = _provinceChoose;
//        _provinceSelectedCode = _provinceChooseCode;
//        _citySelected = _cityChoose;
//        _citySelectedCode = _cityChooseCode;
//        _areaSelected = _areaChoose;
//        _areaSelectedCode = _areaChooseCode;
//    }
    
    
    _provinces =[NSMutableArray arrayWithCapacity:0];
    _citiesDic = [NSMutableDictionary dictionaryWithCapacity:0];
    _areasDic = [NSMutableDictionary dictionaryWithCapacity:0];
//    _provinceCodes =[NSMutableArray arrayWithCapacity:0];
//    _citiesCodeDic = [NSMutableDictionary dictionaryWithCapacity:0];
//    _areasCodeDic = [NSMutableDictionary dictionaryWithCapacity:0];
    for (NSInteger i = 0; i < arrProvince.count; i ++) {
        //        NSDictionary *dicProvince = arrProvince[i];
        NSDictionary *province = arrProvince[i];
        NSMutableArray *cities = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *citiCodees = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *city in [province valueForKey:@"citylist"]) {
            NSMutableArray *areaArr = [NSMutableArray arrayWithCapacity:0];
            NSMutableArray *areaCodeArr = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *area in [city valueForKey:@"arealist"]) {
                [areaArr addObject:[area valueForKey:@"name"]];
                [areaCodeArr addObject:[area valueForKey:@"code"]];
            }
            [_areasDic setObject:areaArr forKey:[city valueForKey:@"name"]];
//            [_areasCodeDic setObject:areaCodeArr forKey:[city valueForKey:@"code"]];
            [cities addObject:[city valueForKey:@"name"]];
            [citiCodees addObject:[city valueForKey:@"code"]];
        }
        [_citiesDic setObject:cities forKey:[province valueForKey:@"name"]];
//        [_citiesCodeDic setObject:citiCodees forKey:[province valueForKey:@"code"]];
        NSLog(@"%@",[province valueForKey:@"name"]);
        [_provinces addObject:[province valueForKey:@"name"]];
//        [_provinceCodes addObject:[province valueForKey:@"code"]];
        NSLog(@"\n\n\n");
    }

    
    
    
    
    
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"Province&City&District.plist" ofType:nil];
//    NSDictionary *dicProvince = [NSDictionary dictionaryWithContentsOfFile:path];
//
//    _provinceSelected = @"北京市";
//    _citySelected = @"北京市";
//    _areaSelected = @"东城区";
//    
//    _provinces =[NSMutableArray arrayWithCapacity:0];
//    _citiesDic = [NSMutableDictionary dictionaryWithCapacity:0];
//    _areasDic = [NSMutableDictionary dictionaryWithCapacity:0];
//    for (NSInteger i = 0; i < 34; i ++) {
//        NSDictionary *province = [dicProvince valueForKey:[NSString stringWithFormat:@"%ld",i]];
//        NSMutableArray *cities = [NSMutableArray arrayWithCapacity:0];
//        for (NSDictionary *city in [province valueForKey:[province valueForKey:@"name"]]) {
//            NSMutableArray *areaArr = [NSMutableArray arrayWithCapacity:0];
//            for (NSDictionary *area in [city valueForKey:[city valueForKey:@"name"]]) {
//                [areaArr addObject:[area valueForKey:@"name"]];
//            }
//            [_areasDic setObject:areaArr forKey:[city valueForKey:@"name"]];
//            [cities addObject:[city valueForKey:@"name"]];
//        }
//        [_citiesDic setObject:cities forKey:[province valueForKey:@"name"]];
//        NSLog(@"%@",[province valueForKey:@"name"]);
//        [_provinces addObject:[province valueForKey:@"name"]];
//        NSLog(@"\n\n\n");
//    }
    
    
    _pickerViewProvince = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/3, self.view.bounds.size.height)];
    _pickerViewProvince.delegate = self;
    _pickerViewProvince.dataSource = self;
    [self.view addSubview:_pickerViewProvince];
    
    _pickerViewCity = [[UIPickerView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/3, 0, self.view.bounds.size.width/3, self.view.bounds.size.height)];
    _pickerViewCity.delegate = self;
    _pickerViewCity.dataSource = self;
    [self.view addSubview:_pickerViewCity];
    
    _pickerViewArea = [[UIPickerView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/3*2, 0, self.view.bounds.size.width/3, self.view.bounds.size.height)];
    _pickerViewArea.delegate = self;
    _pickerViewArea.dataSource = self;
    [self.view addSubview:_pickerViewArea];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView == _pickerViewProvince) {
        return _provinces.count;
    }else if (pickerView == _pickerViewCity){
        return [_citiesDic[_provinceSelected] count];
    }else{
        return [_areasDic[_citySelected] count];
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView == _pickerViewProvince) {
        return _provinces[row];
    }else if (pickerView == _pickerViewCity){
//        if ([_citiesDic[_provinceSelected] count] > row) {
//            return nil;
//        }else{
            return _citiesDic[_provinceSelected][row];
//        }
    }else{
//        if ([_areasDic[_citySelected] count] > row) {
//            return nil;
//        }else{
            return _areasDic[_citySelected][row];
//        }
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == _pickerViewProvince) {
        _provinceSelected = _provinces[row];
        
        [_pickerViewCity reloadAllComponents];
        [_pickerViewCity selectRow:0 inComponent:0 animated:YES];
        if ([_citiesDic[_provinceSelected] count] > 0) {
            _citySelected = _citiesDic[_provinceSelected][0];
        }else{
            _citySelected = nil;
            _areaSelected = nil;
        }
        if (!_citySelected) {
            NSLog(@"province:%@",_provinceSelected);
        }
        
        [_pickerViewArea reloadAllComponents];
        [_pickerViewArea selectRow:0 inComponent:0 animated:YES];
    }else if (pickerView == _pickerViewCity){
        _citySelected = _citiesDic[_provinceSelected][row];

        [_pickerViewArea reloadAllComponents];
        [_pickerViewArea selectRow:0 inComponent:0 animated:YES];
    }else{
        _areaSelected = _areasDic[_citySelected][row];
        
        NSLog(@"%@ %@ %@",_provinceSelected,_citySelected,_areaSelected);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
