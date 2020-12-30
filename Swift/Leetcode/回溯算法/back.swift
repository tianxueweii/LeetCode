//
//  back.swift
//  Leetcode
//
//  Created by 田学为 on 2020/12/28.
//  Copyright © 2020 田学为. All rights reserved.
//


import Foundation

/**
 回溯范式
 其核心就是 for 循环里面的递归，在递归调用之前「做选择」，在递归调用之后「撤销选择」
 
 result = []
 def backtrack(路径, 选择列表):
     if 满足结束条件:
         result.add(路径)
         return

     for 选择 in 选择列表:
         做选择
         backtrack(路径, 选择列表)
         撤销选择
 */

class Solution_back {
    
    // MARK:- 面试题 08.09 括号
    func generateParenthesis(_ n: Int) -> [String] {
        var res = [String]()
        
        func back(leftn: Int, rightn: Int, result: String) {
            if result.count == 2 * n {
                res.append(result)
                return
            }
            
            // 剪枝
            if leftn > 0 {
                back(leftn: leftn - 1, rightn: rightn, result: result + "(")
            }
            if leftn < rightn {
                back(leftn: leftn, rightn: rightn - 1, result: result + ")")
            }
        }
        
        back(leftn: n, rightn: n, result: "")
        return res
    }
    
    // MARK:- 面试题 08.12 八皇后
    struct Coord {
        var row: Int
        var column: Int
        
        /// 输出答案
        static func toStrings(n: Int, coords: [Coord]) -> [String] {
            var results = [String]()
            for coord in coords {
                var str = String(repeating: ".", count: n)
                let offsetIndex = str.index(str.startIndex, offsetBy: coord.column)
                str = str.replacingCharacters(in: offsetIndex ..< str.index(after: offsetIndex), with: "Q")
                results.append(str)
            }
            return results
        }
    }
    
    var res = [[String]]()
    func solveNQueens(_ n: Int) -> [[String]] {
        back(n: n, i: 0, coords: [])
        return res
    }
    
    
    /// 回溯
    /// - Parameters:
    ///   - n: 最大边界
    ///   - i: 行
    ///   - coords: dfs缓存
    func back(n: Int, i: Int, coords: [Coord]) {
        var coords = coords
        // dfs结束条件：N皇后摆满
        if coords.count == n {
            res.append(Coord.toStrings(n: n, coords: coords))
            return
        }
        
        // 棋盘上第column行n选择
        for j in 0 ..< n {
            let newCoord = Coord(row: i, column: j)
            var attack = false
            for coord in coords {
                if newCoord.row == coord.row {
                    attack = true
                }
                if newCoord.column == coord.column {
                    attack = true
                }
                if abs(newCoord.column - coord.column) == abs(newCoord.row - coord.row) {
                    attack = true
                }
            }
            // 不会被已有棋子攻击
            if !attack {
                coords.append(newCoord)
                back(n: n, i: i + 1, coords: coords)
                // 回溯
                coords.removeLast()
            }
        }
    }
    
    
    // MARK:- 面试题 08.13 堆箱子
    // 回溯+剪枝，大数据超时
    var result = 0
    func pileBox(_ box: [[Int]]) -> Int {
        var box = box
        box.sort { (el1, el2) -> Bool in
            el1[2] < el2[2]
        }
        back(box: &box, begin: 0, bottom: [], height: 0)
        return result
    }
    
    func back(box: inout [[Int]], begin: Int, bottom: [Int], height: Int) {
        for i in begin ..< box.count {
            if bottom.count == 0 || box[i][0] > bottom[0] && box[i][1] > bottom[1] && box[i][2] > bottom[2] {
                let bottom = box[i]
                let newHeight = height + bottom[2]
                result = result > newHeight ? result : newHeight
                // 剪枝
                back(box: &box, begin: i, bottom: bottom, height: newHeight)
            }
        }
    }
    
    
    // MARK:- 17.22 单词转换
    /**
     每次转换一个字母，转后后单词在字典内
        
     输入:
     beginWord = "hit",
     endWord = "cog",
     wordList = ["hot","dot","dog","lot","log","cog"]

     输出:
     ["hit","hot","dot","lot","log","cog"]
     */
    var path = [String]()
    func findLadders(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> [String] {
        guard wordList.contains(endWord) else {
            return []
        }
        var wordList = wordList
        var endWord = endWord
        var used = Array(repeating: false, count: wordList.count)
        var path = [beginWord]
        _ = back(wordList: &wordList, endWord: &endWord, path: &path, used: &used)
        return self.path
    }
    
    func back(wordList: inout [String], endWord: inout String, path: inout [String], used: inout Array<Bool>) -> Bool {
        for i in 0 ..< wordList.count {
            if used[i] {
                continue
            }
            if String.oneCharDiff(a: wordList[i], b: path.last!) {
                path.append(wordList[i])
                if wordList[i] == endWord {
                    self.path = path
                    return true
                }
                used[i] = true
                if back(wordList: &wordList, endWord: &endWord, path: &path, used: &used) {
                    return true
                }
                // 如果运行到这一步，表示用该节点无法找到最终解，需剪枝
                // used.remove(word)
                path.removeLast()
            }
        }
        return false
    }
    
    
}

extension String {
    /// 比较两个字符串是否相差一个字符， 相等也返回false
    static func oneCharDiff(a: String, b: String) -> Bool {
        if a.count != b.count {
            return false
        }
        var offset = 0
        for i in 0 ..< a.count {
            let aIdx = a.index(a.startIndex, offsetBy: i)
            let bIdx = b.index(b.startIndex, offsetBy: i)
            if a[aIdx] != b[bIdx] {
                offset += 1
            }
            if offset > 1 {
                return false
            }
        }
        return offset == 1
    }
}
