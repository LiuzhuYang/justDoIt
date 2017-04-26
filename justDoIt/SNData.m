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
    NSString *databasePath = [pathDocuments stringByAppendingPathComponent:@"deviceName.sqlite"];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:databasePath];
    
    [queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_device_name (id integer primary key autoincrement, device_mac text, name text);"];

    }];
    return queue;
}
@end
























