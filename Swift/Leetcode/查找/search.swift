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
    var left = 0, right = nums.count - 1
    while left <= right {
        let mid = (right + left) / 2
        if nums[mid] == target {
            return mid
        }
        if nums[mid] > target {
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    return -1
}

func binarySearch2(_ nums: [Int], _ target: Int) -> Int {
    guard nums.count > 0 else {
        return -1
    }
    var left = 0, right = nums.count - 1
    while left + 1 < right {
        let mid = left + (right - left) / 2
        if nums[mid] >= target {
            right = mid
        } else {
            left = mid
        }
    }
    if nums[left] == target {
        return left
    }
    if nums[right] == target {
        return right
    }
    return -1
}
