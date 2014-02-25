//
//  UIAboutViewController.h
//  SadkoProto
//

#import "UIBaseViewController.h"

#import <MessageUI/MessageUI.h>

@interface UIAboutViewController : UIBaseViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>

- (id)initWithClinicInfo:(NSDictionary*)clinic;

@end
