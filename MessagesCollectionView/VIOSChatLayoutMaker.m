//
//  VIOSChatLayoutMaker.m
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 17/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "VIOSChatLayoutMaker.h"
#import "VIOSChatLayoutMaker_Private.h"

#import "VIOSLayoutAttributesItemObject.h"

@implementation VIOSChatLayoutMaker

- (id<VIOSLayoutAttributesItem>)layoutAttributesWithSourceItem:(id<VIOSLayoutSourceItem>)layoutSourceItem
                                                containerFrame:(CGRect)containerFrame
{
    // pre-conditions
    // ...
    
    NSArray *layoutItems = layoutSourceItem.items;
    NSMutableArray *attributes = [NSMutableArray new];
    NSInteger i,n;
    
    CGRect bounds = containerFrame;
    CGFloat height = bounds.size.height;
    CGFloat width = bounds.size.width;
    
    CGPoint currentCenter, prevCenter;
    CGRect currentFrame, prevFrame;
    CGFloat totalHeight = [layoutSourceItem heightWithFixedWith:width];

    CGFloat xmid = [self horizontalCenterForItem:nil containerWidth:width withPrevItemBounds:CGRectZero prevItemCenter:CGPointZero];
    
    // we start from the bottom of container
    prevCenter = CGPointMake(xmid, height);
    prevFrame = CGRectZero;
    
    n = layoutItems.count;

    for (i=0; i<n; i++) {
        id<VIOSLayoutSourceItem> item = [layoutItems objectAtIndex:i];
        
        CGSize currentSize = [self sizeForItem:item containerWidth:width withPrevItemBounds:prevFrame prevItemCenter:prevCenter];
        currentFrame = CGRectZero;
        currentFrame.size = currentSize;
        
        currentCenter =
        CGPointMake(
                    [self horizontalCenterForItem:item containerWidth:width withPrevItemBounds:prevFrame prevItemCenter:prevCenter],
                    [self verticalCenterForItem:item containerWidth:width withPrevItemBounds:prevFrame prevItemCenter:prevCenter]
                    );
        
        id<VIOSLayoutAttributesItem> attr;
        
        if ([[item items] count] > 0) { // sub-tree
            
            CGFloat itemsHeight = 0, j;
            NSInteger itemsCount = [[item items] count];
            for (j=0; j<itemsCount; j++) {
                id<VIOSLayoutSourceItem> it = [[item items] objectAtIndex:j];
                itemsHeight += [it heightWithFixedWith:width];
            }
            
            currentFrame.size.height += itemsHeight;
            currentCenter.y -= itemsHeight/2;
            
            CGRect attrRect = CGRectZero;
            attrRect.size = currentFrame.size;
            attrRect.origin = currentCenter;
            
            attr = [self layoutAttributesWithSourceItem:item containerFrame:attrRect];  // recursive call
            
            // force new rect
            [attr setCenter:currentCenter];
            [attr setSize:attrRect.size];
            
        } else { // leaf
            
            attr = [[VIOSLayoutAttributesItemObject alloc] initWithCenter:currentCenter size:currentFrame.size];
            
        }
        
        [attributes addObject:attr];
        
        totalHeight += attr.size.height;
        
        prevFrame = currentFrame;
        prevCenter = currentCenter;
    }
    
    // post-conditions
    assert(attributes.count == n);
    
    VIOSLayoutAttributesItemObject *result = [VIOSLayoutAttributesItemObject new];
    result.size = CGSizeMake(width, totalHeight);
    result.center = CGPointMake(xmid, containerFrame.origin.y + height - totalHeight/2); // at the bottom of containerFrame
    result.items = attributes;
    
    return result;
}

#pragma mark - Protected -

- (CGFloat)horizontalCenterForItem:(id<VIOSLayoutSourceItem>)item containerWidth:(double)width withPrevItemBounds:(CGRect)prevItemBounds prevItemCenter:(CGPoint)prevItemCenter {
    return width/2;
}

- (CGFloat)verticalCenterForItem:(id<VIOSLayoutSourceItem>)item containerWidth:(double)width withPrevItemBounds:(CGRect)prevItemBounds prevItemCenter:(CGPoint)prevItemCenter {    
    CGFloat h = [item heightWithFixedWith:width];
    
    CGFloat prevTop = ceil(prevItemCenter.y - prevItemBounds.size.height/2);
    
    return ceil(prevTop - h/2);
}

- (CGSize)sizeForItem:(id<VIOSLayoutSourceItem>)item containerWidth:(double)width withPrevItemBounds:(CGRect)prevItemBounds prevItemCenter:(CGPoint)prevItemCenter {
    CGFloat h = [item heightWithFixedWith:width];
    CGFloat w = width;
    return CGSizeMake(w, h);
}

@end
