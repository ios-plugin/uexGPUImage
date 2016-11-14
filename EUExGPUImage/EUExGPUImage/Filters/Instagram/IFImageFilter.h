//
//  InstagramFilter.h
//  GPUImageFilters
//
//  Created by KimDaeWook on 1/12/16.
//  Copyright © 2016 KimDaewook. All rights reserved.
//



#import "GPUImageSixInputFilter.h"
#import "GPUImageFilterGroup.h"
#import "GPUImagePicture.h"
#import "GPUImage.h"
@interface IFImageFilter : GPUImageFilterGroup

+(NSArray<Class>*)allFilterClasses;
+(GPUImagePicture*)filterImageNamed:(NSString*)name;


- (id)initWithFragmentShaderFromString:(NSString *)fragmentShaderString sources:(NSArray<GPUImagePicture*>*)sources;
- (id)initWithFragmentShaderFromString:(NSString *)fragmentShaderString;

- (NSString*)name;

@end

