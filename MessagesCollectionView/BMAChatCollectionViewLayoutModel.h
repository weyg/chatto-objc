//
//  BMAChatCollectionViewLayoutModel.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 21/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BMAItemLayoutData;

@protocol BMAItemLayoutData
@property (nonatomic, readonly) CGFloat height;
@property (nonatomic, readonly) CGFloat bottomMargin;
@property (nonnull, readonly) NSArray <id<BMAItemLayoutData>> *items;
@end

@interface BMAChatCollectionViewLayoutModel : NSObject

@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, strong) NSArray <UICollectionViewLayoutAttributes *> *layoutAttributes;
@property (nonatomic, strong) NSArray <NSArray <UICollectionViewLayoutAttributes *>*> *layoutAttributesBySectionAndItem;
@property (nonatomic, assign) CGFloat calculatedForWidth;

+ (instancetype)createModelForCollectionViewWidth:(CGFloat)collectionViewWidth itemsLayoutData:(NSArray <id<BMAItemLayoutData>>*)itemsLayoutData;

@end
