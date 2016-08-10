//
//  PlayViewController.m
//  Language
//
//  Created by 石燚 on 16/5/30.
//  Copyright © 2016年 石燚. All rights reserved.
//


#import <AVFoundation/AVFoundation.h>
#import "PlayViewController.h"

@interface PlayViewController ()<AVAudioPlayerDelegate>

@property (nonatomic, strong) UILabel *surplusLabel;
@property (nonatomic, strong) UILabel *wrongLabel;
@property (nonatomic, strong) UILabel *excessLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) UIButton *playLabel;
@property (nonatomic, strong) UITextView *textField;

@property (nonatomic, strong) UIButton *next;
@property (nonatomic, strong) UIButton *last;

//音频播放器
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;

@property (nonatomic,assign) NSInteger currentMusicIdx; //记录下标
@property (nonatomic,assign) BOOL isPlaying;


@property (nonatomic, strong) NSArray<NSNumber *> *timeArray;
@property (nonatomic, strong) NSArray<NSString *> *SentenceArray;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIButton *sureBtn;



@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUserInterface];
    
}

- (void)initUserInterface {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.surplusLabel];
    
    [self.view addSubview:self.wrongLabel];
    
    [self.view addSubview:self.excessLabel];
    
    [self.view addSubview:self.rightLabel];
    
    [self.view addSubview:self.textField];
    
    [self.view addSubview:self.playLabel];
    
    [self.view addSubview:self.last];
    
    [self.view addSubview:self.next];
    
    [self.view addSubview:self.sureBtn];
    
}

- (void)initDataSource {
    _currentMusicIdx = 0;
    [self initializeAudionPlayerWithMusic:@"原始音频.mp3"];
    self.navigationItem.title = [NSString stringWithFormat:@"第%ld句",_currentMusicIdx];
}


- (void)initializeAudionPlayerWithMusic:(NSString *)musecName {
    //1.异常处理
    if (musecName.length == 0) {
        return;
    }
    
    NSError *error = nil;
    
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForAuxiliaryExecutable:musecName]] error:&error];
    //3.判断是否创建成功
    if (error) {
        NSLog(@"%@",error.localizedDescription);
    } else {
        //4.创建成功.配置音频播放器
        //4.1 获取持续的总时间
        NSLog(@"%.2f",self.audioPlayer.duration);
        //4.2 设置音量
        self.audioPlayer.volume = 1.f;
        //4.3 设置循环模式
        self.audioPlayer.numberOfLoops = -1;
        //4.4 设置播放当前时间
        NSLog(@"%.2f",self.audioPlayer.currentTime);
        self.audioPlayer.currentTime = 0;
        //4.5 准备播放
        [self.audioPlayer prepareToPlay];
        
        self.audioPlayer.delegate = self;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(refeshTime) userInfo:nil repeats:YES];
    }
}

- (void)refeshTime {
    if (self.audioPlayer.currentTime >= self.timeArray[_currentMusicIdx + 1].floatValue) {
        [self.audioPlayer stop];
        self.audioPlayer.currentTime = self.timeArray[_currentMusicIdx].floatValue;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSLog(@"%@",keyPath);
}

- (void)setTitle:(NSString *)courTitle {
//    _courTitle = courTitle;
//    self.navigationItem.title = courTitle;
    
}

#pragma mark - circulation
//- (void)circulation {
//    NSInteger test = self.timeArray[_currentMusicIdx + 1].integerValue - self.timeArray[_currentMusicIdx].integerValue;
//    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(stopOrPlay) userInfo:nil repeats:NO];
//    
//    timer.fireDate = [NSDate distantPast];
//}
//
//- (void)stopOrPlay {
//    NSLog(@"1");
//    [self.audioPlayer stop];
//}

#pragma mark - events
- (void)clickNext {
    if (_currentMusicIdx != self.timeArray.count - 2) {
        _currentMusicIdx++;
    } else {
        _currentMusicIdx = 0;
    }
    
    [self.audioPlayer stop];
    self.audioPlayer.currentTime = self.timeArray[_currentMusicIdx].integerValue;
    
    [self.audioPlayer play];
//    if (_isPlaying) {
//        [self.audioPlayer play];
//    }
    self.navigationItem.title = [NSString stringWithFormat:@"第%ld句",_currentMusicIdx];
}

- (void)clickLast {
    if (_currentMusicIdx == 0) {
        _currentMusicIdx = self.timeArray.count - 2;
    } else {
        _currentMusicIdx--;
    }
    
    [self.audioPlayer stop];
    self.audioPlayer.currentTime = self.timeArray[_currentMusicIdx].floatValue;
    
    [self.audioPlayer play];

    
//    if (_isPlaying) {
//        [self.audioPlayer play];
//    }
    self.navigationItem.title = [NSString stringWithFormat:@"第%ld句",_currentMusicIdx];
}

- (void)clickSureBtn {
    if ([self.textField.text isEqualToString:self.SentenceArray[_currentMusicIdx]]) {
        [self showAlertWithMessage:@"正确" dismiss:nil];
    } else {
        [self showAlertWithMessage:@"错误" dismiss:nil];
    }
    
    
}

- (void)showAlertWithMessage:(NSString *)message dismiss:(void(^)(void))dismiss{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertController dismissViewControllerAnimated:YES completion:^{
            if (dismiss) {
                dismiss();
            }
        }];
    });
}

#pragma mark - response
- (void)playOrpause:(UIButton *)sender  {
    //更新按钮的状态
    sender.selected = !sender.selected;
    //切换播放状态
    _isPlaying = !_isPlaying;
    sender.selected ? [self.audioPlayer play] : [self.audioPlayer pause];
}

#pragma mark - Setters
- (void)setAudioPlayer:(AVAudioPlayer *)audioPlayer {
    if (audioPlayer.playing) {
        [audioPlayer pause];
    }
    _audioPlayer = audioPlayer;
}

-(void)fuwenbenLabel:(UILabel *)labell FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:labell.text];
    
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    
    labell.attributedText = str;
}


#pragma mark - 懒加载
- (UILabel *)surplusLabel {
    if (!_surplusLabel) {
        _surplusLabel = [self creadLabelWithTitle:@"剩余:20词"];
        _surplusLabel.center = CGPointMake(kSCREEN_WIDTH / 6, CGRectGetMaxY(self.navigationController.navigationBar.frame) + kSCREEN_HEIGHT / 20);
    }
    return _surplusLabel;
}

- (UILabel *)wrongLabel {
    if (!_wrongLabel) {
        _wrongLabel = [self creadLabelWithTitle:@"错误:0词"];
        _wrongLabel.center = CGPointMake(kSCREEN_WIDTH / 6, CGRectGetMaxY(self.surplusLabel.frame) + kSCREEN_HEIGHT / 20);
    }
    return _wrongLabel;
}

- (UILabel *)excessLabel {
    if (!_excessLabel) {
        _excessLabel = [self creadLabelWithTitle:@"超出:0词"];
        _excessLabel.center = CGPointMake(kSCREEN_WIDTH / 6 * 5, CGRectGetMaxY(self.navigationController.navigationBar.frame) + kSCREEN_HEIGHT / 20);
    }
    return _excessLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [self creadLabelWithTitle:@"正确:100%"];
        _rightLabel.center = CGPointMake(kSCREEN_WIDTH / 6 * 5, CGRectGetMaxY(self.excessLabel.frame) + kSCREEN_HEIGHT / 20);
    }
    return _rightLabel;
}

- (UILabel *)creadLabelWithTitle:(NSString *)text {
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    label.bounds = CGRectMake(0, 0, kSCREEN_WIDTH / 3, kSCREEN_HEIGHT / 10);
    return label;
}

- (UIButton *)playLabel {
    if (!_playLabel) {
        _playLabel = [[UIButton alloc]init];
        _playLabel.bounds = CGRectMake(0, 0, kSCREEN_WIDTH / 3, kSCREEN_HEIGHT / 5);
        _playLabel.center = CGPointMake(kSCREEN_WIDTH / 2, kSCREEN_HEIGHT/ 10 + CGRectGetMaxY(self.navigationController.navigationBar.frame));
        _playLabel.backgroundColor = [UIColor redColor];
        [_playLabel setTitle:@"播放" forState:(UIControlStateNormal)];
        [_playLabel setTitle:@"暂停" forState:(UIControlStateSelected)];
        [_playLabel addTarget:self action:@selector(playOrpause:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _playLabel;
}

- (UITextView *)textField {
    if (!_textField) {
        _textField = [[UITextView alloc]init];
        _textField.frame = CGRectMake(0, CGRectGetMaxY(self.wrongLabel.frame), kSCREEN_WIDTH, kSCREEN_HEIGHT / 5 * 2);
        _textField.font = [UIFont boldSystemFontOfSize:20];
        _textField.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
        _textField.textAlignment = NSTextAlignmentJustified;

    }
    return _textField;
}

- (UIButton *)next {
    if (!_next) {
        _next = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _next.frame = CGRectMake(kSCREEN_WIDTH / 2, kSCREEN_HEIGHT * 0.8, kSCREEN_WIDTH / 2, kSCREEN_HEIGHT / 10);
        [_next setTitle:@"下一句" forState:(UIControlStateNormal)];
        _next.backgroundColor = [UIColor orangeColor];
        [_next addTarget:self action:@selector(clickNext) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _next;
}

- (UIButton *)last {
    if (!_last) {
        _last = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _last.frame = CGRectMake(0, kSCREEN_HEIGHT * 0.8, kSCREEN_WIDTH / 2, kSCREEN_HEIGHT / 10);
        [_last setTitle:@"上一句" forState:(UIControlStateNormal)];
        _last.backgroundColor = [UIColor orangeColor];
        [_last addTarget:self action:@selector(clickLast) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _last;
}
- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _sureBtn.frame = CGRectMake(0, kSCREEN_HEIGHT * 0.7, kSCREEN_WIDTH, kSCREEN_HEIGHT / 10);
        [_sureBtn setTitle:@"检查" forState:(UIControlStateNormal)];
        _sureBtn.titleLabel.textColor = [UIColor whiteColor];
        _sureBtn.backgroundColor = [UIColor blackColor];
        [_sureBtn addTarget:self action:@selector(clickSureBtn) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _sureBtn;
}

- (NSArray *)timeArray {
    if (!_timeArray) {
        _timeArray = @[@(0),@(2),@(5),@(7.5),@(12),@(16.3),@(19),@(22),@(27),@(30),@(34),@(38),@(42),@(45),@(46),@(49)];
    }
    return _timeArray;
}

- (NSArray<NSString *> *)SentenceArray {
    if (!_SentenceArray) {
        _SentenceArray = @[@"Salzer, Guten Tag.",
                           @"Jochen Schulz hier,Guten Tag,Frau Salzer.",
                           @"Ich habe mich schon im Internet darüber informiert,",
                           @"dass die besten Studenten unserer Universität die Chance haben,im Ausland zu studieren.",
                           @"Ich möchte gerne wissen unter welchen Bedingungen man einen Platz beantragen darf?",
                           @"Es gibt diverse Erasmusprogramme für Studierende.",
                           @"Bewerber müssen folgende Voraussettzungen erfüllen.",
                           @"Zuerst muss man die Zwischenprüfung schon abgelegt und mindestens die Note zwei erreicht haben",
                           @"",
                           @"",
                           @"",
                           @"",
                           @"",
                           @"",
                           @"",
                           @""];
    }
    return _SentenceArray;
}



@end
