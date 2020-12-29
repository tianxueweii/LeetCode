//
//  binary_tree.swift
//  Leetcode
//
//  Created by 田学为 on 2020/11/22.
//  Copyright © 2020 田学为. All rights reserved.
//
// 二叉树
//

import Foundation

class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

extension TreeNode: Equatable {
    public static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs.left == rhs.left && lhs.right == rhs.right && lhs.val == rhs.val
    }
}

class Solution_binary_tree {
    
    // MARK:- 前序遍历  根 -> 左 -> 右
    func preorderTraveral(_ treeNode: TreeNode?) {
        guard treeNode != nil else {
            return
        }
        
        print(treeNode!.val)
        preorderTraveral(treeNode?.left)
        preorderTraveral(treeNode?.right)
    }
    
    func preorderTraveralStack(_ treeNode: TreeNode?) {
        guard treeNode != nil else {
            return
        }
        
        var temp = treeNode
        var stack = [TreeNode]()
        
        while !stack.isEmpty || temp != nil {
            // 输出，并将左节点递归入栈，直到左节点为空
            while temp != nil {
                print(temp!.val)
                stack.append(temp!)
                temp = temp?.left
            }
            // 如果栈内还有节点，需从栈顶取出节点的右节点继续遍历
            if !stack.isEmpty {
                temp = stack.popLast()
                temp = temp?.right
            }
        }
    }
    
    // MARK:- 中序遍历 左 -> 根 -> 右
    func inorderTraveral(_ treeNode: TreeNode?) {
        guard treeNode != nil else {
            return
        }
        
        preorderTraveral(treeNode?.left)
        print(treeNode!.val)
        preorderTraveral(treeNode?.right)
    }
    
    func inorderTraveralStack(_ treeNode: TreeNode?) {
        guard treeNode != nil else {
            return
        }
        
        var temp = treeNode
        var stack = [TreeNode]()
        
        while !stack.isEmpty || temp != nil {
            // 将左节点递归入栈，直到左节点为空
            while temp != nil {
                stack.append(temp!)
                temp = temp?.left
            }
            // 如果栈内还有节点，需从栈顶取出节点并输出，并且取输出节点的右节点继续遍历
            if !stack.isEmpty {
                temp = stack.popLast()
                print(temp!.val)
                temp = temp?.right
            }
        }
    }
    
    // MARK:- 后续遍历 左 -> 右 -> 根
    func postTraveral(_ treeNode: TreeNode?) {
        guard treeNode != nil else {
            return
        }
        
        preorderTraveral(treeNode?.left)
        preorderTraveral(treeNode?.right)
        print(treeNode!.val)
    }
    
    func postTraveralStack(_ treeNode: TreeNode?) {
        guard treeNode != nil else {
            return
        }
        
        var temp = treeNode
        var last: TreeNode?
        var stack = [TreeNode]()
        
        while !stack.isEmpty || temp != nil {
            // 将左节点递归入栈，直到左节点为空
            while temp != nil {
                stack.append(temp!)
                temp = temp!.left
            }
            
            if !stack.isEmpty {
                temp = stack.popLast()
                
                if temp!.right == nil || temp!.right == last {
                    print(temp!.val)
                    last = temp
                    temp = nil
                } else {
                    stack.append(temp!)
                    temp = temp!.right
                }
            }
        }
    }
    
    
    // MARK:- 层次遍历
    func levelTraveral(_ treeNode: TreeNode?) -> [[Int]] {
        guard let treeNode = treeNode else {
            return []
        }
        
        var result = [[Int]]()
        var queue: [TreeNode] = [treeNode]
        
        while !queue.isEmpty {
            let count = queue.count
            result.append([Int]())
            
            for _ in 0 ..< count {
                let temp = queue.remove(at: 0)
                result[result.count - 1].append(temp.val)
                
                if let left = temp.left {
                    queue.append(left)
                }
                if let right = temp.right {
                    queue.append(right)
                }
            }
        }
        
        return result
    }
    
    // MARK:- 层次遍历逆序
    
    func levelTraveralBottom(_ treeNode: TreeNode?) -> [[Int]] {
        guard let treeNode = treeNode else {
            return []
        }
        
        var result = [[Int]]()
        var queue: [TreeNode] = [treeNode]
        
        while !queue.isEmpty {
            let count = queue.count
            result.insert([Int](), at: 0)
            
            for _ in 0 ..< count {
                let temp = queue.remove(at: 0)
                result[0].append(temp.val)
                
                if let left = temp.left {
                    queue.append(left)
                }
                if let right = temp.right {
                    queue.append(right)
                }
            }
        }
        
        return result
    }
    
    // 层序遍历奇偶数行问题
    
    func zigzagLevelOrder(_ treeNode: TreeNode?) -> [[Int]] {
        guard let treeNode = treeNode else {
            return []
        }
        
        var result = [[Int]]()
        var queue: [TreeNode] = [treeNode]
        var level = 0
        
        while !queue.isEmpty {
            let count = queue.count
            result.append([])
            
            for _ in 0 ..< count {
                let temp = queue.remove(at: 0)
                if level % 2 != 0 {
                    result[result.count - 1].insert(temp.val, at: 0)
                } else {
                    result[result.count - 1].append(temp.val)
                }
                
                if let left = temp.left {
                    queue.append(left)
                }
                if let right = temp.right {
                    queue.append(right)
                }
            }
            
            level += 1
        }
        
        return result
    }
    
    // MARK:- 二叉树公共节点问题
    
    
    // 问题转化为，先序遍历输入root是否存在子节点p，q。如果存在则返回root，不存在则返回null
    func lowestCommonAncestor(_ root: TreeNode?, p: TreeNode, q: TreeNode) -> TreeNode? {
        
        if (root == nil || root == p || root == q) {
            return root
        }
        
        let left = lowestCommonAncestor(root?.left, p: p, q: q)
        let right = lowestCommonAncestor(root?.right, p: p, q: q)
        
        if left == nil {
            return right
        }
        if right == nil {
            return left
        }
        
        return root
    }
    
    
    // MARK:- 二叉树中和为某一值的路径
    
    var result = [[Int]]()
    var path = [Int]()
    
    // 前序遍历，分治，路径记录
    
    func pathSum(_ root: TreeNode?, _ sum: Int) -> [[Int]] {
        pathSum_preorderTraveral(root, sum)
        return result
    }
    
    func pathSum_preorderTraveral(_ root: TreeNode?, _ sum: Int) {
        guard let root = root else {
            return
        }
        
        path.append(root.val)
        
        let tar = sum - root.val
        if tar == 0 && root.left == nil && root.right == nil {
            result.append(path)
        }
        
        pathSum_preorderTraveral(root.left, tar)
        pathSum_preorderTraveral(root.right, tar)
        
        _ = path.popLast()
    }
}

