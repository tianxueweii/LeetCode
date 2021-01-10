//
//  window.swift
//  Leetcode
//
//  Created by 田学为 on 2021/1/7.
//  Copyright © 2021 田学为. All rights reserved.
//

import Foundation

class Solution_window {
    
    /**
     1. 我们在字符串 S 中使用双指针中的左右指针技巧，初始化 left = right = 0，把索引闭区间 [left, right] 称为一个「窗口」。

     2. 我们先不断地增加 right 指针扩大窗口 [left, right]，直到窗口中的字符串符合要求（包含了 T 中的所有字符）。

     3. 此时，我们停止增加 right，转而不断增加 left 指针缩小窗口 [left, right]，直到窗口中的字符串不再符合要求（不包含 T 中的所有字符了）。同时，每次增加 left，我们都要更新一轮结果。

     4. 重复第 2 和第 3 步，直到 right 到达字符串 S 的尽头。
     */
    
    // 面试题 17.18. 最短超串
    func shortestSeq(_ big: [Int], _ small: [Int]) -> [Int] {
        // 滑动窗口算法
        var result = [Int]()
        var left = 0, right = 0
        var map = Dictionary<Int, Int>()
        for s in small {
            map[s] = 0
        }
        let small = Set(small)
        var full = 0
        
        while right < big.count {
            if small.contains(big[right]) {
                if map[big[right]] == 0 {
                    full += 1
                }
                map[big[right]]! += 1
            }
            // 缩小窗口
            if full >= small.count {
                while left <= right {
                    if small.contains(big[left]) {
                        if map[big[left]]! > 1 {
                            map[big[left]]! -= 1
                        } else {
                            if result.count > 0 {
                                let old = result[1] - result[0]
                                let new = right - left
                                result = old > new ? [left, right] : result
                            } else {
                                result = [left, right]
                            }
                            break
                        }
                    }
                    left += 1
                }
            }
            // 增大窗口
            right += 1
        }
        return result
    }
    
    // 剑指 Offer 57 - II. 和为s的连续正数序列
    func findContinuousSequence(_ target: Int) -> [[Int]] {
        guard target > 1 else {
            return []
        }
        let length = (target % 2 == 0 ? target / 2 : target / 2 + 1)
        var l = 1, r = 1, sum = 1, result = [[Int]]()
        while r <= length {
            if sum == target {
                result.append([Int](l ... r))
                r += 1
                sum += r
            } else if sum > target {
                sum -= l
                l += 1
            } else {
                r += 1
                sum += r
            }
        }
        return result
    }
}
