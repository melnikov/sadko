//
//  UIServiceListViewController.h
//  SadkoProto
//

#import "UIBaseViewController.h"

@interface UIServiceListViewController : UIBaseViewController <UITableViewDataSource, UITableViewDelegate>

- (id)initWithClinicInfo:(NSDictionary*)clinic;

@end
