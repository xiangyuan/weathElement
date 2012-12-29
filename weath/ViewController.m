//
//  ViewController.m
//  weath
//
//  Created by li yajie on 12/28/12.
//  Copyright (c) 2012 com.coamee. All rights reserved.
//

#import "ViewController.h"
#import "LYWeathView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    LYWeathView * view = [[LYWeathView alloc]initWithFrame:CGRectMake(40.f, 80.f, 250.f, 40.f)];
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
    [view release];
    [view setWeathPresentRUL:@"http://m.weather.com.cn/data/101020100.html"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
