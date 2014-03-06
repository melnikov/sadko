//
//  DataManager.h
//  SadkoProto
//
//  Created by Artyom Syrov on 05.03.14.
//  Copyright (c) 2014 Stex Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(DataManager)

@property (nonatomic, retain) NSMutableArray* filter;
@property (nonatomic, retain) NSString* card;

- (void)resetFilterWithCapacity:(NSInteger)count;

@end
