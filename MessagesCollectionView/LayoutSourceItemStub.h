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

- (instancetype)initWithHeight:(CGFloat)height;
- (instancetype)initWithHeight:(CGFloat)height items:(NSArray <id<VIOSLayoutSourceItem>>*)items;

@end
