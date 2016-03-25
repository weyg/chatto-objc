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