//
//  MineClassViewController.m
//  Language
//
//  Created by 石燚 on 16/5/30.
//  Copyright © 2016年 石燚. All rights reserved.
//

#import "MineClassViewController.h"
#import "PlayViewController.h"
#import "HttpModel.h"

@interface MineClassViewController ()<HttpDelegate>

//点击下载更多按钮
@property (nonatomic, strong) UIButton *headerLabel;

//课程数组
@property (nonatomic, strong) NSMutableArray *courseArray;

//设置
@property (nonatomic, strong) UIBarButtonItem *settingBtn;

@property (nonatomic, strong) HttpModel *httpModel;

@end

@implementation MineClassViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    
    [self initUserInterface];
    
}

- (void)initUserInterface {
    self.navigationItem.title = @"我的课程";
    
    self.navigationItem.rightBarButtonItem = self.settingBtn;
    
//    self.tableView.bounces = NO;
    
}

- (void)initDataSource {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Sing_yi"];
    _httpModel = [HttpModel new];
    _httpModel.delegate = self;
    
}

- (void)HttpMdel:(HttpModel *)httpModel ReturnData:(NSData *)data {
    NSLog(@"1");
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courseArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Sing_yi" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.courseArray[indexPath.row] lastPathComponent];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.headerLabel;
    }

    
    return self.headerLabel;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kSCREEN_HEIGHT / 11;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayViewController *playVc = [PlayViewController new];
    playVc.title = [self.courseArray[indexPath.row] lastPathComponent];
    playVc.musciNames = [self.courseArray[indexPath.row] lastPathComponent];
    [self.navigationController pushViewController:playVc animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


#pragma mark - 懒加载
- (NSMutableArray *)courseArray {
    if (!_courseArray) {
        //获取boundle路径下所有的 xx 格式的文件
        _courseArray = [NSMutableArray arrayWithArray:[[NSBundle mainBundle] pathsForResourcesOfType:@"mp3" inDirectory:nil]];
    }
    return _courseArray;
}


- (UIButton *)headerLabel {
    if (!_headerLabel) {
        _headerLabel = [[UIButton alloc]init];
        _headerLabel.bounds = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT / 11);
        _headerLabel.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        [_headerLabel setTitle:@"点击下载更多" forState:(UIControlStateNormal)];
        [_headerLabel setTitleColor:[UIColor colorWithRed:0.8 green:0 blue:0 alpha:0.8] forState:(UIControlStateNormal)];
        [_headerLabel addTarget:self action:@selector(downLoadCourse) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _headerLabel;
}

- (void)downLoadCourse {
    NSLog(@"下载课程");
}

- (UIBarButtonItem *)settingBtn {
    if (!_settingBtn) {
        _settingBtn = [[UIBarButtonItem alloc]initWithTitle:@"查看排序   " style:(UIBarButtonItemStyleDone) target:self action:@selector(settingArray)];
    }
    return _settingBtn;
}

- (void)settingArray {
    NSLog(@"1");
}


@end
