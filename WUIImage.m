//
//  UIImage-Handling.m
//  WinAdDemo
//
//  Created by frank on 11-5-13.
//  Copyright 2011 wongf70@gmail.com All rights reserved.
//

#import "WUIImage.h"


@implementation WUIImage
+(NSDictionary*)SeparateImage:(UIImage*)image ByX:(int)x andY:(int)y cacheQuality:(float)quality
{
	
	//kill errors
	if (x<1) {
		return nil;
	}else if (y<1) {
		return nil;
	}
	if (![image isKindOfClass:[UIImage class]]) {
		return nil;
	}
	
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *str1 = NSHomeDirectory();
    NSString *_filePath = [NSString stringWithFormat:@"%@/images",str1];
    
    if (![fileManager fileExistsAtPath:_filePath]) {
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"images"];
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
	//attributes of element
	float _xstep=image.size.width*1.0/(y+1);
	float _ystep=image.size.height*1.0/(x+1);
	NSMutableDictionary*_mutableDictionary=[[NSMutableDictionary alloc]initWithCapacity:1];
	//NSArray*_array=[imageName componentsSeparatedByString:@"."];
	//NSString*prefixName=[_array objectAtIndex:0];
	NSString*prefixName=@"win";
	
	//snap in context and create element image view
    int m =0;
    
	for (int i=0; i<x; i++) 
	{
		for (int j=0; j<y; j++) 
		{
            
			CGRect rect=CGRectMake(_xstep*j, _ystep*i, _xstep, _ystep);
			CGImageRef imageRef=CGImageCreateWithImageInRect([image CGImage],rect);
			UIImage* elementImage=[UIImage imageWithCGImage:imageRef];
			UIImageView*_imageView=[[UIImageView alloc] initWithImage:elementImage];
			_imageView.frame=rect;
			NSString*_imageString=[NSString stringWithFormat:@"%@_%d.png",prefixName,m];
			[_mutableDictionary setObject:_imageView forKey:_imageString];
			//CFRelease(imageRef);
			
			if (quality<=0) 
			{
				continue;
			}
			quality=(quality>1)?1:quality;
            
            NSString *_imagePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"images"] stringByAppendingPathComponent:_imageString];
            
            
//			NSString*_imagePath=[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"images/%@",_imageString]];
            
            
			NSData* _imageData=UIImageJPEGRepresentation(elementImage, quality);
            
            NSLog(@"imagepath is %@",_imagePath);

			[_imageData writeToFile:_imagePath atomically:YES];
            
            m++;
		}
	}
	//return dictionary including image views
	NSDictionary*_dictionary=_mutableDictionary;
	return _dictionary;
}

@end
