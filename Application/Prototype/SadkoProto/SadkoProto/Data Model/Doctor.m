//
//  Doctor.m
//  SadkoProto
//
//  Created by Artyom Syrov on 21.04.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import "Doctor.h"

@implementation Doctor

- (id)initWithDictionary:(NSDictionary*)info
{
    self = [super init];
    if (self)
    {
        self.branch = [info[@"branch"] integerValue];
        self.first = info[@"first"];
        self.middle = info[@"middle"];
        self.last = info[@"last"];
        self.speciality = info[@"speciality"];
        self.resume = info[@"resume"];
        self.picture = info[@"picture"];
        self.time = info[@"time"];
    }
    return self;
}

- (void)dealloc
{
    self.first = nil;
    self.middle = nil;
    self.last = nil;
    self.speciality = nil;
    self.resume = nil;
    self.picture = nil;
    self.time = nil;
    
    [super dealloc];
}

@end
