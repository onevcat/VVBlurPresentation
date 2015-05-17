//
//  VVBlurPresentationController.m
//
//  Copyright (c) 2015 Wei Wang (http://onevcat.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "VVBlurPresentationController.h"

@interface VVBlurPresentationController ()
//We need an effect container view to suppress the annoying warning on alpha of a visual effect view.
@property (nonatomic, strong) UIView *effectContainerView;
@property (nonatomic, strong) UIVisualEffectView *dimmingView;
@end

@implementation VVBlurPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController style:(UIBlurEffectStyle)style {
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:style];
        _dimmingView = [[UIVisualEffectView alloc] initWithEffect:effect];
        _blurStyle = style;
        _effectContainerView = [UIView new];
        _effectContainerView.alpha = 0.0;
    }
    return self;
}

- (void)presentationTransitionWillBegin {
    self.effectContainerView.frame = self.containerView.bounds;
    self.dimmingView.frame = self.containerView.bounds;

    [self.effectContainerView insertSubview:self.dimmingView atIndex:0];
    [self.containerView insertSubview:self.effectContainerView atIndex:0];
    
    self.effectContainerView.alpha = 0.0;
    
    id <UIViewControllerTransitionCoordinator> coordinator = [self.presentedViewController transitionCoordinator];
    if (coordinator) {
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            self.effectContainerView.alpha = 1.0;
        } completion:nil];
    } else {
        self.effectContainerView.alpha = 1.0;
    }
}

- (void)dismissalTransitionWillBegin {
    id <UIViewControllerTransitionCoordinator> coordinator = [self.presentedViewController transitionCoordinator];
    if (coordinator) {
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            self.effectContainerView.alpha = 0.0;
        } completion:nil];
    } else {
        self.effectContainerView.alpha = 0.0;
    }
}

-(void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        if (self.vv_presentationDelegate && [self.vv_presentationDelegate respondsToSelector:@selector(presentationControllerDidDismissed:)]) {
            [self.vv_presentationDelegate presentationControllerDidDismissed:self];
        }
    }
}

- (void)containerViewWillLayoutSubviews {
    self.effectContainerView.frame = self.containerView.bounds;
    self.dimmingView.frame = self.containerView.bounds;
    self.presentedView.frame = self.containerView.bounds;
}

- (BOOL)shouldPresentInFullscreen {
    return YES;
}

- (UIModalPresentationStyle)adaptivePresentationStyle {
    return UIModalPresentationCustom;
}

- (void)setBlurStyle:(UIBlurEffectStyle)blurStyle {
    if (blurStyle != _blurStyle) {
        _blurStyle = blurStyle;
        
        UIView *previousDimmingView = _dimmingView;
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:blurStyle];
        self.dimmingView = [[UIVisualEffectView alloc] initWithEffect:effect];
        NSArray *subviews = [self.effectContainerView subviews];
        for (UIView *view in subviews) {
            if (view == previousDimmingView) {
                self.dimmingView.frame = previousDimmingView.frame;
                [self.effectContainerView insertSubview:self.dimmingView aboveSubview:previousDimmingView];
                [previousDimmingView removeFromSuperview];
            }
        }
    }
}

@end
