//
//  GameViewModel.swift
//  Tic Tac Toe
//
//  Created by KhoiLe on 12/01/2022.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    // 3 columns in the game
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    // The array to hold 9 moves in the game
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameBoardDisable = false
    @Published var alertItem: AlertItem?
    
    /// Process the players' move
    func processPlayerMove(for position: Int) {
        // Check if the move is occupied
        if isSquareOccupied(in: moves, forIndex: position) { return }
        self.moves[position] = Move(player: .human, boardIndex: position)
        
        // Check for win condition or draw
        if checkWinCondition(for: .human, in: moves) {
            alertItem = AlertContext.humanWin
            return
        }
        
        if checkForDraw(in: moves) {
            alertItem = AlertContext.draw
            return
        }
        
        isGameBoardDisable = true
        
        // AI turns, wait 0.5 second for the AI to make turn
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            let computerPosition = determineComputerMovePosition(in: moves)
            self.moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
            isGameBoardDisable = false
            
            if checkWinCondition(for: .computer, in: moves) {
                alertItem = AlertContext.computerWin
                return
            }
            
            if checkForDraw(in: moves) {
                alertItem = AlertContext.draw
                return
            }
        }
    }
    
    /// Check if a move is occupied
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index })
    }
    
    // If AI can win, then win
    // If AI can't win, if the X can win then block
    // If AI can't block, then take middle square
    // If AI can't take middle square, take random available square
    func determineComputerMovePosition(in moves: [Move?]) -> Int {
        // If AI can win, then win
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 4, 8], [2, 4, 6]]
        
        let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
        let computerPostions = Set(computerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(computerPostions)
            
            if winPositions.count == 1 {
                // Check if the win position is not occupied
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable { return winPositions.first! }
            }
        }
        
        // If AI can't win, if the X can win then block
        let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human }
        let humanPostions = Set(humanMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(humanPostions)
            
            if winPositions.count == 1 {
                // Check if the win position is not occupied
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable { return winPositions.first! }
            }
        }
        
        // If AI can't block, then take middle square
        let centerSquare = 4
        if !isSquareOccupied(in: moves, forIndex: centerSquare) {
            return centerSquare
        }
        
        // If AI can't take middle square, take random available square
        var movePosition = Int.random(in: 0 ..< 9)
        
        while isSquareOccupied(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0 ..< 9)
        }
        
        return movePosition
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 4, 8], [2, 4, 6]]
        
        // Get player move in the array
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPostions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPostions) { return true }
        
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap { $0 }.count == 9
    }
    
    func resetGame() {
    moves = Array(repeating: nil, count: 9)
    }
}
