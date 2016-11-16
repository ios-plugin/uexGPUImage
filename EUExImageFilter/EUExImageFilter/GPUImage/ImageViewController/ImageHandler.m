//
//  ImageHandler.m
//  EUExGPUImage
//
//  Created by wang on 16/11/14.
//  Copyright © 2016年 com.dingding.com. All rights reserved.
//

#import "ImageHandler.h"
#import "GPUImage.h"
#import "InstaFilters.h"
@implementation ImageHandler

+(UIImage*)HandleInputImage:(UIImage*)inputImage Type:(NSString*)type{
    UIImage *image = nil;
    if ([type isEqual:@"1977"]) {
         image = [self IFImageFilter:[[IF1977Filter alloc] init] sourceImage:inputImage];
    }
    if ([type isEqual:@"Amaro"]) {
        image = [self IFImageFilter:[[IFAmaroFilter alloc] init] sourceImage:inputImage];
    }
    if ([type isEqual:@"Brannan"]) {
        image = [self IFImageFilter:[[IFBrannanFilter alloc] init] sourceImage:inputImage];
    }
    if ([type isEqual:@"Earlybird"]) {
        image = [self IFImageFilter:[[IFEarlybirdFilter alloc] init] sourceImage:inputImage];
    }
    if ([type isEqual:@"Hefe"]) {
        image = [self IFImageFilter:[[IFHefeFilter alloc] init] sourceImage:inputImage];
    }
    if ([type isEqual:@"Hudson"]) {
        image = [self IFImageFilter:[[IFHudsonFilter alloc] init] sourceImage:inputImage];
    }
    if ([type isEqual:@"InkWell"]) {
        image = [self IFImageFilter:[[IFInkwellFilter alloc] init] sourceImage:inputImage];
    }
    if ([type isEqual:@"Lomo"]) {
        image = [self IFImageFilter:[[IFLomofiFilter alloc] init] sourceImage:inputImage];
    }
    if ([type isEqual:@"LordKelvin"]) {
        image = [self IFImageFilter:[[IFLordKelvinFilter alloc] init] sourceImage:inputImage];
    }
    if ([type isEqual:@"Nash"]) {
        image = [self IFImageFilter:[[IFNashvilleFilter alloc] init] sourceImage:inputImage];
    }
    if ([type isEqual:@"Rise"]) {
        image = [self IFImageFilter:[[IFRiseFilter alloc] init] sourceImage:inputImage];
    }
    if ([type isEqual:@"Sierra"]) {
        image = [self IFImageFilter:[[IFSierraFilter alloc] init] sourceImage:inputImage];
    }
    if ([type isEqual:@"Sutro"]) {
        image = [self IFImageFilter:[[IFSutroFilter alloc] init] sourceImage:inputImage];
    }
    if ([type isEqual:@"Toaster"]) {
        image = [self IFImageFilter:[[IFToasterFilter alloc] init] sourceImage:inputImage];
    }
    if ([type isEqual:@"Valencia"]) {
        image = [self IFImageFilter:[[IFValenciaFilter alloc] init] sourceImage:inputImage];
    }
    if ([type isEqual:@"Walden"]) {
        image = [self IFImageFilter:[[IFWaldenFilter alloc] init] sourceImage:inputImage];
    }
    if ([type isEqual:@"Xproll"]) {
        image = [self IFImageFilter:[[IFXproIIFilter alloc] init] sourceImage:inputImage];
    }
    if ([type isEqual:@"Contrast"]) {
        image = [self IFImageFilter:[[IFRiseFilter alloc] init] sourceImage:inputImage];
    }
    if ([type isEqual:@"Sepia"]) {
        image = [self IFImageFilter:[[IFToasterFilter alloc] init] sourceImage:inputImage];
    }
    if ([type isEqual:@"Vignette"]) {
        image = [self IFImageFilter:[[IFNormalFilter alloc] init] sourceImage:inputImage];
    }
    
    return image;
}

+(UIImage*)IFImageFilter:(IFImageFilter*)imageFilter sourceImage:(UIImage*)inputImage{
    [imageFilter useNextFrameForImageCapture];
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:inputImage];
    [stillImageSource addTarget:imageFilter];
    [stillImageSource processImage];
    UIImage *newImage = [imageFilter imageFromCurrentFramebuffer];
    return newImage;
}
@end
