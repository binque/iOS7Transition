//
//  PGViewController.m
//  iOS7Transition
//
//  Created by Limboy on 10/14/13.
//  Copyright (c) 2013 Limboy. All rights reserved.
//

#import "PGViewController.h"
#import "PGTransition.h"
#import "PGDetailViewController.h"
#import "PGMacro.h"

@interface PGViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic) NSArray *dataSource;
@end

@implementation PGViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.itemSize = CGSizeMake(93, 93);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self = [super initWithCollectionViewLayout:flowLayout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Item"];
    self.collectionView.backgroundColor = [UIColor clearColor];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    CGPoint globalPoint = [self.collectionView convertPoint:cell.center toView:nil];
    self.touchRect = CGRectMake(globalPoint.x, globalPoint.y, cell.frame.size.width, cell.frame.size.height);
    PGDetailViewController *detailViewController = [[PGDetailViewController alloc] initWithImageName:[NSString stringWithFormat:@"%@-big.png", self.dataSource[indexPath.row]]];
    detailViewController.modalPresentationStyle = UIModalPresentationCustom;
    detailViewController.transitioningDelegate = self;
    
    [self presentViewController:detailViewController animated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Item" forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        [cell removeFromSuperview];
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", self.dataSource[indexPath.row]]]];
    
    [cell.contentView addSubview:imageView];
    imageView.frame = CGRectMake(0, 0, 93, 93);
    
    return cell;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    PGTransition *animator = [[PGTransition alloc] init];
    animator.presenting = YES;
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    PGTransition *animator = [[PGTransition alloc] init];
    animator.presenting = NO;
    return animator;
}

#pragma mark - Accessors

- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [@"1 2 3 4 5 6 1 2 3 4 5 6" componentsSeparatedByString:@" "];
        _dataSource = [_dataSource arrayByAddingObjectsFromArray:_dataSource];
    }
    return _dataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)dismissViewController
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
