//
//  CustomControl.m
//  EUExGPUImage
//
//  Created by wang on 16/11/11.
//  Copyright © 2016年 com.dingding.com. All rights reserved.
//

#import "CustomControl.h"
#import <AppCanKit/AppCanKit.h>
@implementation CustomControl
-(id)initWithFrame:(CGRect)frame backGroundImage:(UIImage*)backgroundImage title:(NSString*)title font:(CGFloat)titleSize{
    if (self = [super initWithFrame:frame]) {
        UILabel *textLabel = [[UILabel alloc]init];
        CGFloat stringWidth = [self calculateSizeWithFont:titleSize Width:MAXFLOAT Height:20 Text:title].size.width;
        textLabel.text = title;
        textLabel.textColor = [UIColor ac_ColorWithHTMLColorString:@"#8B8B7A"];
        textLabel.text = title;
        textLabel.font = [UIFont systemFontOfSize:titleSize];
        textLabel.frame = CGRectMake((self.frame.size.width-stringWidth) /2, 5, stringWidth, 15);

        NSLog(@"stringWidth:%f",stringWidth);
        [self addSubview:textLabel];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.frame.size.width, self.frame.size.height-25)];
        imageView.image = backgroundImage;
        [self addSubview:imageView];
        self.layer.masksToBounds = YES;
        
    }
    return self;
}
-(CGRect)calculateSizeWithFont:(CGFloat)Font Width:(NSInteger)Width Height:(NSInteger)Height Text:(NSString *)Text
{
    CGRect size;
    
    NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:Font]};
    size= [Text boundingRectWithSize:CGSizeMake(Width, Height)
                             options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                          attributes:attr
                             context:nil];
    
    return size;
}


@end
