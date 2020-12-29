//
//  LRU.swift
//  Leetcode
//
//  Created by 田学为 on 2020/12/27.
//  Copyright © 2020 田学为. All rights reserved.
//

import Foundation

private class Node {
    
    var key: Int
    var value: Int
    var pre: Node?
    var nxt: Node?
    
    init() {
        key = -1
        value = -1
    }
    
    init(key: Int, value: Int) {
        self.key = key
        self.value = value
    }
}

/// LRU淘汰缓存
/// 缓存双链表 head -> node -> node(Low frequency) -> tail
/// map<key, node>
private class LRUCache {
    
    var capacity: Int
    var map: Dictionary<Int, Node>
    
    var head: Node
    var tail: Node
    
    init(_ capacity: Int) {
        self.capacity = capacity
        self.map = Dictionary()
        self.head = Node()
        self.tail = Node()
        self.head.nxt = self.tail
        self.tail.pre = self.head
    }
    
    func get(_ key: Int) -> Int {
        // 取字典判断是否存在，不存在返回-1
        guard let node = map[key] else {
            return -1
        }
        // 取node，并将node插入表头，调整链表
        removeNode(node)
        addToHead(node)
        return node.value
    }
    
    func put(_ key: Int, _ value: Int) {
        guard key != -1 else {
            return
        }
        
        // !!! 此处需判断节点是否存在
        if let node = map[key] {
            // 取node，并将node插入表头，调整链表
            removeNode(node)
            addToHead(node)
            // 修改node存储value
            node.value = value
        } else {
            // 节点插入双链表头
            let node = Node(key: key, value: value)
            addToHead(node)
            // 将kv插入字典
            map[key] = node
            // 判断当map.count > capacity，那么将双链表尾删除，清除节点
            if map.count > capacity {
                let node = tail.pre!
                removeNode(node)
                map.removeValue(forKey: node.key)
            }
        }
    }
    
    func removeNode(_ node: Node) {
        node.pre?.nxt = node.nxt
        node.nxt?.pre = node.pre
    }
    
    func addToHead(_ node: Node) {
        node.pre = head
        node.nxt = head.nxt
        head.nxt?.pre = node
        head.nxt = node
    }
}

/**
 * Your LRUCache object will be instantiated and called as such:
 * let obj = LRUCache(capacity)
 * let ret_1: Int = obj.get(key)
 * obj.put(key, value)
 */
