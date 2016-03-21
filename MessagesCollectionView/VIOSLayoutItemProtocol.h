//
//  VIOSLayoutItemProtocol.h
//  vipole
//
//  Created by Aziz Latypov on 17/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VIOSLayoutSourceItem

/**
 Should return self height.
 */
- (CGFloat)heightWithFixedWidth:(CGFloat)fixedWidth;

/**
 Should return absolute item height (e.g. self height + heights of all child items recursively).
 */
- (CGFloat)absoluteHeightWithFixedWidth:(CGFloat)fixedWidth;

/**
 An array of child items.
 */
@property (nonatomic, readonly) NSArray <id<VIOSLayoutSourceItem>>* items;

@end

@protocol VIOSLayoutAttributesItem

@property (nonatomic, assign) CGPoint center; // in parent's coordinate system
@property (nonatomic, assign) CGSize size;
@property (nonatomic, readonly) NSArray <id<VIOSLayoutAttributesItem>>* items;

- (BOOL)isEqual:(id)object;

@end

@protocol VIOSLayoutMaker
- (id<VIOSLayoutAttributesItem>)layoutAttributesWithSourceItem:(id<VIOSLayoutSourceItem>)layoutSourceItem fixedWidth:(CGFloat)fixedWidth minimalHeight:(CGFloat)minimalHeight;
@end