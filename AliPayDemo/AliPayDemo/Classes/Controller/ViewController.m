//
//  ViewController.m
//  AliPayDemo
//
//  Created by 余亮 on 16/2/21.
//  Copyright © 2016年 余亮. All rights reserved.
//

#import "ViewController.h"
#import "Product.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>


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
    // 1.取出模型对象
    Product * product = self.products[indexPath.row];
    //2.购买商品
    [self buyProduct:product];
}

- (void) buyProduct:(Product *)product
{
   //1.添加partner/seller/privateKey，签约后获得
    NSString * partner = @"" ;
    NSString * seller = @"";
    NSString * privateKey = @"" ;
    
    //2.生成订单
        //2.1 创建订单
    Order * order = [[Order alloc] init];
        //2.2 设置商户ID/账号ID
    order.partner = partner;
    order.seller = seller ;
        //2.3 设置订单号
    order.tradeNO = nil ;
        //2.4 设置产品相关的信息
    order.productName = product.title ;
    order.productDescription = product.detail ;
    order.amount = [NSString stringWithFormat:@"%.2f",product.price];
        //2.5 设置订单常量
    order.service = @"moblie.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
        //2.6 回调URL（异步通知服务器的地址）
    order.notifyURL = @"http://www.baidu.com";
        //2.7 将订单信息拼接成字符串
    NSString * orderSpec = [order description];
    
    //3.对订单进行签名加密
        //3.1 对订单进行加密
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString * signedString = [signer signString:orderSpec];
    
        //3.2 将签名成功的字符串格式化为订单字符串
     NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"", orderSpec, signedString, @"RSA"];
    
    //4. 打开支付宝客户端进行支付
      /*
          (若用户没有安装支付宝客户端)，会直接在应用程序中添加一个WebView，通过网页让用户进行支付，如果网页支付完成，那么会回调下面的callback，支付结果包含在resultDic中
       （若用户安装了支护宝客户端），就会通过支付宝支付，支付完成会调用Appdelegate里面的代理方法 application: openURL:options:
       */
    [[AlipaySDK defaultService] payOrder:orderSpec fromScheme:@"jingdong" callback:^(NSDictionary *resultDic) {
        
    }];
}

@end


























