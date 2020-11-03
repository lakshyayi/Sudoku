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
    @Binding var selNum: String
    
    func getBackColor()->Color{
        if selRow == cellRow && selCol==cellCol{//选中格子
            return Color(hex:0xf33333)
        }
        if selRow == cellRow || selCol==cellCol{//选中行列
            return Color(hex:0xccddee)
        }
        let  val = initvalue ?? (inputvalue ?? "0")
        if selNum == val && val != "0"{//选中数字
            return Color(hex:0xa12345)
        }
        
        return Color(hex:0xaaa9ff)
    }
    var body : some View {
        Button(action:{
            if initvalue == nil{
                self.showKeyboard = true
            }else{
                self.showKeyboard = false
                self.selNum = initvalue ?? (inputvalue ?? "0")               
           }
            self.selRow = cellRow
            self.selCol = cellCol
        },
        label: {
            Text(initvalue ?? (inputvalue ?? " "))
                .font(.system(size: 18))
                .foregroundColor(Color.black.opacity(0.75))
                .frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(
                    Rectangle()
                        .fill(getBackColor().opacity(initvalue == nil ? 0.2 : 0.3))
                        .frame(width: size, height: size)
                        .border(Color.gray, width: 0.5)
                )
            
        })
    }
   
    
}
