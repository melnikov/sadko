//
//  MenuItem.m
//  SadkoProto
//

#import "MenuItem.h"

static CGFloat kDefaultHeight = 44.0f;

@implementation MenuItem

#pragma mark - Class Methods

+ (MenuItem*)menuItemWithTitle:(NSString *)title
{
    MenuItem* item = [[MenuItem alloc] init];

    item.title = title;

    return [item autorelease];
}

#pragma mark - Initialization/Destruction

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = nil;
        self.screen = nil;
        self.height = kDefaultHeight;
        self.target = nil;
        self.selector = nil;
    }
    return self;
}

- (void)dealloc
{
    self.title = nil;
    self.screen = nil;
    self.target = nil;
    self.selector = nil;

    [super dealloc];
}

@end
