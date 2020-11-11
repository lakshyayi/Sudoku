//
//  SuccessView.swift
//  Sudoku
//
//  Created by Lakshya on 2020/11/9.
//

import SwiftUI

struct SuccessView: View {
    @ObservedObject var sudokuModel:SudokuModel
    @State private var isAnimating = false

    var body: some View {
        ZStack{
            Color.purple.opacity(0.5)
            VStack(alignment: .center, spacing: 0){
                Text("You Win")
                    .font(.system(size: 18))
                    .foregroundColor(Color.black.opacity(0.8))
                    .frame(width: sudokuModel.size * 3, height: sudokuModel.size * 3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
              
            }

          
        }
        .frame(width: sudokuModel.size*9, height: sudokuModel.size*9, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .opacity(0.8)
    
    }
}
//struct SuccessView_Previews: PreviewProvider {
//    static var previews: some View {
//        SuccessView()
//    }
//}
