//
//  NumCell.swift
//  Sudoku
//
//  Created by Lakshya on 2020/11/1.
//

import SwiftUI

struct NumCell:View{

    var cellRow: Int
    var cellCol: Int
    @ObservedObject var sudokuModel: SudokuModel
    
    var initvalue: String?
    var inputvalue: String?
   
    init(cellRow:Int,cellCol:Int,sudokuModel:SudokuModel){
        self.cellCol=cellCol
        self.cellRow=cellRow
        self.sudokuModel=sudokuModel
        self.initvalue = (sudokuModel.board[cellRow][cellCol] != nil) ? String(sudokuModel.board[cellRow][cellCol]!) : nil
        self.inputvalue = (sudokuModel.result[cellRow][cellCol] != nil) ? String(sudokuModel.result[cellRow][cellCol]!) : nil
        
    }
    func getBackColor()->Color{
        if sudokuModel.selRow == cellRow && sudokuModel.selCol == cellCol{//选中格子
            return Color(hex:0xf33333)
        }
        if sudokuModel.selRow == cellRow || sudokuModel.selCol == cellCol{//选中行列
            return Color(hex:0xccddee)
        }
        let  val = initvalue ?? (inputvalue ?? "0")
        if sudokuModel.selNum == val && val != "0"{//选中数字
            return Color(hex:0xa12345)
        }
        
        return Color(hex:0xaaa9ff)
    }
    var body : some View {
        Button(action:{
            sudokuModel.cellClick(initValue: initvalue, inputValue: inputvalue, cellRow: cellRow, cellCol: cellCol)
        },
        label: {
            Text(initvalue ?? (inputvalue ?? " "))
                .font(.system(size: 18))
                .foregroundColor(Color.black.opacity(0.75))
                .frame(width: self.sudokuModel.size, height: self.sudokuModel.size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(
                    Rectangle()
                        .fill(getBackColor().opacity(initvalue == nil ? 0.2 : 0.3))
                        .frame(width: self.sudokuModel.size, height: self.sudokuModel.size)
                        .border(Color.gray, width: 0.5)
                )
            
        })
    }
   
    
}
