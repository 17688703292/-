//
//  DataBase_SearchResult.h
//  DoorLock
//
//  Created by RedSky on 2019/4/3.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataBase_SearchResult : NSObject

+(DataBase_SearchResult *)shareDataBase;

/**
 获取表格内的商品
 */
-(NSMutableArray *)GetAllResutl:(NSString *)tableName Result:(NSString *)Str;

-(void)InsertIntoTableName:(NSString *)tableName Result:(NSString *)Str;//正常插入数据

-(void)DelectIntoTableName:(NSString *)tableName Result:(NSString *)Str;//删除数据

-(void)DelectIntoTableName:(NSString *)tableName;//删除所有数据
@end

NS_ASSUME_NONNULL_END
