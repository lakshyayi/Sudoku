//
//  KeyBoardView.swift
//  Sudoku
//
//  Created by Lakshya on 2020/11/1.
//

import SwiftUI


struct KeyBoardView:View{
    
    @ObservedObject var sudokuModel:SudokuModel
    
    func getKeyBoardX()->CGFloat{
        if sudokuModel.selRow >= 5{
            return sudokuModel.size*CGFloat(Double(sudokuModel.selRow)-1.6)
        }else{
            return self.sudokuModel.size*CGFloat(3.1+Double(sudokuModel.selRow))
        }
    }
    func getKeyBoardY()->CGFloat{
        return sudokuModel.size*CGFloat(4.4+Double(sudokuModel.selCol))
    }
    var body : some View {
        ZStack{
            Color.white
            VStack(alignment: .center, spacing: 0){
                ForEach(1...3 , id: \.self){ i in
                    HStack(alignment: .center, spacing: 0){
                        ForEach(1...3 , id: \.self){ j in
                            let num=String(i*3+j-3)
                            Button(action:{
                                sudokuModel.numClick(numValue: num)
                            },
                            label: {
                                Text(num)
                                    .font(.system(size: 18))
                                    .foregroundColor(Color.black.opacity(0.75))
                                    .frame(width: sudokuModel.size, height: sudokuModel.size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(
                                        Rectangle()
                                            .fill(Color.blue.opacity(0.2))
                                            .frame(width: sudokuModel.size, height: sudokuModel.size)
                                            .border(Color.gray, width: 0.5)
                                    )
                                
                            })
                        

                        }

                    }

                }
                Button(action:{
                    sudokuModel.numClick(numValue: "num")
                },
                label: {
                    Text(String("清  除"))
                        .font(.system(size: 18))
                        .foregroundColor(Color.black.opacity(0.75))
                        .frame(width: sudokuModel.size*3, height: sudokuModel.size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(
                            Rectangle()
                                .fill(Color.blue.opacity(0.2))
                                .frame(width: sudokuModel.size*3, height: sudokuModel.size)
                                .border(Color.gray, width: 0.5)
                        )
                    
                })
                
            }           
            .background(
                Rectangle()
                .fill(Color(hex:0xaaa9ff).opacity(0.18))
                    .frame(width:sudokuModel.size*4, height:sudokuModel.size*5)
            )
        }
        .frame(width: sudokuModel.size*3.4, height: sudokuModel.size*4.4, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .cornerRadius(10).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .position(x: getKeyBoardX(), y: getKeyBoardY())
    }
    
}
