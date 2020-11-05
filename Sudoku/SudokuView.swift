//
//  SudokuView.swift
//  Sudoku
//
//  Created by administrator on 2020/11/3.
//

import SwiftUI

struct SudokuView: View {

    @StateObject var sudokuModel: SudokuModel = SudokuModel()
    var tap: some Gesture{
        TapGesture(count: 1).onEnded{
            sudokuModel.hideKeyBoard()
//            self.background(Color.yellow)
        }
    }
    var body: some View {
        GeometryReader{ proxy in
            VStack(alignment: .center, spacing: 0){
                ZStack(alignment:.center){
                    VStack(alignment: .center, spacing: 0){
                        ForEach(sudokuModel.board.indices , id: \.self){ i in
                            if(i%3==0){
                                Divider().background(Color.black)
                                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
                            }
                            HStack(alignment: .center, spacing: 0){
                                ForEach(sudokuModel.board[i].indices , id: \.self){ j in
                                    if(j%3==0){
                                        Divider().background(Color.black).border(Color.black, width: 2)
                                    }
                                    NumCell(cellRow: j,
                                            cellCol: i,
                                            sudokuModel:sudokuModel
                                    )
                           
                                }
                         
                            }
                        }
                    }.frame(width: $sudokuModel.size.wrappedValue*9, height:  $sudokuModel.size.wrappedValue*9, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(3)
                    .border(Color.black.opacity(0.7), width: 3)

                    if $sudokuModel.showKeyboard.wrappedValue{
                        KeyBoardView(sudokuModel: sudokuModel)
                    }

                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                
                Button(action:{
                    sudokuModel.newGame(difficulty:0.8)
                },
                label: {
                    Text("New")
                        .font(.system(size: 18))
                        .foregroundColor(Color.black.opacity(0.75)) .frame(width: self.sudokuModel.size * 2, height: self.sudokuModel.size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(
                            RoundedRectangle(cornerRadius: 12.0)
                                .frame(width: self.sudokuModel.size * 2, height: self.sudokuModel.size)
                        )
                })
               
                
            }
       
        }
        .background(Color.white).gesture(tap).onAppear{
     
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)

      
    }

}

struct SudokuView_Previews: PreviewProvider {
    static var previews: some View {
        SudokuView()
    }
}
