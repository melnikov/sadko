//
//  UIDoctorListViewController.h
//  SadkoProto
//

#import "UIBaseViewController.h"

@interface UIDoctorListViewController : UIBaseViewController <UITableViewDataSource, UITableViewDelegate>

- (id)initWithClinicInfo:(NSDictionary*)clinic category:(NSString*)category andBranchIndex:(NSInteger)brahcnID;

@end
