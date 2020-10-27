//
//  BoardView.swift
//  Sudoku
//
//  Created by Lakshya on 2020/10/24.
//
import SwiftUI


struct BoardView: View {
    var sudoku:Sudoku
    var board:[[Int?]]
    var size:CGFloat
    @State private  var showKeyboard = false
    init(){
        self.sudoku = Sudoku(digets:3)
        self.board = sudoku.generate()!
        self.size = UIScreen.main.bounds.width/9.5

    }
    var body: some View {
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
                            Button(action:{
                                self.showKeyboard=true
                            },
                            label: {
                                Text(String(" ")).font(.system(size: 18))
                                                .frame(width: self.size, height: self.size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                .background(
                                                    Rectangle()
                                                        .fill(Color.blue.opacity(0.2))
                                                        .frame(width: self.size, height: self.size)
                                                        .border(Color.gray, width: 0.5)
                                        
                                            )
                                
                            })
                        }else{
                            Text(String(self.board[i][j]!))
                                .font(.system(size: 18))
                                .frame(width: self.size, height: self.size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(
                                    Rectangle()
                                        .fill(Color.blue.opacity(0.2))
                                        .frame(width: self.size, height: self.size)    .border(Color.gray, width: 0.5))
                        }
               
                    }
             
                }
            }
        }.frame(width: self.size*9, height:  self.size*9, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(3)
        .border(Color.black.opacity(0.7), width: 3)
        if $showKeyboard.wrappedValue{
            ZStack{
                Color.white
                VStack(alignment: .center, spacing: 0){
                    ForEach(1...3 , id: \.self){ i in
        
                        HStack(alignment: .center, spacing: 0){
                            ForEach(1...3 , id: \.self){ j in
                                
                                Text(String(i*3+j-3))
                                    .font(.system(size: 18))
                                    .frame(width: self.size, height: self.size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(
                                        Rectangle()
                                            .fill(Color.blue.opacity(0.2))
                                            .frame(width: self.size, height: self.size)    .border(Color.gray, width: 0.5))
                       
                            }
                     
                        }
                        
                    }
                }.frame(width: self.size*3, height:  self.size*4, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(3)
                .border(Color.black.opacity(0.7), width: 3)
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

