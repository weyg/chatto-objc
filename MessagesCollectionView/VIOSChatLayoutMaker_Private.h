//
//  VIOSChatLayoutMaker_Private.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 18/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "VIOSChatLayoutMaker.h"

@interface VIOSChatLayoutMaker ()

// protected

- (CGSize)sizeForItem:(id<VIOSLayoutSourceItem>)item containerWidth:(double)width withPrevItemBounds:(CGRect)prevItemBounds prevItemCenter:(CGPoint)prevItemCenter;
- (CGFloat)verticalCenterForItem:(id<VIOSLayoutSourceItem>)item containerWidth:(double)width withPrevItemBounds:(CGRect)prevItemBounds prevItemCenter:(CGPoint)prevItemCenter;
- (CGFloat)horizontalCenterForItem:(id<VIOSLayoutSourceItem>)item containerWidth:(double)width withPrevItemBounds:(CGRect)prevItemBounds prevItemCenter:(CGPoint)prevItemCenter;

@end