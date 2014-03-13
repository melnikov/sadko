//
//  UIMainScreenViewController.h
//  SadkoProto
//

#import <UIKit/UIKit.h>

#import "UIBaseViewController.h"

@interface UIMainScreenViewController : UIBaseViewController <UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger currentSlide;

- (id)initWithScript:(NSString*)script;

@end
