//
//  ImageViewController.h
//  EUExGPUImage
//
//  Created by wang on 16/10/24.
//  Copyright © 2016年 com.dingding.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AppCanKit/AppCanKit.h>
@interface ImageViewController : UIViewController
@property(nonatomic,strong) UIImage *image;
@property (nonatomic, weak) id<AppCanWebViewEngineObject> webViewEngine;
@property(nonatomic,strong)ACJSFunctionRef *fun;
@end
