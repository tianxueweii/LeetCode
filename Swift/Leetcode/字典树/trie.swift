//
//  Trie.swift
//  Leetcode
//
//  Created by 田学为 on 2020/12/29.
//  Copyright © 2020 田学为. All rights reserved.
//

import Foundation

// 面试题 17.13. 恢复空格

class Solution_trie {
    /// 暴力穷举
    func respace_exhaustion(_ dictionary: [String], _ sentence: String) -> Int {
        guard sentence.count != 0 else {
            return 0
        }

        let dict = Set(dictionary)
        var dp = Array(repeating: 0, count: sentence.count + 1)
        
        for i in 1 ... sentence.count {
            dp[i] = dp[i - 1] + 1
            for j in 0 ..< i {
                let startIdx = sentence.index(sentence.startIndex, offsetBy: j)
                let endIdx = sentence.index(sentence.startIndex, offsetBy: i - 1)
                let substr = sentence[startIdx ... endIdx]
                
                if dict.contains(String(substr)) {
                    dp[i] = min(dp[j], dp[i])
                }
            }
        }
        return dp.last!
    }
    
    // Trie
    func respace(_ dictionary: [String], _ sentence: String) -> Int {
        guard sentence.count > 0 else {
            return 0
        }
        
        let root = Trie()
        for str in dictionary {
            root.insert(str)
        }
        
        var dp = Array(repeating: 0, count: sentence.count + 1)
        for i in 1 ... sentence.count {
            dp[i] = dp[i - 1] + 1
            var trie = root
            
            let endIdx = sentence.index(sentence.startIndex, offsetBy: i)
            let substr = String(sentence[sentence.startIndex ..< endIdx])
            
            for (j, c) in substr.reversed().enumerated() {
                if trie.next[c] == nil {
                    break
                }
                else if trie.next[c]!.isEnd {
                    dp[i] = min(dp[i - j - 1], dp[i])
                }
                if dp[i] == 0 {
                    break
                }
                trie = trie.next[c]!
            }
            
        }
        return dp.last!
    }
    
}


class Trie {
    var next = Dictionary<Character, Trie>()
    var isEnd = false
    
    func insert(_ s: String) {
        var position = self
        for c in s.reversed() {
            if position.next[c] == nil {
                position.next[c] = Trie()
            }
            position = position.next[c]!
        }
        position.isEnd = true
    }
}
