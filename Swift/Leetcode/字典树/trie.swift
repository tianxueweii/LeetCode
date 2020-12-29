//
//  Trie.swift
//  Leetcode
//
//  Created by 田学为 on 2020/12/29.
//  Copyright © 2020 田学为. All rights reserved.
//

import Foundation

class Solution_trie {
    /// 暴力穷举
    func respace_exhaustion(_ dictionary: [String], _ sentence: String) -> Int {
        guard sentence.count != 0 else {
            return 0
        }

        let dict = Set(dictionary)
        var dp = Array<Int>(repeating: 0, count: sentence.count + 1)
        
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
    
    func respace(_ dictionary: [String], _ sentence: String) -> Int {
        guard sentence.count != 0 else {
            return 0
        }
        var trie = Dictionary<Character, Any>()
        createTrie(dictionary, trie: &trie)
        var dp = Array<Int>(repeating: 0, count: sentence.count + 1)
        
        for i in 1 ... sentence.count {
            dp[i] = dp[i - 1] + 1
            for j in 0 ..< i {
                let startIdx = sentence.index(sentence.startIndex, offsetBy: j)
                let endIdx = sentence.index(sentence.startIndex, offsetBy: i)
                let substr = sentence[startIdx ..< endIdx]
                
                if searchTrie(trie: trie, word: String(substr)) {
                    dp[i] = min(dp[i], dp[j])
                }
            }
        }
        
        return dp.last!
    }
    
    func createTrie(_ dictionary: [String], trie: inout Dictionary<Character, Any>) {
        for str in dictionary {
            var p = trie
            for c in str {
                if p[c] == nil {
                    p[c] = Dictionary<Character, Any>()
                }
                p = p[c] as! [Character : Any]
            }
        }
    }
    
    func searchTrie(trie: Dictionary<Character, Any>, word: String) -> Bool {
        var p = trie
        for c in word {
            if p[c] != nil {
                p = p[c] as! [Character : Any]
            } else {
                return false
            }
        }
        if p.count != 0 {
            return false
        }
        return true
    }
}
