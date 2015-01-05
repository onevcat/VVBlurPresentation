# VVBlurPresentation

A simple way to present a view controller with keeping the blurred previous one.

It uses `UIBlurEffectStyle` in iOS 8 SDK, so it is only compatibility with iOS 8 and later.

## Screenshot

A demo is better than 100 words.

![Screenshot](https://raw.github.com/onevcat/VVBlurPresentation/master/Gif/screenshot.gif)

## How to Install

### CocoaPods

The easiest way to integrate `VVBlurPresentation` into your project would be using [CocoaPods](http://cocoapods.org). Add the snippet to your Podfile under the correct target and run `pod install`.

    pod 'VVBlurPresentation'

### Manually

Clone the repo and add files under `Source` folder to your project.

## How to Use

Briefly, make your presented view controller as a subclass of `VVBlurViewController`, then present it as usual.

You can use it with both code and storyboard.

1. Create or change your presented view controller as a subclass of `VVBlurViewController`.

        //PresentedViewController.h
        #import "VVBlurViewController.h"
        @interface PresentedViewController : VVBlurViewController

        @end

        //PresentedViewController.m
        //...

2. Create an instance of `PresentedViewController` and present it from your presenting view controller.

        //PresentingViewController.m
        
        #import "PresentedViewController.h"

        //
        - (void)present {
            PresentedViewController *pvc = [PresentedViewController new];
            [self presentViewController:pvc animated:YES completion:nil];
        }

If you are using storyboard, change the class of your view controller to the subclass of `VVBlurViewController` (`PresentedViewController` here). Then use a "Present Modally" segue to present the new view controller.

## Blur Styles

All three blur styles (`UIBlurEffectStyleExtraLight`, `UIBlurEffectStyleLight` and `UIBlurEffectStyleDark`) are supported. You can set the `blurStyle` property of presented view controller to change the style. The default is dark.

## License

`VVBlurPresentation` is released under MIT license.
