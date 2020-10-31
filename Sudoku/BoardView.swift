//
//  BoardView.swift
//  Sudoku
//
//  Created by Lakshya on 2020/10/24.
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



struct NumCell:View{
    var value: String?
    var cellRow: Int
    var cellCol: Int
    @Binding var size: CGFloat
    @Binding var showKeyboard: Bool
    @Binding var selRow: Int
    @Binding var selCol: Int
    var body : some View {
        Button(action:{
            self.showKeyboard = true
            self.selRow = cellRow
            self.selCol = cellCol
        },
        label: {
            Text(value ?? " ")
                .font(.system(size: 18))
                .foregroundColor(Color.black.opacity(0.75))
                .frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(
                    Rectangle()
                        .fill(Color(hex:0xaaa9ff).opacity(value==" " ? 0.2 : 0.3))
                        .frame(width: size, height: size)
                        .border(Color.gray, width: 0.5)
                )
            
        })
    }
   
    
}
struct BoardView: View {
    var sudoku:Sudoku
    var board:[[Int?]]
    @State private var size:CGFloat=UIScreen.main.bounds.width/9.5
    @State private var showKeyboard = false
    @State private var selRow = 0
    @State private var selCol = 0
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
                                    value : nil,
                                    cellRow: j,
                                    cellCol: i,
                                    size : $size ,
                                    showKeyboard : $showKeyboard,
                                    selRow: $selRow,
                                    selCol:$selCol
                                )
                            }else{
                                NumCell(value : String(self.board[i][j]!),
                                        cellRow: j,
                                        cellCol: i,
                                        size : $size ,
                                        showKeyboard : $showKeyboard,
                                        selRow: $selRow,
                                        selCol:$selCol
                                )
                            }
                   
                        }
                 
                    }
                }
            }.frame(width: self.size*9, height:  self.size*9, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(3)
            .border(Color.black.opacity(0.7), width: 3)
            if $showKeyboard.wrappedValue{
                KeyBoardView(keysize:$size,selRow: $selRow,selCol:$selCol)
            }
        }
        
       
      
    }

    
}

 

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BoardView()
        }
    }
}

