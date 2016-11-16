//
//  ImageViewController.m
//  EUExGPUImage
//
//  Created by wang on 16/10/24.
//  Copyright © 2016年 com.dingding.com. All rights reserved.
//

#import "ImageViewController.h"
#import <AppCanKit/AppCanKit.h>
#import "CustomControl.h"
#import "ImageHandler.h"
#define KSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define KSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define TopView_HEIGHT (KSCREEN_HEIGHT*0.05)
#define CenterView_HEIGHT (KSCREEN_HEIGHT*0.75)
#define BUTTON_WIDTH (KSCREEN_WIDTH*0.2)
@interface ImageViewController ()
@property(nonatomic,strong) UIView *topView;
@property(nonatomic,strong) UIView *centerView;
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIView *bottomView;
@property(nonatomic,strong) NSArray *titleArr;
@property(nonatomic,strong) NSArray *imageArr;
@property(nonatomic,strong) NSMutableArray *buttonsArr;

@end

@implementation ImageViewController
-(UIView*)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 20,KSCREEN_WIDTH , KSCREEN_HEIGHT*0.08)];
        _topView.backgroundColor = [UIColor whiteColor];
        
    }
    return _topView;
}
-(void)cancel:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)save:(UIButton*)sender{
    NSString *savePath = [self saveImage:self.imageView.image quality:0.8 usePng:YES];
    if (savePath) {
        [self.fun executeWithArguments:ACArgsPack(@(0),savePath)];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIView*)centerView{
    if (!_centerView) {
        _centerView = [[UIView alloc]initWithFrame:CGRectMake(0, 20+KSCREEN_HEIGHT*0.08,KSCREEN_WIDTH , KSCREEN_HEIGHT*0.7)];
        _centerView.backgroundColor = [UIColor whiteColor];
        
    }
    return _centerView;
}
-(UIImageView*)imageView{
    if (!_imageView) {
        CGSize size = [self OriginImage:self.image Width:self.centerView.frame.size.width Height:self.centerView.frame.size.height];
        NSLog(@"%@", NSStringFromCGSize(size));
        CGRect frame;
        if (size.height>size.width) {
            frame = CGRectMake((self.centerView.frame.size.width - size.width)/2, 0, size.width, size.height);
        } else {
            frame = CGRectMake((self.centerView.frame.size.width - size.width)/2, (self.centerView.frame.size.height - size.height)/2, size.width, size.height);
        }
        _imageView = [[UIImageView alloc]initWithFrame:frame];
        _imageView.image = self.image;
        
    }
    return _imageView;
}
-(UIScrollView*)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20+KSCREEN_HEIGHT*0.78,KSCREEN_WIDTH , KSCREEN_HEIGHT*0.22-20)];
        _scrollView.backgroundColor = [UIColor ac_ColorWithHTMLColorString:@"#FFFFFF"];
        _scrollView.contentSize = CGSizeMake(self.titleArr.count* (BUTTON_WIDTH+10), 0);
        _scrollView.showsHorizontalScrollIndicator = YES;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArr = [self getImages];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    UIButton *btn1 = [UIButton buttonWithType:0];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor ac_ColorWithHTMLColorString:@"#8B8B7A"] forState:UIControlStateNormal];
    btn1.frame = CGRectMake(10, KSCREEN_HEIGHT*0.02, 40, KSCREEN_HEIGHT*0.04);
    [btn1 addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btn2 = [UIButton buttonWithType:0];
    btn2.frame = CGRectMake(KSCREEN_WIDTH -50, KSCREEN_HEIGHT*0.02, 40, KSCREEN_HEIGHT*0.04);
    [btn2 setTitle:@"完成" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor ac_ColorWithHTMLColorString:@"#8B8B7A"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:btn1];
    [_topView addSubview:btn2];
    
    [self.view addSubview:self.centerView];
    [self.centerView addSubview:self.imageView];
    [self.view addSubview:self.scrollView];
    
    
    
    self.buttonsArr = [NSMutableArray array];
    for (int i = 0; i < self.titleArr.count; i++) {
        CustomControl *button = [[CustomControl alloc]initWithFrame:CGRectMake(i* (BUTTON_WIDTH+10)+5, 0,BUTTON_WIDTH, self.scrollView.frame.size.height) backGroundImage:self.imageArr[i] title:self.titleArr[i] font:14];
        /*
        if (i==0) {
            [button.layer setBorderColor:[UIColor ac_ColorWithHTMLColorString:@"#FF0000"].CGColor];
            [button.layer setBorderWidth:2.0];
        }
         */
        button.tag = i;
        [button addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonsArr addObject:button];
        [self.scrollView addSubview:button];
    }
    
    
  
}

-(void)changeImage:(CustomControl*)btn{
    /*
    for (CustomControl *button in self.buttonsArr) {
        [button.layer setBorderColor:[UIColor clearColor].CGColor];
        [button.layer setBorderWidth:0.0];
    }
    [btn.layer setBorderColor:[UIColor ac_ColorWithHTMLColorString:@"#FF0000"].CGColor];
    [btn.layer setBorderWidth:2.0];
     */
    self.imageView.image = self.imageArr[btn.tag];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat width = self.scrollView.frame.size.width;
        if (btn.frame.origin.x < width/2 ) {
             [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        } else  if( btn.frame.origin.x >= width/2 && btn.frame.origin.x <self.scrollView.contentSize.width - width/2){
            [self.scrollView setContentOffset:CGPointMake((btn.tag-2)*(BUTTON_WIDTH+10), 0) animated:YES];
        }else{
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width - width, 0) animated:YES];
        }
    }];
}
-(NSArray*)titleArr{
    if (!_titleArr) {
        _titleArr = @[@"1977",@"Amaro",@"Brannan",@"Earlybird",@"Hefe",@"Hudson",@"InkWell",@"Lomo",@"LordKelvin",@"Nashville",@"Rise",@"Sierra",@"Sutro",@"Toaster",@"Valencia",@"Walden",@"Xproll",@"Contrast",@"Sepia",@"Vignette"
                      ];
    }
    return _titleArr;
}
-(NSArray*)getImages{
    UIImage *image1 = [ImageHandler HandleInputImage:self.image Type:@"1977"];
     UIImage *image2 = [ImageHandler HandleInputImage:self.image Type:@"Amaro"];
     UIImage *image3 = [ImageHandler HandleInputImage:self.image Type:@"Brannan"];
     UIImage *image4 = [ImageHandler HandleInputImage:self.image Type:@"Earlybird"];
     UIImage *image5 = [ImageHandler HandleInputImage:self.image Type:@"Hefe"];
     UIImage *image6 = [ImageHandler HandleInputImage:self.image Type:@"Hudson"];
     UIImage *image7 = [ImageHandler HandleInputImage:self.image Type:@"InkWell"];
     UIImage *image8 = [ImageHandler HandleInputImage:self.image Type:@"Lomo"];
     UIImage *image9 = [ImageHandler HandleInputImage:self.image Type:@"LordKelvin"];
     UIImage *image10 = [ImageHandler HandleInputImage:self.image Type:@"Nash"];
     UIImage *image11 = [ImageHandler HandleInputImage:self.image Type:@"Rise"];
     UIImage *image12 = [ImageHandler HandleInputImage:self.image Type:@"Sierra"];
     UIImage *image13 = [ImageHandler HandleInputImage:self.image Type:@"Sutro"];
     UIImage *image14 = [ImageHandler HandleInputImage:self.image Type:@"Toaster"];
     UIImage *image15 = [ImageHandler HandleInputImage:self.image Type:@"Valencia"];
     UIImage *image16 = [ImageHandler HandleInputImage:self.image Type:@"Walden"];
     UIImage *image17 = [ImageHandler HandleInputImage:self.image Type:@"Xproll"];
     UIImage *image18 = [ImageHandler HandleInputImage:self.image Type:@"Contrast"];
     UIImage *image19 = [ImageHandler HandleInputImage:self.image Type:@"Sepia"];
     UIImage *image20 = [ImageHandler HandleInputImage:self.image Type:@"Vignette"];
    return @[image1,image2,image3,image4,image5,image6,image7,image8,image9,image10,image11,image12,image13,image14,image15,image16,image17,image18,image19,image20];
}

-(CGSize)OriginImage:(UIImage *)image Width:(CGFloat)drawWidth Height:(CGFloat)drawHeight {
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    NSDecimalNumber *drawWidthNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",drawWidth]];
    NSDecimalNumber *drawHeightNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",drawHeight]];
    NSDecimalNumber *widthNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",width]];
    NSDecimalNumber *heightNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",height]];
    
    if (width > height) {
        
        NSDecimalNumber *ratioNumber = [drawWidthNumber decimalNumberByDividingBy:widthNumber];
        NSDecimalNumber *height1Number = [ratioNumber decimalNumberByMultiplyingBy:heightNumber];
        return CGSizeMake(drawWidth, [height1Number floatValue]);
    }else{
        NSDecimalNumber *ratioNumber = [drawHeightNumber decimalNumberByDividingBy:heightNumber];
        NSDecimalNumber *width1Number = [ratioNumber decimalNumberByMultiplyingBy:widthNumber];
        return CGSizeMake([width1Number floatValue], drawHeight);
    }
    
    return CGSizeZero;
}

-(BOOL)shouldAutorotate{
    return NO;
}

// save to disc
- (NSString *)getSaveDirPath{
    NSString *tempPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/apps"];
    NSString *wgtTempPath=[tempPath stringByAppendingPathComponent:[self.webViewEngine.widget widgetId]];
    
    return [wgtTempPath stringByAppendingPathComponent:@"uexImageFilter"];
}
- (NSString *)saveImage:(UIImage *)image quality:(CGFloat)quality usePng:(BOOL)usePng{
    NSData *imageData;
    NSString *imageSuffix;
    
    
    if(usePng){
        imageData=UIImagePNGRepresentation(image);
        imageSuffix=@"png";
    }else{
        imageData=UIImageJPEGRepresentation(image, quality);
        imageSuffix=@"jpg";
    }
    
    
    if(!imageData) return nil;
    
    NSFileManager *fmanager = [NSFileManager defaultManager];
    
    NSString *uexImageSaveDir=[self getSaveDirPath];
    if (![fmanager fileExistsAtPath:uexImageSaveDir]) {
        [fmanager createDirectoryAtPath:uexImageSaveDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *timeStr = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSinceReferenceDate]];
    
    NSString *imgName = [NSString stringWithFormat:@"%@.%@",[timeStr substringFromIndex:([timeStr length]-6)],imageSuffix];
    NSString *imgTmpPath = [uexImageSaveDir stringByAppendingPathComponent:imgName];
    if ([fmanager fileExistsAtPath:imgTmpPath]) {
        [fmanager removeItemAtPath:imgTmpPath error:nil];
    }
    if([imageData writeToFile:imgTmpPath atomically:YES]){
        return imgTmpPath;
    }else{
        return nil;
    }
    
}

@end
