//
//  Product.h
//  AliPayDemo
//
//  Created by 余亮 on 16/2/21.
//  Copyright © 2016年 余亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property(nonatomic,copy) NSString * title ;

@property(nonatomic,copy) NSString * detail ;

@property(nonatomic, assign)double price ;

- (instancetype) initwithTitle:(NSString * )title detail:(NSString *)detail price:(double)price ;

+ (instancetype) initwithTitle:(NSString * )title detail:(NSString *)detail price:(double)price ;



@end
