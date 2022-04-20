//
//  LRUCache-OC.m
//  LRU缓存工具类
//  本类只是实现LRU思路，并没有进行真正意义的本地缓存数据。具体采用什么方式进行本地缓存，请自行添加。
//  Created by Miracle on 2022/4/20.
//

#import "LRUCache-OC.h"

@interface LRUCache_OC()

/// 最大数量
@property(nonatomic,assign) int maxCount;

/// 存放key的数组
@property(nonatomic,strong) NSMutableArray * keysArr;

/// 存放数据的字典
@property(nonatomic,strong) NSMutableDictionary * dataDic;

@end

@implementation LRUCache_OC


+(instancetype)shard{
    
    static LRUCache_OC * _shard;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shard = [[[self class] alloc] init];
    });
    return _shard;
}


/// 创建/重置方法
/// @param maxCount 最大缓存数量
-(void)initOrResetWithMaxCount:(int)maxCount{
    
    self.maxCount = maxCount;
    self.keysArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.dataDic = [[NSMutableDictionary alloc]initWithCapacity:0];
}

/// 添加缓存
-(void)addWithKey:(NSString *)key value:(id)value{
    
    //是否已经存在了
    BOOL isExist = [self.keysArr containsObject:key] && [self.dataDic.allKeys containsObject:key];
    
    //存数据
    [self.dataDic setValue:value forKey:key];
    
    //将key移动到最前面
    if (isExist) {
        [self moveToHeaderForKey:key];
    } else {
        [self.keysArr insertObject:key atIndex:0];
    }
    
    //超出最大限制，删除末位数据
    if (self.keysArr.count > self.maxCount) {
        NSString * lastKey = self.keysArr.lastObject;
        [self removeWithKey:lastKey];
    }
}


/// 将key移动到最前面
-(void)moveToHeaderForKey:(NSString *)key{
    
    //如果不包含，直接返回
    if (![self.keysArr containsObject:key]) {
        return;
    }
    
    [self.keysArr removeObject:key];
    [self.keysArr insertObject:key atIndex:0];
}


/// 根据key删除数据
-(void)removeWithKey:(NSString *)key{
    
    if ([self.dataDic.allKeys containsObject:key]) {
        [self.dataDic removeObjectForKey:key];
    }
    
    if ([self.keysArr containsObject:key]) {
        [self.keysArr removeObject:key];
    }
}


/// 根据key获取数据
-(id)getDataWithKey:(NSString *)key{
    
    id data = [self.dataDic objectForKey:key];
    
    [self moveToHeaderForKey:key];
    
    return data;
}


@end
