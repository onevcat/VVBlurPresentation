//
//  VVBlurPresenter.m
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

#import "VVBlurPresenter.h"
#import "VVBlurPresentationController.h"
#import "VVBlurTransitioning.h"

@interface VVBlurPresenter () <VVBlurPresentationControllerDelegate>
@property (nonatomic, strong) VVBlurPresentationController *animationController;
@end

@implementation VVBlurPresenter

- (instancetype)init {
    self = [super init];
    if (self) {
        _blurStyle = UIBlurEffectStyleDark;
    }
    return self;
}

- (VVBlurPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                           presentingViewController:(UIViewController *)presenting
                                                               sourceViewController:(UIViewController *)source {
    if (!self.animationController) {
        self.animationController = [[VVBlurPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting style:self.blurStyle];
        self.animationController.vv_presentationDelegate = self;
    }
    return self.animationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                 presentingController:(UIViewController *)presenting
                                                                     sourceController:(UIViewController *)source {
    
    VVBlurTransitioning *transition = [VVBlurTransitioning new];
    transition.isPresentation = YES;
    return transition;
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    VVBlurTransitioning *transition = [VVBlurTransitioning new];
    transition.isPresentation = NO;
    return transition;
}

- (void)setBlurStyle:(UIBlurEffectStyle)blurStyle {
    if (_blurStyle != blurStyle) {
        _blurStyle = blurStyle;
        self.animationController.blurStyle = blurStyle;
    }
}

-(void)presentationControllerDidDismissed:(VVBlurPresentationController *)controller {
    self.animationController = nil;
}

@end
