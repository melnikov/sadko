//
//  UIDoctorCategoryViewController.h
//  SadkoProto
//

#import "UIBaseViewController.h"

@interface UIDoctorCategoryViewController : UIBaseViewController <UITableViewDataSource, UITableViewDelegate>

- (id)initWithClinicInfo:(NSDictionary*)clinic;

@end
