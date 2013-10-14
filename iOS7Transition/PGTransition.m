//
//  PGTransition.m
//  iOS7Transition
//
//  Created by Limboy on 10/14/13.
//  Copyright (c) 2013 Limboy. All rights reserved.
//

#import "PGTransition.h"
#import "PGViewController.h"
#import "PGMacro.h"
#import <QuartzCore/QuartzCore.h>

@implementation PGTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [[transitionContext containerView] addSubview:fromViewController.view];
    [[transitionContext containerView] addSubview:toViewController.view];
    
    if (self.isPresenting) {
        PGViewController *pgViewController = (PGViewController *)fromViewController;
        CGRect touchRect = pgViewController.touchRect;
        CGPoint anchorPoint = CGPointMake(touchRect.origin.x / 320.0, touchRect.origin.y / SCREEN_HEIGHT);
        [self setAnchorPoint:anchorPoint forView:pgViewController.view];
        
        toViewController.view.alpha = 0;
        [self setAnchorPoint:anchorPoint forView:toViewController.view];
        toViewController.view.transform = CGAffineTransformMakeScale(touchRect.size.width / 320.0, touchRect.size.height / SCREEN_HEIGHT);
        
        [UIView animateWithDuration:0.4 animations:^{
            pgViewController.view.transform = CGAffineTransformMakeScale(3, 3);
            pgViewController.view.alpha = 0;
            toViewController.view.transform = CGAffineTransformMakeScale(1, 1);
            toViewController.view.alpha = 1;
            } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        PGViewController *pgViewController = (PGViewController *)toViewController;
        pgViewController.view.transform = CGAffineTransformMakeScale(3, 3);
        
        [UIView animateWithDuration:0.4 animations:^{
            pgViewController.view.transform = CGAffineTransformMakeScale(1, 1);
            pgViewController.view.alpha = 1;
            fromViewController.view.transform = CGAffineTransformMakeScale(0, 0);
            fromViewController.view.alpha = 0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

-(void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}

@end
