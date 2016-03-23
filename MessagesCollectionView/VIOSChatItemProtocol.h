//
//  VIOSChatItemProtocol.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 23/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import "VIOSUniqueIdentificable.h"

@protocol VIOSChatItemProtocol <NSObject, VIOSUniqueIdentificable>
@property (nonatomic, readonly) NSString *type;
@end

@protocol ChatItemDecorationAttributesProtocol
@property (nonatomic, readonly) CGFloat topMargin;
@property (nonatomic, readonly) CGFloat bottomMargin;
@end

@protocol VIOSDecoratedChatItem
@property (nonatomic, readonly) id<VIOSChatItemProtocol> chatItem;
@property (nonatomic, readonly) id<ChatItemDecorationAttributesProtocol> decorationAttributes;
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
- (BOOL)canHandleChatItem:(id<VIOSChatItemProtocol>)chatItem;
- (id<ChatItemPresenterProtocol>)createPresenterWithChatItem:(id<VIOSChatItemProtocol>)chatItem;
- (NSString*)presenterType;
@end