//
//  ViewController.m
//  afn
//
//  Created by Teplot_03 on 16/8/24.
//  Copyright © 2016年 Teplot_03. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *url = @"http://www.baidu.com";
    
    _manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
    

    _manager.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应
    
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSURLRequest *request = [self postRequestWithURL:url content:@"content"];
    
    NSOperation *operation =
    [self.manager HTTPRequestOperationWithRequest:request
                                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                              // 成功后的处理
                                              NSLog(@"成功了");
                                          }
                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              // 失败后的处理
                                              NSLog(@"失败了");
                                              NSLog(@"%@",error);
                                          }];  
    [self.manager.operationQueue addOperation:operation];
    
    
    
}


- (NSMutableURLRequest *)postRequestWithURL:(NSString *)url content:(NSString *)text
{
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request =
    [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded"
   forHTTPHeaderField:@"Contsetent-Type"];
    [request setHTTPBody:data];
    
    return request;
}




@end
