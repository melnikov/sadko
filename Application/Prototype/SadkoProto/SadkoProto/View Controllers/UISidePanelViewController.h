//
//  UISidePanelViewController.h
//  MegaTaxi
//

#import "JASidePanelController.h"

typedef void(^ButtonActionBlock)(void);

@interface UISidePanelViewController : JASidePanelController

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
