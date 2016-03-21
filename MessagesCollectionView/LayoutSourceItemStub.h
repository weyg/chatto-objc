//
//  LayoutSourceItemStub.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 21/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VIOSLayoutItemProtocol.h"

@interface LayoutSourceItemStub : NSObject <VIOSLayoutSourceItem>

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat absoluteHeight;
@property (nonatomic, assign) CGFloat cachedWidth;
@property (nonatomic, assign) BOOL cachedHeight;

@property (nonatomic, strong) NSArray <id<VIOSLayoutSourceItem>>* items;

- (instancetype)initWithHeight:(CGFloat)height;
- (instancetype)initWithHeight:(CGFloat)height items:(NSArray <id<VIOSLayoutSourceItem>>*)items;

@end
