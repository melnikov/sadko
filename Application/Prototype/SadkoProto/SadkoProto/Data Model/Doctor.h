//
//  Doctor.h
//  SadkoProto
//
//  Created by Artyom Syrov on 21.04.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Doctor : NSObject

@property (nonatomic, assign) NSInteger branch;
@property (nonatomic, retain) NSString* first;
@property (nonatomic, retain) NSString* middle;
@property (nonatomic, retain) NSString* last;
@property (nonatomic, retain) NSString* speciality;
@property (nonatomic, retain) NSString* resume;
@property (nonatomic, retain) NSString* picture;
@property (nonatomic, retain) NSString* time;

- (id)initWithDictionary:(NSDictionary*)info;

@end
