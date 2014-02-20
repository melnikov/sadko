//
//  UIBaseViewController.h
//  SadkoProto
//

#import <UIKit/UIKit.h>

typedef void(^ButtonActionBlock)(void);

@interface UIBaseViewController : UIViewController

- (id)initFromNib;

- (void) setLeftNavigationBarButtonWithImage:(UIImage *)image
                                pressedImage:(UIImage *)pressedImage
                                       block:(ButtonActionBlock)block;

- (void) setRightNavigationBarButtonWithImage:(UIImage *)image
                                 pressedImage:(UIImage *)pressedImage
                                        block:(ButtonActionBlock)block;

- (void) setLeftNavigationBarButtonWithImage:(UIImage *)image
                                pressedImage:(UIImage *)pressedImage
                                       title:(NSString *)title
                                       block:(ButtonActionBlock)block;

- (void) setRightNavigationBarButtonWithImage:(UIImage *)image
                                 pressedImage:(UIImage *)pressedImage
                                        title:(NSString *)title
                                        block:(ButtonActionBlock)block;

@end
