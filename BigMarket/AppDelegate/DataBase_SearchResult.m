//
//  DataBase_SearchResult.m
//  DoorLock
//
//  Created by RedSky on 2019/4/3.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "DataBase_SearchResult.h"
#import <FMDB.h>


@interface DataBase_SearchResult()<NSCopying,NSMutableCopying>{
    FMDatabase  *_db;
    
}
@end

@implementation DataBase_SearchResult

static DataBase_SearchResult *_DBCtl = nil;

+(instancetype)shareDataBase{
    
    
    if (_DBCtl  == nil) {
        _DBCtl = [[super alloc]init];
        [_DBCtl initDataBase];
    }
    return _DBCtl;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [super allocWithZone:zone];
        
    }
    
    return _DBCtl;
    
}

-(id)copy{
    
    return self;
    
}

-(id)mutableCopy{
    
    return self;
    
}

-(id)copyWithZone:(NSZone *)zone{
    
    return self;
    
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    
    return self;
    
}

-(void)initDataBase{
    // 获得Documents目录路径
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 文件路径
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"SearchResult.sqlite"];
    
    
    NSLog(@"我是存储路径----%@",filePath);
    _db = [FMDatabase databaseWithPath:filePath];
    [_db open];
    
    if ([_db open]) {
          [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS Result (str)"];
    }
    [_db close];
}


-(NSMutableArray *)GetAllResutl:(NSString *)tableName  Result:(NSString *)Str{
    
    NSMutableArray *array = [NSMutableArray array];
    
    [_db open];
    
    if (_db) {
     FMResultSet *set  =  [_db executeQuery:[NSString stringWithFormat:@"SELECT *FROM %@",tableName]];
        while ([set next]) {
            //if ([[set stringForColumn:@"str"] containsString:Str]) {
                
                [array addObject:[set stringForColumn:@"str"]];
            //}
        }
    }
    
    [_db close];
    return array;
}

-(void)InsertIntoTableName:(NSString *)tableName Result:(NSString *)Str{
    
    [_db open];
    
    if (_db) {
        [_db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE str = ?",tableName],Str];
        [_db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@(str)VALUES(?)",tableName],Str];
    }
    
    [_db close];
}

-(void)DelectIntoTableName:(NSString *)tableName Result:(NSString *)Str{
    [_db open];
    
    if (_db) {
        [_db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE str = ?",tableName],Str];
    }
    
    [_db close];
}

-(void)DelectIntoTableName:(NSString *)tableName{
    [_db open];
    
    if (_db) {
        [_db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@",tableName]];
    }
    
    [_db close];
}
@end

