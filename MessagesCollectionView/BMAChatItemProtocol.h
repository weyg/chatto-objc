//
//  BMAChatItemProtocol.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 23/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "BMAUniqueIdentificable.h"

#import <UIKit/UIKit.h>

@protocol BMAChatItemProtocol <NSObject, BMAUniqueIdentificable>
@property (nonatomic, readonly) NSString *type;
@end

@protocol ChatItemDecorationAttributesProtocol
@property (nonatomic, readonly) CGFloat topMargin;
@property (nonatomic, readonly) CGFloat bottomMargin;
@end

@protocol BMADecoratedChatItem
@property (nonatomic, readonly) id<BMAChatItemProtocol> chatItem;
@property (nonatomic, readonly) id<ChatItemDecorationAttributesProtocol> decorationAttributes;
@end

@interface BMADecoratedChatItemObject : NSObject <BMADecoratedChatItem>
@property (nonatomic, strong) id<BMAChatItemProtocol> chatItem;
@property (nonatomic, strong) id<ChatItemDecorationAttributesProtocol> decorationAttributes;
- (instancetype)initWithChatItem:(id<BMAChatItemProtocol>)chatItem
                      attributes:(id<ChatItemDecorationAttributesProtocol>)attributes;
@end

@protocol ChatItemPresenterProtocol <NSObject>

+ (void)registerCels:(UICollectionView*)collectionView;

- (BOOL)canCalculateHeightInBackground; // default is false
- (CGFloat)heightForCell:(CGFloat)maximumWidth decorationAttributes:(id<ChatItemDecorationAttributesProtocol>)decorationAttributes;
- (UICollectionViewCell*)dequeueCell:(UICollectionView*)collectionView indexPath:(NSIndexPath*)indexPath;
- (void)configureCell:(UICollectionViewCell*)cell decorationAttributes:(id<ChatItemDecorationAttributesProtocol>)decorationAttributes;

@optional
- (void)cellWillBeShown:(UICollectionViewCell*)cell; // optional
- (void)cellWasHidden:(UICollectionViewCell*)cell; // optional
- (BOOL)shouldShowMenu; // optional. Default is false
- (BOOL)canPerformMenuControllerAction:(SEL)action; // optional. Default is false
- (void)performMenuControllerAction:(SEL)action; // optional

@end

@protocol ChatItemPresenterBuilderProtocol
- (BOOL)canHandleChatItem:(id<BMAChatItemProtocol>)chatItem;
- (id<ChatItemPresenterProtocol>)createPresenterWithChatItem:(id<BMAChatItemProtocol>)chatItem;
- (NSString*)presenterType;
@end