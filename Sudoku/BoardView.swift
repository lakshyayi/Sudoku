//
//  BoardView.swift
//  Sudoku
//
//  Created by Lakshya on 2020/10/24.
//
import SwiftUI


struct KeyBoardView:View{
    @Binding var keysize: CGFloat
    
    var body : some View {
        ZStack{
            Color.white
            VStack(alignment: .center, spacing: 0){
                ForEach(1...3 , id: \.self){ i in
                    HStack(alignment: .center, spacing: 0){
                        ForEach(1...3 , id: \.self){ j in
                            Text(String(i*3+j-3))
                                .font(.system(size: 18))
                                .frame(width: keysize, height: keysize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(
                                    Rectangle()
                                        .fill(Color.blue.opacity(0.2))
                                        .frame(width: keysize, height: keysize)
                                        .border(Color.gray, width: 0.5)
                                )

                        }

                    }

                }
            }
        }.frame(width: keysize*3, height: keysize*4, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .cornerRadius(10).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .border(Color.black.opacity(0.7), width: 3)
        .position(x: 100, y: 100)
    }
   
    
}



struct NumCell:View{
    var value: String
    @Binding var size: CGFloat
    @Binding var showKeyboard: Bool
    
    var body : some View {
        Button(action:{
            self.showKeyboard = true
        },
        label: {
            Text(String(value)).font(.system(size: 18))
                            .frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(
                                Rectangle()
                                    .fill(Color(hex:0xaaa9ff).opacity(0.2))
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
                                NumCell(value : " ", size : $size , showKeyboard : $showKeyboard)
                               
                            }else{
                                
                                NumCell(value : String(self.board[i][j]!), size : $size , showKeyboard : $showKeyboard)
//                                Text(String(self.board[i][j]!))
//                                    .font(.system(size: 18))
//                                    .frame(width: self.size, height: self.size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                                    .background(
//                                        Rectangle()
//                                            .fill(Color(hex:0xaaa9ff).opacity(0.3))
//                                            .frame(width: self.size, height: self.size)    .border(Color.gray, width: 0.5))
                            }
                   
                        }
                 
                    }
                }
            }.frame(width: self.size*9, height:  self.size*9, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(3)
            .border(Color.black.opacity(0.7), width: 3)
            if $showKeyboard.wrappedValue{
                KeyBoardView(keysize:$size)
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

