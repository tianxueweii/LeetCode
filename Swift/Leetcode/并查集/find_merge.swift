//
//  find_merge.swift
//  Leetcode
//
//  Created by 田学为 on 2021/1/9.
//  Copyright © 2021 田学为. All rights reserved.
//

import Foundation

// 面试题 17.07. 婴儿名字
class Solution_fm {
    // 声明并查集
    var map = Dictionary<String, String>()

    func find(_ name: String) -> String {
        if map[name] == name {
            return name
        } else {
            return find(map[name]!)
        }
    }

    func merge(aName: String, bName: String) {
        map[find(bName)] = find(aName)
    }

    func trulyMostPopular(_ names: [String], _ synonyms: [String]) -> [String] {
        // 1. 初始化并查集
        var count = Dictionary<String, Int>()
        for name in names {
            let split = name.split(separator: "(")
            let c = String(split[1].split(separator: ")")[0])
            let n = String(split[0])

            map[n] = n
            count[n] = Int(c)
        }
        
        // 2. 合并
        for synonym in synonyms {
            let split = synonym[synonym.index(after: synonym.startIndex) ..< synonym.index(before: synonym.endIndex)]
            let names = split.split(separator: ",")
            let name0 = String(names[0])
            let name1 = String(names[1])
            guard count.keys.contains(name0) && count.keys.contains(name1) else {
                continue
            }
            if name0 < name1 {
                merge(aName: String(name0), bName: String(name1))
            } else {
                merge(aName: String(name1), bName: String(name0))
            }
        }

        // 3. 计数输出
        var result = Dictionary<String, Int>()
        for (k, v) in count {
            let trueName = find(k)
            // 将计数加给老大
            if result[trueName] != nil {
                result[trueName]! += v
            } else {
                result[trueName] = v
            }
        }
        return result.toStringArray()
    }

}

extension Dictionary {
    func toStringArray() -> [String] {
        var result = [String]()
        for (k, v) in self {
            result.append("\(k)(\(v))")
        }
        return result
    }
}
