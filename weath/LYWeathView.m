//
//  LYWeathView.m
//  weath
//
//  Created by li yajie on 12/28/12.
//  Copyright (c) 2012 com.coamee. All rights reserved.
//

#import "LYWeathView.h"
#import "WeathVo.h"

@implementation LYWeathView
{
    BOOL isResponse;
    WeathVo * cVo;
}

@synthesize logoImageView;

@synthesize cityLbl;
@synthesize weathMsg;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupView];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void) setupView {
    self.backgroundColor = [UIColor clearColor];
    cityLbl = [[UILabel alloc]initWithFrame:CGRectZero];
    cityLbl.backgroundColor = [UIColor clearColor];
    cityLbl.font = [UIFont boldSystemFontOfSize:13.f];
    cityLbl.numberOfLines = 1;
    cityLbl.textColor = [UIColor blackColor];
    [self addSubview:cityLbl];
    [cityLbl release];
    logoImageView = [[EGOImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:logoImageView];
    [logoImageView release];
    
    weathMsg = [[UILabel alloc]initWithFrame:CGRectZero];
    weathMsg.backgroundColor = [UIColor clearColor];
    weathMsg.numberOfLines = 1;
    weathMsg.textColor = [UIColor blackColor];
    weathMsg.font = [UIFont systemFontOfSize:11.f];
    [self addSubview:weathMsg];
    [weathMsg release];
    isResponse = FALSE;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
//-(void)layoutSubviews {
//    [super layoutSubviews];
//
//}

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (isResponse) {
        NSLog(@"...dsf");
        CGRect frame = self.frame;
        CGSize size = [self calculateSize:cVo.city withFont:[UIFont systemFontOfSize:14.f] withMode:UILineBreakModeWordWrap];
        cityLbl.frame = CGRectMake(kLabelMargin, 0.f, size.width, frame.size.height);
        cityLbl.text = cVo.city;
        NSString * wMsg  = [NSString stringWithFormat:@"%@ %@ %@",cVo.temprature,cVo.formatedDate,cVo.weak];
        CGSize msgSize = [self calculateSize:wMsg withFont:[UIFont systemFontOfSize:11.f] withMode:UILineBreakModeWordWrap];
        if (cVo.imageUrl) {
            logoImageView.frame = CGRectMake(cityLbl.bounds.origin.x + cityLbl.frame.size.width + kLabelMargin, kLabelMargin / 2, 36.f, frame.size.height -kLabelMargin);
            logoImageView.imageURL = [NSURL URLWithString:cVo.imageUrl];
            weathMsg.frame = CGRectMake(logoImageView.frame.origin.x + logoImageView.frame.size.width + kLabelMargin / 2, 0.f, msgSize.width, frame.size.height);
            weathMsg.text = wMsg;
        } else {
            weathMsg.frame = CGRectMake(cityLbl.frame.origin.x + cityLbl.frame.size.width + kLabelMargin, 0.f, msgSize.width, frame.size.height);
            weathMsg.text = wMsg;
        }
    }
}

-(void) reDrawView:(WeathVo *)vo {
    cVo = vo;
    isResponse = TRUE;
    [self setNeedsDisplay];
}

-(void)setWeathPresentRUL:(NSString *)urlParam {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSAutoreleasePool * pool = [[NSAutoreleasePool alloc]init];
        NSURL * url = [NSURL URLWithString:urlParam];
        NSHTTPURLResponse *response;
        NSError * error;
        NSURLRequest * request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:4];
        NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (!error && [response statusCode] == 200) {
            NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            NSDictionary * dict = [responseString objectFromJSONString];
            NSDictionary * weatherInfo = [dict objectForKey:@"weatherinfo"];
            WeathVo * vo = [[WeathVo alloc]init];
            vo.city = [weatherInfo objectForKey:@"city"];
            vo.formatedDate = [weatherInfo objectForKey:@"date_y"];
            vo.weak = [weatherInfo objectForKey:@"week"];
            vo.imageUrl = IMAGLOGURL([weatherInfo objectForKey:@"img1"]);
            vo.temprature = [weatherInfo objectForKey:@"temp1"];
            dispatch_async(dispatch_get_main_queue(), ^{
                //                WeathVo * tmpVo = [vo retain];
                [self reDrawView:vo];
            });
        }
        [pool drain];
    });
}

-(CGSize) calculateSize:(NSString*) orgin withFont:(UIFont *)font withMode:(UILineBreakMode) mode {
    CGSize dynamicSize = [orgin sizeWithFont:font constrainedToSize:CGSizeMake(self.frame.size.width, CGFLOAT_MAX) lineBreakMode:mode];
    return dynamicSize;
}

- (void)dealloc
{
    [cVo release];
    [super dealloc];
}

@end
