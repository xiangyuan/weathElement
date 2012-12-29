//
//  LYWeathView.h
//  weath
//
//  Created by li yajie on 12/28/12.
//  Copyright (c) 2012 com.coamee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

#define kLabelMargin 6

@interface LYWeathView : UIView

@property(nonatomic,retain) UILabel * cityLbl;
@property(nonatomic,retain) EGOImageView * logoImageView;

@property(nonatomic,retain) UILabel * weathMsg;


-(void) setWeathPresentRUL:(NSString*) url;

@end
