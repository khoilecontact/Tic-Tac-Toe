//
//  Models.swift
//  Tic Tac Toe
//
//  Created by KhoiLe on 12/01/2022.
//

import Foundation
import SwiftUI

enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}
