//
//  PGDetailViewController.m
//  iOS7Transition
//
//  Created by Limboy on 10/14/13.
//  Copyright (c) 2013 Limboy. All rights reserved.
//

#import "PGDetailViewController.h"
#import "PGMacro.h"

@interface PGDetailViewController ()
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIButton *closeButton;
@end

@implementation PGDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)initWithImageName:(NSString *)imageName
{
    if (self = [super init]) {
        [self.view addSubview:self.imageView];
        self.imageView.image = [UIImage imageNamed:imageName];
        
        [self.view addSubview:self.closeButton];
    }
    return self;
}

#pragma mark - Accessors

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
    }
    return _imageView;
}

- (UIButton *)closeButton
{
    if (!_closeButton) {
        self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *buttonImage = [UIImage imageNamed:@"close.png"];
        [self.closeButton setImage:buttonImage forState:UIControlStateNormal];
        self.closeButton.frame = CGRectMake(30, 30, buttonImage.size.width, buttonImage.size.height);
        [self.closeButton addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (void)buttonTapped
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
