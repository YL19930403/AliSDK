//
//  Product.m
//  AliPayDemo
//
//  Created by 余亮 on 16/2/21.
//  Copyright © 2016年 余亮. All rights reserved.
//

#import "Product.h"
@implementation Product

- (instancetype)initwithTitle:(NSString *)title detail:(NSString *)detail price:(double)price
{
    if (self == [super init]) {
        self.title = title ;
        self.detail = detail ;
        self.price = price ;
    }
       return self ;
}

+ (instancetype)initwithTitle:(NSString *)title detail:(NSString *)detail price:(double)price
{
    return [[self alloc] initwithTitle:title detail:detail price:price];
}

@end
