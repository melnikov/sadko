//
//  UIServiceListViewController.h
//  SadkoProto
//

#import "UIBaseViewController.h"

@interface UIServiceListViewController : UIBaseViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UITextFieldDelegate>

- (id)initWithClinicInfo:(NSDictionary*)clinic;

- (id)initWithAllClinics:(NSArray*)clinics;

@end
