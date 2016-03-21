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

- (id<VIOSLayoutAttributesItem>)layoutAttributesWithSourceItem:(id<VIOSLayoutSourceItem>)layoutSourceItem fixedWidth:(CGFloat)fixedWidth minimalHeight:(CGFloat)minimalHeight
{
    // pre-conditions
    // ...
    
    VIOSLayoutAttributesItemObject *result = nil;
    
    if ([[layoutSourceItem items] count] == 0) { // is a leaf
        
        CGFloat h = [layoutSourceItem absoluteHeightWithFixedWidth:fixedWidth];
        result = [[VIOSLayoutAttributesItemObject alloc] initWithCenter:CGPointZero size:CGSizeMake(fixedWidth, h)];
        
    } else { // subtree -> needs recursive call
        
        NSInteger i,n;
        CGFloat absoluteHeight = [layoutSourceItem absoluteHeightWithFixedWidth:fixedWidth];
        NSArray *layoutItems = layoutSourceItem.items;

        n = layoutItems.count;
        
        NSMutableArray *attributes = [NSMutableArray new];
        
        CGFloat xmid = [self horizontalCenterForItem:nil containerWidth:fixedWidth withPrevItemBounds:CGRectZero prevItemCenter:CGPointZero];
        
        // we start from the bottom of container
        CGFloat prevBottom, prevHeight;
        
        prevBottom = MAX(absoluteHeight, minimalHeight);
        prevHeight = 0;
        
        for (i=0; i<n; i++) {

            id<VIOSLayoutSourceItem> item = [layoutItems objectAtIndex:i];
            
            id<VIOSLayoutAttributesItem> attr = [self layoutAttributesWithSourceItem:item fixedWidth:fixedWidth minimalHeight:0]; // recursive call

            CGRect prevFrame = CGRectMake(0, prevBottom-prevHeight, fixedWidth, prevHeight);
            CGPoint prevCenter = CGPointMake(xmid, prevBottom - prevHeight/2);
            
            CGPoint currentCenter =
            CGPointMake(
                        [self horizontalCenterForItem:item containerWidth:fixedWidth withPrevItemBounds:prevFrame prevItemCenter:prevCenter],
                        [self verticalCenterForItem:item containerWidth:fixedWidth withPrevItemBounds:prevFrame prevItemCenter:prevCenter]
                        );
            
            // set center within parent's bounds
            [attr setCenter:currentCenter];
            
            [attributes addObject:attr];
            
            prevHeight = attr.size.height;
            prevBottom = attr.center.y + prevHeight/2;
        }
        
        // post-conditions
        assert(attributes.count == n);
        
        result = [VIOSLayoutAttributesItemObject new];
        result.size = CGSizeMake(fixedWidth, MAX(absoluteHeight, minimalHeight));
        result.center = CGPointZero; // actually, should not be ever used
        result.items = attributes;
    }
    
    return result;
}

#pragma mark - Protected -

- (CGFloat)horizontalCenterForItem:(id<VIOSLayoutSourceItem>)item containerWidth:(double)width withPrevItemBounds:(CGRect)prevItemBounds prevItemCenter:(CGPoint)prevItemCenter {
    return width/2;
}

- (CGFloat)verticalCenterForItem:(id<VIOSLayoutSourceItem>)item containerWidth:(double)width withPrevItemBounds:(CGRect)prevItemBounds prevItemCenter:(CGPoint)prevItemCenter {    
    CGFloat h = [item absoluteHeightWithFixedWidth:width];
    
    CGFloat prevTop = ceil(prevItemCenter.y - prevItemBounds.size.height/2);
    
    return ceil(prevTop - h/2);
}

@end
