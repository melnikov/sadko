//
//  MenuItem.h
//  SadkoProto
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) UIViewController* screen;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, assign) id target;

+ (MenuItem*)menuItemWithTitle:(NSString*)title;

@end
