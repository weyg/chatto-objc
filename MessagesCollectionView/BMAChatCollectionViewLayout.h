//
//  BMAMessagesCollectionViewLayout.h
//  vipole
//
//  Created by Aziz Latypov on 17/03/16.
//  Copyright © 2016 vipole. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BMAChatCollectionViewLayoutModel.h"

@protocol BMAChatCollectionViewLayoutDelegate
- (BMAChatCollectionViewLayoutModel*)chatCollectionViewLayoutModel;
@end

@interface BMAChatCollectionViewLayout : UICollectionViewLayout
@property (strong, nonatomic) BMAChatCollectionViewLayoutModel *layoutModel;
@property (weak, nonatomic) id<BMAChatCollectionViewLayoutDelegate> delegate;
@end
