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
    @Published var selNum = "0"
    @Published var result:[[Int?]] = [[nil]]
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
        }
       
    }
    func checkConflict(numValue:String){
      
       
    }

    func hideKeyBoard(){
        showKeyboard = false
    }
    
}
