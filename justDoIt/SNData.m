//
//  SNData.m
//  sdk-demo
//
//  Created by User on 16/3/18.
//  Copyright © 2016年 Scinan. All rights reserved.
//

#import "SNData.h"
#import "FMDB.h"
@implementation SNData

+(FMDatabaseQueue *)setupDatabase {

    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if (![[NSFileManager defaultManager] fileExistsAtPath:pathDocuments]) {
        [fileManager createDirectoryAtPath:pathDocuments withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *databasePath = [pathDocuments stringByAppendingPathComponent:@"share.sqlite"];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:databasePath];
    
    [queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_money (id integer primary key autoincrement, shareId text, money text,time text);"];
        [db executeUpdate:@"create table if not exists t_share (id integer primary key autoincrement, shareId text, buyAllMoney text,sellAllMoney text,buyShareMoney text,sellShareMoney text,buyLargeCap text,sellLargeCap text,stage text);"];

    }];
    return queue;
}

//向金额表内存入一条记录
+(void)saveMoney:(NSString *)shareId money:(NSString *)money time:(NSString *)time
{
    if (!shareId.length || !money.length || !time.length) {
        return;
    }
    FMDatabaseQueue *queue = [self setupDatabase];
    
    [queue inDatabase:^(FMDatabase *db) {
        
        [db executeUpdate:@"insert into t_money (shareId,money,time) values (?, ?,?)", shareId, money,time];
    }];
    [queue close];
}

//花的钱
+(NSString*)loadBuyMoney
{
        FMDatabaseQueue *queue = [self setupDatabase];
        __block double moneyDouble=0.0;
        __block NSString *money   =    nil;
        [queue inDatabase:^(FMDatabase *db) {
            FMResultSet *resultSet = [db executeQuery:@"select * from t_money where 1==1"];
            while (resultSet.next)
            {
                NSData* moneyData = [resultSet dataForColumn:@"money"];
                money = [[NSString alloc]initWithData:moneyData encoding:NSUTF8StringEncoding];
                if (money.length)
                {
                    if([money doubleValue]<0)
                    {
                        moneyDouble += [money doubleValue];
                    }
                }
            }
        }];
        [queue close];
        return [NSString stringWithFormat:@"%.2f",moneyDouble];
}

//挣的钱
+(NSString*)loadSellMoney
{
    FMDatabaseQueue *queue = [self setupDatabase];
    __block double moneyDouble=0.0;
    __block NSString *money   =    nil;
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQuery:@"select * from t_money where 1==1"];
        while (resultSet.next)
        {
            NSData* moneyData = [resultSet dataForColumn:@"money"];
            money = [[NSString alloc]initWithData:moneyData encoding:NSUTF8StringEncoding];
            if (money.length)
            {
                if([money doubleValue]>0)
                {
                    moneyDouble += [money doubleValue];
                }
            }
        }
    }];
    [queue close];
    return [NSString stringWithFormat:@"%.2f",moneyDouble];
}


//testBranch
@end
