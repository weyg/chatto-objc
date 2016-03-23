//
//  VIOSChatCollectionViewLayoutModel.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 21/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol VIOSItemLayoutData;

@protocol VIOSItemLayoutData
@property (nonatomic, readonly) CGFloat height;
@property (nonatomic, readonly) CGFloat topMargin;
@property (nonatomic, readonly) CGFloat bottomMargin;
@property (nonnull, readonly) NSArray <id<VIOSItemLayoutData>> *items;
@end

@interface VIOSChatCollectionViewLayoutModel : NSObject

@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, strong) NSArray <UICollectionViewLayoutAttributes *> *layoutAttributes;
@property (nonatomic, strong) NSArray <NSArray <UICollectionViewLayoutAttributes *>*> *layoutAttributesBySectionAndItem;
@property (nonatomic, assign) CGFloat calculatedForWidth;

+ (instancetype)createModelForCollectionViewWidth:(CGFloat)collectionViewWidth itemsLayoutData:(NSArray <id<VIOSItemLayoutData>>*)itemsLayoutData;

@end
