//
//  Sudoku.swift
//  Sudoku
//
//  Created by Lakshya on 2020/10/24.
//

import Foundation
import SwiftUI

class Sudoku{
    private var digets: Int
    private var height: Int
    private var width: Int
    private var difficulty: Double
    private var size: Int
    private var positions = Array<Int>()
    private var indices = Array<Int>()
    private var board = [[Int?]]()
    init(digets: Int?=3,difficulty:Double?=0.5) {
        assert(0.0 < difficulty! && difficulty! < 1.0,"Difficulty must be between 0 and 1")
        self.digets = digets!
        self.height = digets!
        self.width = digets!
        self.difficulty = difficulty!
        self.size = digets!*digets!
    }
    func generate(difficulty:Double?=0.5)->[[Int?]]? {
        assert(0.0 < difficulty! && difficulty! < 1.0,"Difficulty must be between 0 and 1")
        self.difficulty = difficulty!
        let range = 0..<self.size
        self.positions = Array(range)
        self.positions.shuffle()
        for i in range{
            var tmp:[Int?] = []
            for j in range{
                tmp.append( i == positions[j] ? (i + 1) : nil)
            }
            self.board.append(tmp)
        }
        let brg = 0..<self.size*self.size
        self.indices = Array(brg)
        self.indices.shuffle()
        let solution_board = self.solve()
        var problem_board = solution_board!
        for index in indices[0...Int(self.difficulty * Double(self.size) * Double(self.size))]{
            let row_index = index / self.size
            let col_index = index % self.size
            problem_board[row_index][col_index] = nil
        }
        self.board=problem_board
        return problem_board


    }
    func solve(board:[[Int?]]?)->[[Int?]]?{
        var sboard=self.board
        if (board != nil) {
            sboard = board!
        }
        let blanks = self.getBlanks(board:self.board)
        let are_blanks_filled = Array(repeating:false, count:blanks.count)
        let blank_fillers = self.calculateBlankCellFillers(blanks: blanks)
        var solution_board = self.getSolution(board:self.copyBoard(board: sboard)!,blanks: blanks, blank_fillers:blank_fillers, are_blanks_filled: are_blanks_filled)
        var solution_difficulty=0
        if solution_board==nil{
            solution_board = self.empty()
            solution_difficulty = -2
        }
        var blank_count = 0
        for (idx,row) in solution_board!.enumerated(){
            for i in 0..<row.count {
                if row[i] == nil||(!(0...self.size).contains(row[i]!)){
                    solution_board![idx][i] = nil
                    blank_count += 1
                }
            }
        }
        if difficulty == -1{
            self.difficulty = Double(blank_count / self.size / self.size)
        }
        self.board=solution_board!
        return solution_board
    }
    func solve()->[[Int?]]?{
        return self.solve(board:nil)
    }
    private func empty()->[[Int?]]{
       return Array(repeating:Array(repeating:nil, count:self.size), count:self.size)
    }
    private func copyBoard(board:[[Int?]])->[[Int?]]?{
        let copyBoard=board
        return copyBoard
    }
    func getBlanks(board:[[Int?]])->[(Int,Int)]{
        var blanks:[(Int,Int)]=[]
        for i in 0 ..< self.size {
            for j in 0 ..< self.size {
                if board[i][j] == nil{
                    let sc=(i,j)
                    blanks.append(sc)
                }
            }
        }
        return blanks
    }
    private func getSolution(board:[[Int?]],blanks:[(Int,Int)],blank_fillers:[[[Bool]]],are_blanks_filled:[Bool])->[[Int?]]?{
        var board=board
        var are_blanks_filled=are_blanks_filled
        var blank_fillers=blank_fillers
        var min_filler_count:Int?=nil
        var chosen_blank:(Int,Int)?
        var chosen_blank_index:Int = -1
        for (i,blank) in blanks.enumerated(){
            let (x,y) = blank
            if are_blanks_filled[i]{
                continue
            }
            let valid_filler_count = blank_fillers[x][y].filter({$0}).count
            if valid_filler_count==0{
                return nil
            }
            if (min_filler_count == nil) || valid_filler_count < min_filler_count! {
                min_filler_count = valid_filler_count
                chosen_blank = blank
                chosen_blank_index = i
            }
        }

        if chosen_blank == nil{
            return board
        }

        let (row,col)=chosen_blank!
        are_blanks_filled[chosen_blank_index]=true
        var revert_list = Array(repeating: false, count:blanks.count)
        for number in 0..<self.size{
            if !blank_fillers[row][col][number]{
                continue
            }
            board[row][col] = number + 1
            for (i,blank) in blanks.enumerated(){
                let (blank_row,blank_col) = blank
                if blank == chosen_blank! {
                    continue
                }

                if self.isNeighbor(blanka: blank, blankb: chosen_blank!) && blank_fillers[blank_row][blank_col][number]{
                    blank_fillers[blank_row][blank_col][number]=false
                    revert_list[i]=true
                }else{
                    revert_list[i]=false
                }
            }
            var solution_board = self.getSolution(board: board, blanks: blanks, blank_fillers: blank_fillers, are_blanks_filled: are_blanks_filled)
            if  (solution_board != nil){
                return solution_board
            }
            for (index,blank) in blanks.enumerated(){
                if revert_list[index]{
                    var (blank_row,blank_col) = blank
                    blank_fillers[blank_row][blank_col][number]=true
                }

            }
        }
        are_blanks_filled[chosen_blank_index]=false
        board[row][col]=nil
        return nil
    }
    private func isNeighbor(blanka:(Int,Int),blankb:(Int,Int))->Bool{
        let (rowa, cola) = blanka
        let (rowb,colb)=blankb
        if (rowa==rowb || cola==colb) {
            return true
        }
        let grid_rowa=rowa/self.digets
        let grid_cola=cola/self.digets
        let grid_rowb=rowb/self.digets
        let grid_colb=colb/self.digets
        return grid_rowa==grid_rowb&&grid_cola==grid_colb

    }
    private func calculateBlankCellFillers(blanks:[(Int,Int)])->[[[Bool]]]{

        var valid_fillers = Array(repeating:Array(repeating:Array(repeating:true, count:self.size) , count:self.size) , count:self.size)
        for (row,col) in blanks{
            for i in 0 ..< self.size {
                let same_row = self.board[row][i]
                let same_col = self.board[i][col]
                if (same_row != nil) && i != col{
                    valid_fillers[row][col][same_row!-1] = false
                }
                if (same_col != nil) && i != row{
                    valid_fillers[row][col][same_col!-1] = false
                }
            }
            let grid_row = row / self.height
            let grid_col = col / self.width
            let grid_row_start = grid_row * self.height
            let grid_col_start = grid_col * self.width
            for y_offset in 0..<self.height{
                for x_offset in 0..<self.width{
                    if (grid_row_start + y_offset == row ) &&  (grid_col_start + x_offset == col ){
                        continue
                    }
                    let cell = self.board[grid_row_start + y_offset][grid_col_start + x_offset]
                    if cell != nil {
                        valid_fillers[row][col][cell!-1]=false
                    }
                }
            }
        }
        return valid_fillers
    }
    func printBoard(){
        if(self.board != nil){
            for (idx,row) in self.board.enumerated(){
                if(idx%self.digets==0){
                    print("+- - - - -+- - - - -+- - - - -+")
                }
                var tmp=""
                for i in 0..<row.count {
                    if( row[i] != nil){
                        tmp+=" "+String(row[i]!)+" "
                    }else{
                        tmp+="   "
                    }
                    if(i != 8 && i%self.digets==2){
                        tmp+="|"
                    }
                }
                tmp.remove(at: tmp.index(before: tmp.endIndex))
                tmp.remove(at: tmp.startIndex)


                print("|",tmp ,"|")
            }
            print("+- - - - -+- - - - -+- - - - -+")

        }

    }

}

