//
//  ViewController.m
//  AliPayDemo
//
//  Created by 余亮 on 16/2/21.
//  Copyright © 2016年 余亮. All rights reserved.
//

#import "ViewController.h"
#import "Product.h"

@interface ViewController ()
@property(nonatomic,strong)NSArray * products ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark  -  懒加载

- (NSArray *)products
{
    if (!_products) {
        Product * product1 = [Product initwithTitle:@"iPhone5se" detail:@"土豪金大放送" price:3888];
        Product * product2 = [Product initwithTitle:@"iPhone6 Plus" detail:@"只有16G有货" price:4899];
        Product * product3 = [Product initwithTitle:@"iMac" detail:@"下载微信客户端，豪华礼包抱回家" price:10000];
        Product * product4 = [Product initwithTitle:@"iPod" detail:@"只买最贵的，不买最好的" price:200000];
         Product * product5 = [Product initwithTitle:@"appWatch" detail:@"有钱人的世界你无法想象 " price:9990000];
        self.products = @[product1,product2,product3,product4,product5];
    }
    return _products ;
}

#pragma mark  -  重写TableView的数据源和代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.products.count ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  70 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     static NSString * ID = @"TableViewCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    //取出模型对象
    Product * product = self.products[indexPath.row];
    //给模型对象设置属性
    cell.textLabel.text = product.title ;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"价格为:%.2f",product.price ];
    return cell ;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


@end













