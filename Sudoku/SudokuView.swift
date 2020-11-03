//
//  SudokuView.swift
//  Sudoku
//
//  Created by administrator on 2020/11/3.
//

import SwiftUI

struct SudokuView: View {
    var sudoku:Sudoku
    @State private var size:CGFloat=UIScreen.main.bounds.width/9.5
    @State private var showKeyboard = false
    @State private var selRow = -1
    @State private var selCol = -1
    @State private var selNum = "0"
    @State private var result:[[Int?]] = [[nil]]
    @State private var board:[[Int?]] = [[nil]]
    init(){
        self.sudoku = Sudoku(digets:3)
        self.board = sudoku.generate()!
        self.size = UIScreen.main.bounds.width/9.5
    }
    var body: some View {
        ZStack{
            Color.white
            VStack(alignment: .center, spacing: 0){
                ForEach(self.board.indices , id: \.self){ i in
                    if(i%3==0){
                        Divider().background(Color.black)
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
                    }
                    HStack(alignment: .center, spacing: 0){
                        ForEach(self.board[i].indices , id: \.self){ j in
                            if(j%3==0){
                                Divider().background(Color.black).border(Color.black, width: 2)
                            }
                            if self.board[i][j] == nil{
                                NumCell(
                                    initvalue : nil,
                                    inputvalue : nil,
                                    cellRow: j,
                                    cellCol: i,
                                    size : $size ,
                                    showKeyboard : $showKeyboard,
                                    selRow: $selRow,
                                    selCol:$selCol,
                                    selNum:$selNum
                                )
                            }else{
                                NumCell(initvalue : String(self.board[i][j]!),
                                        inputvalue : nil,
                                        cellRow: j,
                                        cellCol: i,
                                        size : $size ,
                                        showKeyboard : $showKeyboard,
                                        selRow: $selRow,
                                        selCol:$selCol,
                                        selNum:$selNum
                                )
                            }
                   
                        }
                 
                    }
                }
            }.frame(width: self.size*9, height:  self.size*9, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(3)
            .border(Color.black.opacity(0.7), width: 3)
            if $showKeyboard.wrappedValue{
                KeyBoardView(keysize:$size,selRow: $selRow,selCol:$selCol,selNum:$selNum)
            }
        }
        
       
      
    }

}

struct SudokuView_Previews: PreviewProvider {
    static var previews: some View {
        SudokuView()
    }
}
