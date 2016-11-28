//
//  EUExImageFilter.m
//  EUExImageFilter
//
//  Created by wang on 16/11/16.
//  Copyright © 2016年 com.dingding.com. All rights reserved.
//

#import "EUExImageFilter.h"
#import "ImageViewController.h"
#import "ImageHandler.h"
@implementation EUExImageFilter
-(void)open:(NSMutableArray *)inArguments{
    ACArgsUnpack(NSDictionary *info,ACJSFunctionRef *fun) = inArguments;
    NSString *imagePath = info[@"path"];
    if (!imagePath) {
        return;
    }
    UIImage *image = [self loadImageFrom:imagePath];
    ImageViewController *vc = [[ImageViewController alloc]init];
    vc.image = image;
    vc.fun = fun;
    vc.webViewEngine  =self.webViewEngine;
    [[self.webViewEngine viewController] presentViewController:vc animated:YES completion:nil];
}
-(void)openView:(NSMutableArray *)inArguments{
    ACArgsUnpack(NSDictionary* info) = inArguments;
    
    CGFloat x =info[@"x"]?[info[@"x"] floatValue]:0;
    CGFloat y =info[@"y"]?[info[@"y"] floatValue]:0;
    CGFloat w =[info[@"w"] floatValue];
    CGFloat h =[info[@"h"] floatValue];
    NSString *imagePath =info[@"path"];
    NSString *type =info[@"type"];
    if (!imagePath || !type || !info[@"w"] || !info[@"h"]) {
        return;
    }
    UIImage *image = [self loadImageFrom:imagePath];
    if (!self.imageView) {
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    }
    
    self.imageView.image = [ImageHandler HandleInputImage:image Type:type];
    [[self.webViewEngine webView] addSubview:self.imageView];
    
}

-(void)closeView:(NSMutableArray *)inArguments{
    if (self.imageView) {
        [self.imageView removeFromSuperview];
        self.imageView = nil;
    }
}

-(UIImage*)loadImageFrom:(NSString*)imagePath{
    NSData *imageData = nil;
    if ([imagePath hasPrefix:@"https"] || [imagePath hasPrefix:@"http"]) {
        imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imagePath]];
    }else{
        imageData = [NSData dataWithContentsOfFile:[self absPath:imagePath]];
    }
    return [UIImage imageWithData:imageData];
}


@end
