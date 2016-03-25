//
//  NSSet+BlockKit.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 23/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet (BlockKit)
- (NSSet *)bk_reject:(BOOL (^)(id obj))block;
@end
