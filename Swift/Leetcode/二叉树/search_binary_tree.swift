//
//  search_binary_tree.swift
//  Leetcode
//
//  Created by 田学为 on 2020/11/22.
//  Copyright © 2020 田学为. All rights reserved.
//
//  二叉搜索树
//

import Foundation

// 二叉搜索树，中序遍历为递增序列

class Solution_search_binary_tree {

    // MARK:- 二叉搜索树校验
    func isValidBST(_ root: TreeNode?) -> Bool {
        return trackBST(root, up: Int.max, low: Int.min)
    }

    func trackBST(_ root: TreeNode?, up: Int, low: Int) -> Bool {
        guard let root = root else {
            return true
        }
        if root.val >= up || root.val <= low {
            return false
        }

        return trackBST(root.left, up: root.val, low: low) && trackBST(root.right, up: up, low: root.val)
    }
    
    // MARK:- 二叉搜索树转双链表
    var head: TreeNode?
    var cur: TreeNode?

    func treeToDoublyList(_ root: TreeNode?) {
        treeToDoublyList_dfs(root)
        cur?.right = head
        head?.left = cur
    }

    func treeToDoublyList_dfs(_ root: TreeNode?) {
        guard let root = root else {
            return
        }

        treeToDoublyList_dfs(root.left)

        if cur == nil {
            //    1 .. 3 .. 5 .. 6 .. 7 .. 8 .. 9
            // head/cur
            head = root
        } else {
            //    1 .. 3 .. 5 .. 6 .. 7 .. 8 .. 9
            //   head       cur
            root.left = cur
            cur?.right = root
        }

        cur = root
        treeToDoublyList_dfs(root.right)
    }

    // MARK:- 二叉搜索树第K大节点
    enum KthLargestError: Error {
        case Cross
    }

    var sequence: [Int] = []

    func kthLargest(_ root: TreeNode?, _ k: Int) throws -> Int {
        kthLargest_dfs(root)
        if sequence.count < k {
            throw KthLargestError.Cross
        }
        return sequence[sequence.count - k]
    }

    func kthLargest_dfs(_ root: TreeNode?) {
        guard let root = root else {
            return
        }

        kthLargest_dfs(root.left)
        sequence.append(root.val)
        kthLargest_dfs(root.right)
    }
    
    // MARK:- 二叉搜索树的最近公共祖先
    func lowestCommonAncestor(_ root: TreeNode?, p: TreeNode, q: TreeNode) -> TreeNode? {
        guard let node = root else {
            return root
        }
        
        if node.val > p.val && node.val > q.val {
            return lowestCommonAncestor(node.left, p: p, q: q)
        }
        if node.val < p.val && node.val < q.val {
            return lowestCommonAncestor(node.right, p: p, q: q)
        }
        return node
    }
    
    func lowestCommonAncestor2(_ root: TreeNode?, p: TreeNode, q: TreeNode) -> TreeNode? {
        var root = root
        while root != nil {
            if root!.val > p.val && root!.val > q.val {
                root = root?.left
            }
            else if root!.val < p.val && root!.val < q.val {
                root = root?.right
            }
            else {
                break;
            }
        }
        return root
    }
    
    // MARK:- 二叉搜索树后序遍历序列
    
    func verifyPostorder(_ postorder: [Int]) -> Bool {
        return verifyPostorder_recur(postorder, idx: 0, rootIdx: postorder.count - 1)
    }
    
    func verifyPostorder_recur(_ postorder: [Int], idx: Int, rootIdx: Int) -> Bool {
        guard idx < rootIdx else {
            return true
        }
        // [1, 2, 3, 6, 7, 5]
        // 指定一个标记
        var p = idx;
        while postorder[p] < postorder[rootIdx] {
            p += 1
        }
        // 找到右子树第一个下标
        let rightTreeIdx = p
        while postorder[p] > postorder[rootIdx] {
            p += 1
        }
        // 循环完毕若序列正确，则p应该指向根节点
        return
            p == rootIdx
            && verifyPostorder_recur(postorder, idx: idx, rootIdx: rightTreeIdx - 1)
            && verifyPostorder_recur(postorder, idx: rightTreeIdx, rootIdx: rootIdx - 1)
    }
    
    // MARK: - 有序数列构建二叉搜索树
    // 面试题 04.02. 最小高度树
    
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        var nums = nums
        return create(nums: &nums, left: 0, right: nums.count - 1)
    }

    func create(nums: inout [Int], left: Int, right: Int) -> TreeNode? {
        if left > right {
            return nil
        }

        let center = (left + right) / 2
        let root = TreeNode(nums[center])
        root.left = create(nums: &nums, left: left, right: center - 1)
        root.right = create(nums: &nums, left: center + 1, right: right)
        return root
    }
    
    // MARK: -  二叉搜索树插入
    // 701. 二叉搜索树中的插入操作
    func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        guard root != nil else {
            return TreeNode(val)
        }
        if val < root!.val {
            root!.left = insertIntoBST(root!.left, val)
        } else {
            root!.right = insertIntoBST(root!.right, val)
        }
        return root
    }
}


