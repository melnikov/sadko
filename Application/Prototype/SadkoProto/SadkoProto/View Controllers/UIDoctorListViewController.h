//
//  UIDoctorListViewController.h
//  SadkoProto
//

#import "UIBaseViewController.h"

@interface UIDoctorListViewController : UIBaseViewController <UITableViewDataSource, UITableViewDelegate>

- (id)initWithClinicInfo:(NSDictionary*)clinic andCategory:(NSString*)category;

@end
