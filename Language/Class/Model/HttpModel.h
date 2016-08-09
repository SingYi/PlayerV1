//
//  HttpModel.h
//  Language
//
//  Created by 石燚 on 16/8/7.
//  Copyright © 2016年 石燚. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HttpModel;

@protocol HttpDelegate <NSObject>

- (void)HttpMdel:(HttpModel *)httpModel ReturnData:(NSData *)data;

@end

@interface HttpModel : NSObject

@property (nonatomic, weak) id<HttpDelegate> delegate;

- (void)creatObjetc;

- (void)getData;

- (void)findClass;

- (void)QueryClass;

- (void)upload;

- (void)relevance;

@end
