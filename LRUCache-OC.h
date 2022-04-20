//
//  LRUCache-OC.h
//  LRU缓存工具类
//  本类只是实现LRU思路，并没有进行真正意义的本地缓存数据。具体采用什么方式进行本地缓存，请自行添加。
//  Created by Miracle on 2022/4/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRUCache_OC : NSObject

/// 创建/重置方法
/// @param maxCount 最大缓存数量
-(void)initOrResetWithMaxCount:(int)maxCount;

/// 添加缓存
-(void)addWithKey:(NSString *)key value:(id)value;

/// 根据key删除数据
-(void)removeWithKey:(NSString *)key;

/// 根据key获取数据
-(id)getDataWithKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
