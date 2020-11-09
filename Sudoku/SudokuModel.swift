//
//  SudokuModel.swift
//  Sudoku
//
//  Created by administrator on 2020/11/4.
//

import Foundation
import SwiftUI

class SudokuModel: ObservableObject{
    @Published var sudoku: Sudoku
    @Published var board:[[Int?]] = [[nil]]
    @Published var size:CGFloat=UIScreen.main.bounds.width/9.5
    @Published var showKeyboard = false
    @Published var selRow = -1
    @Published var selCol = -1
    @Published var success = false
    @Published var selNum = "0"
    @Published var result:[[Int?]] = [[nil]]
    @Published var conflicts = Set<String>()
    init(){
        self.sudoku = Sudoku(digets:3,difficulty: 0.1)
        self.board = sudoku.generate()!
        self.result =  self.board
        
    }
    func newGame(difficulty:Double){
        self.sudoku = Sudoku(digets:3,difficulty: difficulty)
        self.board = sudoku.generate()!
        self.result =  self.board
        self.showKeyboard = false
        self.selRow = -1
        self.selCol = -1
        self.selNum = "0"
    }
    func cellClick(initValue:String?,inputValue:String?,cellRow:Int,cellCol:Int){
        if initValue == nil{
            showKeyboard = true
        }else{
            showKeyboard = false
        }
        selNum = initValue ?? (inputValue ?? "0")
        selRow = cellRow
        selCol = cellCol
         
    }
    func numClick(numValue:String){
        if(numValue=="c"){
            result[selRow][selCol] = nil
            selNum = "0"
            showKeyboard = false
        }else{
            result[selRow][selCol] = Int(numValue)
            selNum = numValue
            showKeyboard = false
            self.conflicts = Set<String>()
            self.checkConflict()
            var blk=sudoku.getBlanks(board: self.result)
            if blk.count == 0 && self.conflicts.count == 0 {
                self.success = true
            }
        }
       
    }
    func checkSubset(array:[Int?],x:Int,y:Int,a:Int,b:Int){
      
        var ar = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        for item in array
         {
            if item != nil{
                let idx = item! - 1
                ar[idx] += 1
            }else{
                continue
            }
         }
        for (index,cnt) in ar.enumerated()
         {
            if cnt > 1 {
                for (idx,item) in array.enumerated()
                {
                    
                    if item != nil && item! == index+1 {
                        var cfl=""
                        if x >= 0 {
                            cfl=String(x)+"."+String(idx)
                        }
                        if y >= 0 {
                            cfl=String(idx)+"."+String(y)
                        }
                        if a >= 0 {
                            cfl=String(3 * a + idx / 3) + "." + String(3 * b + idx % 3)
                        }
                        self.conflicts.insert(cfl)
                    }
                }
            }
         }
    }
    func checkConflict(){
        for i in 0..<9 {
            self.checkSubset(array: self.result[i], x: i, y: -1, a: -1, b: -1)
        }
        for j in 0..<9 {
            var arr:[Int?] = []
            for i in 0..<9 {
                arr.append(self.result[i][j])
            }
            self.checkSubset(array: arr, x: -1, y: j, a: -1, b: -1)
        }
        for a in 0..<3 {
            for b in 0..<3 {
                var tar:[Int?] = []
                for i in 0..<3 {
                    for j in 0..<3 {
                        tar.append(self.result[3 * a + i][3 * b + j])
                    }
                }
                self.checkSubset(array: tar, x: -1, y: -1, a: a, b: b)
            }
        }
    }

    func hideKeyBoard(){
        showKeyboard = false
    }
    
}
