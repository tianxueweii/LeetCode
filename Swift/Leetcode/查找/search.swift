//
//  search.swift
//  Leetcode
//
//  Created by 田学为 on 2020/12/29.
//  Copyright © 2020 田学为. All rights reserved.
//

import Foundation

/// 二分查找
func binarySearch(_ nums: [Int], _ target: Int) -> Int {
    guard nums.count != 0 else {
        return -1
    }
    if nums.count == 1 && nums[0] != target {
        return -1
    }
    var left = 0
    var right = nums.count - 1
    var position = 0
    while right >= left {
        position = (right + left) / 2
        if nums[position] == target {
            return position
        }
        if nums[position] > target {
            right = position - 1
        } else {
            left = position + 1
        }
    }
    return -1
}
