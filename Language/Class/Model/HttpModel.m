//
//  HttpModel.m
//  Language
//
//  Created by 石燚 on 16/8/7.
//  Copyright © 2016年 石燚. All rights reserved.
//


#define Url_ID @"2qewcoP52UQbMqQFd5VmL03i-gzGzoHsz"
#define Url_KEY @"394WCmr17Dbmjd8xinOkM4VF"


#import <UIKit/UIKit.h>
#import "HttpModel.h"

@implementation HttpModel

//创建对象
- (void)creatObjetc {
    NSString *urlStr = @"https://api.leancloud.cn/1.1/classes/Post";
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"POST";
    //配置头部请求(是个字典类型)
    [request setValue:Url_ID forHTTPHeaderField:@"X-LC-Id"];
    [request setValue:Url_KEY forHTTPHeaderField:@"X-LC-Key"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //设置body
    NSDictionary *parmStr = @{@"test":@"interesting",@"test2":@"interesting2"};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parmStr options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = jsonData;
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *tast = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        id obj = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:&error];
        if (error) {
            
        } else {
            NSLog(@"%@",obj);
        }
        
        
    }];
    
    [tast resume];
    
}

//获取对象
- (void)getData {
    NSString *urlStr = @"https://api.leancloud.cn/1.1/classes/Post/57a6d944d342d30057636115";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    [request setValue:@"2qewcoP52UQbMqQFd5VmL03i-gzGzoHsz" forHTTPHeaderField:@"X-LC-Id"];
    [request setValue:@"394WCmr17Dbmjd8xinOkM4VF" forHTTPHeaderField:@"X-LC-Key"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        if (error) {
            
        } else {
            NSLog(@"%@",obj);
        }
        
    }];
    
    [task resume];
    
}

//遍历class
- (void)findClass {
    NSURL *ulr = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.leancloud.cn/1.1/scan/classes/Post"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:ulr];
    
    [request setValue:@"2qewcoP52UQbMqQFd5VmL03i-gzGzoHsz" forHTTPHeaderField:@"X-LC-Id"];
    [request setValue:@"uB9VXNPzNoLzkofv6pbhWeeX,master" forHTTPHeaderField:@"X-LC-Key"];
    request.HTTPMethod = @"GET";
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"%@",obj);
    }];
    
    [task resume];
    
    
}

//查询
- (void)QueryClass {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.leancloud.cn/1.1/classes/_File"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"2qewcoP52UQbMqQFd5VmL03i-gzGzoHsz" forHTTPHeaderField:@"X-LC-Id"];
    [request setValue:@"394WCmr17Dbmjd8xinOkM4VF" forHTTPHeaderField:@"X-LC-Key"];
    [request setValue:@"Content-Type" forHTTPHeaderField:@"application/json"];
    
    request.HTTPMethod = @"GET";
    
    NSURLSessionTask *tast = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if ([self.delegate respondsToSelector:@selector(HttpMdel:ReturnData:)]) {
            [self.delegate HttpMdel:self ReturnData:data];
        }
        
        id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"%@",obj);
    }];
    
    [tast resume];
    
}

//上传
- (void)upload {
    NSURL *url = [NSURL URLWithString:@"https://api.leancloud.cn/1.1/files/15.png"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";

    [request setValue:@"2qewcoP52UQbMqQFd5VmL03i-gzGzoHsz" forHTTPHeaderField:@"X-LC-Id"];
    [request setValue:@"394WCmr17Dbmjd8xinOkM4VF" forHTTPHeaderField:@"X-LC-Key"];
    [request setValue:@"image/png" forHTTPHeaderField:@"Content-Type"];

    NSString *string = [[NSBundle mainBundle] pathForResource:@"15" ofType:@"png"];
    
    NSData *edata = [[NSData alloc]initWithContentsOfFile:string];
    
    request.HTTPBody = edata;
    
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"1");
        } else {
            id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSString *aString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (error) {
                NSLog(@"%@",aString);
            } else {
                NSLog(@"%@",obj);
            }
        }
    }];
    [task resume];
}

//关联
- (void)relevance {
    NSURL *url = [NSURL URLWithString:@"https://api.leancloud.cn/1.1/classes/Staff"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setValue:@"2qewcoP52UQbMqQFd5VmL03i-gzGzoHsz" forHTTPHeaderField:@"X-LC-Id"];
    [request setValue:@"394WCmr17Dbmjd8xinOkM4VF" forHTTPHeaderField:@"X-LC-Key"];
    [request setValue:@"Content-Type" forHTTPHeaderField:@"application/json"];
    
    request.HTTPMethod = @"POST";
    
    NSDictionary *dict = @{
        @"name": @"test111",
        @"picture": @{
            @"id": @"57a72bb479bc440054cd1582",
            @"__type": @"File"
            }
        };
    
    NSData *testData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];

    request.HTTPBody = testData;
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"%@",obj);
        
    }];
    
    [task resume];
}

@end







