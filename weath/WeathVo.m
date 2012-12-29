//
//  WeathVo.m
//  weath
//
//  Created by li yajie on 12/28/12.
//  Copyright (c) 2012 com.coamee. All rights reserved.
//

#import "WeathVo.h"


@implementation WeathVo

- (void)dealloc
{
    self.city = self.formatedDate = self.temprature = self.weak = nil;
    self.imageUrl = nil;
    [super dealloc];
}

@end
