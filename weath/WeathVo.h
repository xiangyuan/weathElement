//
//  WeathVo.h
//  weath
//
//  Created by li yajie on 12/28/12.
//  Copyright (c) 2012 com.coamee. All rights reserved.
//

#import <UIKit/UIKit.h>


#define IMAGLOGURL(C)  [NSString stringWithFormat:@"http://m.weather.com.cn/img/b%@.gif",C]

@interface WeathVo : NSObject

@property(nonatomic,retain) NSString* city;

@property(nonatomic,retain) NSString* weak;

@property(nonatomic,retain) NSString* imageUrl;

@property(nonatomic,retain) NSString * temprature;


@property(nonatomic,retain) NSString * formatedDate;


@end
