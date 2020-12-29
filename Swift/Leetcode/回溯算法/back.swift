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
    
    // MARK:- 括号
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
    
    // MARK:- 八皇后
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
    
}
