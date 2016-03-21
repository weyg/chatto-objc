//
//  VIOSChatLayoutMaker.h
//  vipole
//
//  Created by Aziz Latypov on 17/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "VIOSLayoutItemProtocol.h"

@class VIOSChatLayoutMaker;

/**
 Class is responsible for construction of CollectinViewLayoutAttributes for displaying in some kind of Chat container views.
 
 @param layoutItems an array of items conforming to protocol VIOSLayoutItemProtocol. The item at index 0 will be placed at the bottom of container view. Next one will be placed on top of it, etc.
 
 @returns an array of UICollectionViewLayoutAttributes objects with @b bounds and @b center set accordingly.
 
 @note note boxes are always sticked to bottom; for now there is no way to provide space for footer; neither there exist any way to provide inter box vertical spacing.
 */
@interface VIOSChatLayoutMaker : NSObject <VIOSLayoutMaker>

@end
