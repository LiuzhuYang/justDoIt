//
//  HomeViewController.m
//  justDoIt
//
//  Created by liuzhu on 2017/4/26.
//  Copyright © 2017年 liuzhu. All rights reserved.
//

#import "HomeViewController.h"
#import "SNData.h"
@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (IBAction)mairuTest:(UIButton *)sender
{
    double money = 0-[self.moneyTF.text doubleValue];
    NSString* moneyStr = [NSString stringWithFormat:@"%.2f",money];
    [SNData saveMoney:@"1111" money:moneyStr time:@"111111"];
}
- (IBAction)maichuTest:(UIButton *)sender
{
    double money = [self.moneyTF.text doubleValue];
    NSString* moneyStr = [NSString stringWithFormat:@"%.2f",money];
    [SNData saveMoney:@"1111" money:moneyStr time:@"111111"];
}
- (IBAction)shuaxin:(UIButton *)sender
{
    self.buyAllMoney.text = [SNData loadBuyMoney];
    self.sellAllMoney.text = [SNData loadSellMoney];
    
}

@end
