//
//  VIOSLayoutAttributesItemObject.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 18/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VIOSLayoutItemProtocol.h"

@interface VIOSLayoutAttributesItemObject : NSObject <VIOSLayoutAttributesItem>
@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, strong) NSArray <id<VIOSLayoutAttributesItem>> *items;

- (instancetype)initWithCenter:(CGPoint)center size:(CGSize)size;
- (instancetype)initWithCenter:(CGPoint)center size:(CGSize)size items:(NSArray <id<VIOSLayoutAttributesItem>> *)items;
@end