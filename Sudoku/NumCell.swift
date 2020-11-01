//
//  NumCell.swift
//  Sudoku
//
//  Created by Lakshya on 2020/11/1.
//

import SwiftUI

struct NumCell:View{
    var initvalue: String?
    var inputvalue: String?
    var cellRow: Int
    var cellCol: Int
    @Binding var size: CGFloat
    @Binding var showKeyboard: Bool
    @Binding var selRow: Int
    @Binding var selCol: Int
    var body : some View {
        Button(action:{
            if initvalue==nil{
                self.showKeyboard = true
                self.selRow = cellRow
                self.selCol = cellCol
            }
        },
        label: {
            Text(initvalue ?? (inputvalue ?? " "))
                .font(.system(size: 18))
                .foregroundColor(Color.black.opacity(0.75))
                .frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(
                    Rectangle()
                        .fill(Color(hex:0xaaa9ff).opacity(initvalue==" " ? 0.2 : 0.3))
                        .frame(width: size, height: size)
                        .border(Color.gray, width: 0.5)
                )
            
        })
    }
   
    
}
