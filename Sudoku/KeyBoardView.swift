//
//  KeyBoardView.swift
//  Sudoku
//
//  Created by Lakshya on 2020/11/1.
//

import SwiftUI


struct KeyBoardView:View{
    
    @Binding var keysize: CGFloat
    @Binding var selRow: Int
    @Binding var selCol: Int
    func getKeyBoardX()->CGFloat{
        if selRow>=5{
            return keysize*CGFloat(Double(selRow)-1.6)
        }else{
            return keysize*CGFloat(3.1+Double(selRow))
        }
    }
    func getKeyBoardY()->CGFloat{
        return keysize*CGFloat(4+selCol)
    }
    var body : some View {
        ZStack{
            Color.white
            VStack(alignment: .center, spacing: 0){
                ForEach(1...3 , id: \.self){ i in
                    HStack(alignment: .center, spacing: 0){
                        ForEach(1...3 , id: \.self){ j in
                            Button(action:{
                             
                            },
                            label: {
                                Text(String(i*3+j-3))
                                    .font(.system(size: 18))
                                    .frame(width: keysize, height: keysize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(
                                        Rectangle()
                                            .fill(Color.blue.opacity(0.2))
                                            .frame(width: keysize, height: keysize)
                                            .border(Color.gray, width: 0.5)
                                    )
                                
                            })
                        

                        }

                    }

                }
                Text(String("清  除"))
                    .font(.system(size: 18))
                    .frame(width: keysize*3, height: keysize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(
                        Rectangle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: keysize*3, height: keysize)
                            .border(Color.gray, width: 0.5)
                    )
            }
            
            .background(
                Rectangle()
                .fill(Color(hex:0xaaa9ff).opacity(0.18))
                    .frame(width: keysize*4, height: keysize*5)
            )
        }
        .frame(width: keysize*3.4, height: keysize*4.4, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .cornerRadius(10).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .position(x: getKeyBoardX(), y: getKeyBoardY())
    }
    
}
