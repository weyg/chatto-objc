//
//  VIOSLayoutItemProtocol.h
//  vipole
//
//  Created by Aziz Latypov on 17/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VIOSLayoutSourceItem

- (CGFloat)heightWithFixedWith:(CGFloat)fixedWidth;

@property (nonatomic, readonly) NSArray <id<VIOSLayoutSourceItem>>* items;

@end

@protocol VIOSLayoutAttributesItem

@property (nonatomic, assign) CGPoint center; // in parent's coordinate system
@property (nonatomic, assign) CGSize size;
@property (nonatomic, readonly) NSArray <id<VIOSLayoutAttributesItem>>* items;

- (BOOL)isEqual:(id)object;

@end

@protocol VIOSLayoutMaker
- (id<VIOSLayoutAttributesItem>)layoutAttributesWithSourceItem:(id<VIOSLayoutSourceItem>)layoutSourceItem
                                                containerFrame:(CGRect)containerFrame;
@end