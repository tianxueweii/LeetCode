//
//  sort.swift
//  Leetcode
//
//  Created by 田学为 on 2020/12/15.
//  Copyright © 2020 田学为. All rights reserved.
//

import Foundation

// MARK:- 快排
func quickSort(_ arr: [Int]) -> [Int] {
    guard arr.count > 1 else {
        return arr
    }
    var sortArr = arr
    let ele = sortArr.removeFirst()
    var leftArr = [Int]()
    var rightArr = [Int]()
    for i in sortArr {
        if i < ele {
            leftArr.append(i)
        } else {
            rightArr.append(i)
        }
    }
    return quickSort(leftArr) + [ele] + quickSort(rightArr)
}

func quickSort2(_ nums: [Int]) -> [Int] {
    var nums = nums
    partition(&nums, 0, nums.count - 1)
    return nums
}

func partition(_ nums: inout [Int], _ l: Int, _ r: Int) {
    guard l < r else {
        return
    }
    var center = l
    for i in l ..< r {
        if nums[i] < nums[r] {
            nums.swapAt(i, center)
            center += 1
        }
    }
    nums.swapAt(center, r)

    partition(&nums, l, center - 1)
    partition(&nums, center + 1, r)
}

// MARK:- 归并排序
func mergeSort(_ nums: [Int]) -> [Int] {
    let length = nums.count
    guard length > 1 else {
        return nums
    }
    let center = length / 2;
    return merge(mergeSort(Array(nums[0 ..< center])), mergeSort(Array(nums[center ..< length])))
}

func merge(_ left: [Int], _ right: [Int]) -> [Int] {
    var result = [Int]()
    var left = left
    var right = right
    while left.count != 0 && right.count != 0 {
        if left[0] < right[0] {
            result.append(left.removeFirst())
        } else {
            result.append(right.removeFirst())
        }
    }
    if !left.isEmpty {
        result.append(contentsOf: left)
    }
    if !right.isEmpty {
        result.append(contentsOf: right)
    }
    return result
}

// MARK:- 堆排序
func heapSort(_ nums: [Int]) -> [Int] {
    guard nums.count > 1 else {
        return nums
    }
    var arr = nums
    // 构建大顶堆
    for i in (0 ... arr.count / 2 - 1).reversed() {
        heapAdjust(&arr, i, arr.count)
    }
    // 和根节点交换，重排根节点
    for len in (0 ..< arr.count).reversed() {
        arr.swapAt(len, 0)
        heapAdjust(&arr, 0, len)
    }
    return arr
}

// [50, 45, 30, 25, 10]
func heapAdjust(_ arr: inout [Int], _ root: Int, _ length: Int) {
    // 指向左节点
    var node = 2 * root + 1
    guard node < length else {
        return
    }
    // 判断右节点是否大于左节点
    if node + 1 < length && arr[node] < arr[node + 1] {
        node += 1
    }
    // 判断左（右）节点是否大于根节点，大于则交换并重排该节点
    if arr[node] > arr[root] {
        arr.swapAt(root, node)
        heapAdjust(&arr, node, length)
    }
}

func minHeapAdjust(_ arr: inout [Int], _ root: Int, _ length: Int) {
    var node = 2 * root + 1
    guard node < length else {
        return
    }
    // 判断右节点是否小于左节点
    if node + 1 < length  && arr[node] > arr[node + 1] {
        node += 1
    }
    if arr[node] < arr[root] {
        arr.swapAt(root, node)
        minHeapAdjust(&arr, node, length)
    }
}

// MARK:- 荷兰国旗排序
// 75. 颜色分类
func sortColors(_ nums: inout [Int]) {
    // p0指向0的待排序位，p1指向1的待排序位
    var p0 = 0, p1 = 0
    for i in 0 ..< nums.count {
        if nums[i] == 1 {
            nums.swapAt(i, p1)
            p1 += 1
        }
        if nums[i] == 0 {
            nums.swapAt(i, p0)
            // p0 < p1 说明将已经排好的1移至了i侧，需要重排1
            if p0 < p1 {
                nums.swapAt(i, p1)
            }
            p0 += 1
            p1 += 1
        }
    }
}



