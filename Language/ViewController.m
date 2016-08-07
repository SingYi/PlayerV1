//
//  ViewController.m
//  Language
//
//  Created by 石燚 on 16/5/30.
//  Copyright © 2016年 石燚. All rights reserved.
//

#import "ViewController.h"
#import "MineClassViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *beautyWord;

@property (nonatomic, strong) UIButton *starBtn;

//背景视图
@property (nonatomic, strong) UIImageView *backgroundView;
//毛玻璃视图
@property (nonatomic, strong) UIVisualEffectView *effectView;


- (void)initUserInterface;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    //隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUserInterface];
    
    
}

- (void)initUserInterface {
    [self.view addSubview:self.beautyWord];
    [self.view addSubview:self.starBtn];
    [self.view addSubview:self.backgroundView];
    [self.view sendSubviewToBack:self.backgroundView];
    [self.backgroundView addSubview:self.effectView];
}


//ios以后隐藏状态栏
- (BOOL)prefersStatusBarHidden{

    return YES;
}

#pragma mark - 懒加载 
- (UILabel *)beautyWord {
    if (!_beautyWord) {
        _beautyWord = [[UILabel alloc]init];
        _beautyWord.bounds = CGRectMake(0, 0, kSCREEN_WIDTH * 0.8, kSCREEN_HEIGHT * 0.2);
        _beautyWord.center = CGPointMake(kSCREEN_WIDTH / 2, kSCREEN_HEIGHT / 3);
        _beautyWord.backgroundColor = [UIColor colorWithRed:0 green:200 / 255.0 blue:1 alpha:0.4];
        _beautyWord.text = @"The word is such beauty!";
        _beautyWord.textAlignment = NSTextAlignmentCenter;
        _beautyWord.layer.cornerRadius = 10;
        _beautyWord.layer.masksToBounds = YES;
    }
    return _beautyWord;
}

- (UIButton *)starBtn {
    if (!_starBtn) {
        _starBtn = [[UIButton alloc]init];
        _starBtn.bounds = CGRectMake(0, 0, kSCREEN_WIDTH * 0.6, kSCREEN_HEIGHT * 0.1);
        _starBtn.center = CGPointMake(kSCREEN_WIDTH / 2, kSCREEN_HEIGHT / 3 * 2);
        [_starBtn setTitle:@"开始课程" forState:(UIControlStateNormal)];
        //
        _starBtn.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.7];
        
        [_starBtn addTarget:self action:@selector(starClass) forControlEvents:(UIControlEventTouchUpInside)];
        
        _starBtn.layer.cornerRadius = 10;
        _starBtn.layer.masksToBounds = YES;
    }
    return _starBtn;
}

- (void)starClass {
    MineClassViewController *mineVC = [MineClassViewController new];
    [self.navigationController pushViewController:mineVC animated:YES];
}

- (UIImageView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIImageView alloc]initWithFrame:self.view.frame];
        _backgroundView.image = [UIImage imageNamed:@"1.jpg"];
    }
    return _backgroundView;
}

- (UIVisualEffectView *)effectView {
    if (!_effectView) {
        _effectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleLight)]];
        _effectView.frame = self.view.frame;
    }
    return _effectView;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
