//
//  balanced_binary_tree.swift
//  Leetcode
//
//  Created by 田学为 on 2020/11/22.
//  Copyright © 2020 田学为. All rights reserved.
//
// 平衡二叉树
//

import Foundation

class Solution_balanced_binary_tree {
    
    // MARK:- 二叉树深度问题
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        return max(maxDepth(root?.left), maxDepth(root?.right)) + 1
    }
    
    // BFS做法
    func maxDepth_BFS(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        
        var queue: [TreeNode] = [root]
        var level = 0
        
        while !queue.isEmpty {
            var newQueue: [TreeNode] = []
            for node in queue {
                if let left = node.left {
                    newQueue.append(left)
                }
                if let right = node.right {
                    newQueue.append(right)
                }
            }
            level += 1
            queue = newQueue
        }
        return level
    }
    
    // MARK:- 是否平衡二叉树
    
    // 平衡二叉树的深度 等于 左子树的深度 与 右子树的深度 中的 最大值+1
    func isBalanced(_ root: TreeNode?) -> Bool {
        return recur(root) != -1
    }
    
    // 分治、后序遍历，剪枝
    // 思路是对二叉树做后序遍历，从底至顶返回子树深度，若判定某子树不是平衡树则 “剪枝” ，直接向上返回。
    
    func recur(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        
        let left = recur(root.left)
        if left == -1 {
            return -1
        }
        let right = recur(root.right)
        if right == -1 {
            return -1
        }
        
        return abs(left - right) < 2 ? max(left, right) + 1 : -1
    }
}
