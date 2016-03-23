//
//  NSArray+BlockKit.h
//  MessagesCollectionView
//
//  Created by Aziz Latypov on 23/03/16.
//  Copyright © 2016 Aziz Latypov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (BlockKit)
- (NSArray*)bk_map:(id(^)(id obj))map;
- (NSArray*)bk_filter:(BOOL(^)(id obj))filter;
- (id)bk_reduce:(id)initialValue withBlock:(id(^)(id result, id obj))reduce;
@end
