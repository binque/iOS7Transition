//
//  PGTransition.h
//  iOS7Transition
//
//  Created by Limboy on 10/14/13.
//  Copyright (c) 2013 Limboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGTransition : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign, getter = isPresenting) BOOL presenting;
@end
