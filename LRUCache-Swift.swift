//
//  LRUCache.swift
//  LRU缓存工具类
//  本类只是实现LRU思路，并没有进行真正意义的本地缓存数据。具体采用什么方式进行本地缓存，请自行添加。
//  Created by Miracle on 2022/4/15.
//


import UIKit

class LRUCache: NSObject {

    static let shared = LRUCache()
    
    
    // MARK: 私有属性
    
    
    /// 最大数量
    private var maxCount: Int = 0
    
    /// 存放key的数组
    private var keysArr: [String] = [String]()
    
    /// 存放数据的字典
    private var dataDic: [String:Any] = [String:Any]()
    
    
    // MARK: 公开方法
    
    /// 创建/重置方法
    /// - Parameter maxCount: 最大缓存数量
    func initOrReset(maxCount: Int) {
        
        //赋值最大缓存数量
        self.maxCount = maxCount
        
        //清空记录的内容
        keysArr.removeAll()
        dataDic.removeAll()
    }
    
    
    /// 增加数据缓存方法
    /// - Parameters:
    ///   - value: 数据
    ///   - key: key
    func add(value: Any, key: String) {
        
        //是否已经存在了
        let isExist = keysArr.contains(key) && dataDic.keys.contains(key)
        
        //存数据
        dataDic[key] = value
        
        //将key移动到最前面
        if isExist {
            moveToHeader(key: key)
        } else {
            keysArr.insert(key, at: 0)
        }
        
        //超出最大缓存限制，删除末位数据
        if keysArr.count > maxCount {
            let removeKey = keysArr.last ?? ""
            remove(key: removeKey)
        }
    }
    
    
    /// 根据key删除缓存数据
    func remove(key: String) {
        
        //移除数据字典中的对应数据
        if dataDic.keys.contains(key) {
            dataDic.removeValue(forKey: key)
        }
        
        //移除key数组中的key
        if keysArr.contains(key) {
            keysArr.removeAll(){
                $0 == key
            }
        }
    }
    
    
    /// 根据key获取数据
    func getData(key: String) -> Any {
        
        //根据key取数据
        let data = dataDic[key] as Any
        
        //将key移动到最前面
        moveToHeader(key: key)
        
        return data
    }
    
    
    // MARK: 私有方法
    
    
    /// 将key移动到最前面
    /// - Parameter key: 数据key
    private func moveToHeader(key: String) {
        
        //不包含直接返回
        if !keysArr.contains(key) {
            return
        }
        
        //移除对应的key
        keysArr.removeAll(){
            $0 == key
        }
        
        //将key添加到第0个
        keysArr.insert(key, at: 0)
    }
    
}
