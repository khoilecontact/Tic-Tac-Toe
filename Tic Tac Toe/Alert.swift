//
//  Alert.swift
//  Tic Tac Toe
//
//  Created by KhoiLe on 12/01/2022.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let humanWin = AlertItem(title: Text("You win"), message: Text("You win the AI"), buttonTitle: Text("Hell Yeah"))
    
    static let computerWin = AlertItem(title: Text("You lost"), message: Text("You lost  the AI"), buttonTitle: Text("Rematch"))
    
    static let draw = AlertItem(title: Text("Draw"), message: Text("You are as smart as the AI"), buttonTitle: Text("Try again"))
}
