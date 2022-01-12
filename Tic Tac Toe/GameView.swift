//
//  GameView.swift
//  Tic Tac Toe
//
//  Created by KhoiLe on 11/01/2022.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        // Use GeometryReader to fit every screens' sizes of iPhone - only available in SwiftUI
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.pink, Color.purple]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all)
                
                VStack {
                    Spacer()
                    LazyVGrid(columns: viewModel.columns, spacing: 5) {
                        ForEach(0..<9) { i in
                            ZStack {
                                GameSquareView(proxy: geometry)
                                
                                PlayerIndicator(systemImageName: viewModel.moves[i]?.indicator ?? "")
                            }
                            .onTapGesture {
                                viewModel.processPlayerMove(for: i)
                            }
                        }
                    }
                    Spacer()
                }
                .disabled(viewModel.isGameBoardDisable)
                .padding()
                // Show alert when alertItem changes
                .alert(item: $viewModel.alertItem, content: { alertItem in
                    Alert(title: alertItem.title, message: alertItem.message,
                          dismissButton: .default(alertItem.buttonTitle, action: { viewModel.resetGame() } ))
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}


