//
//  BMAChatItemPresenterProtocol.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 25/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BMAChatItemDecorationAttributesProtocol.h"

@protocol BMAChatItemPresenterProtocol <NSObject>

+ (void)registerCels:(UICollectionView*)collectionView;

- (BOOL)canCalculateHeightInBackground; // default is false
- (CGFloat)heightForCell:(CGFloat)maximumWidth decorationAttributes:(id<BMAChatItemDecorationAttributesProtocol>)decorationAttributes;
- (UICollectionViewCell*)dequeueCell:(UICollectionView*)collectionView indexPath:(NSIndexPath*)indexPath;
- (void)configureCell:(UICollectionViewCell*)cell decorationAttributes:(id<BMAChatItemDecorationAttributesProtocol>)decorationAttributes;

@optional
- (void)cellWillBeShown:(UICollectionViewCell*)cell; // optional
- (void)cellWasHidden:(UICollectionViewCell*)cell; // optional
- (BOOL)shouldShowMenu; // optional. Default is false
- (BOOL)canPerformMenuControllerAction:(SEL)action; // optional. Default is false
- (void)performMenuControllerAction:(SEL)action; // optional

@end
