//
//  Subviews.swift
//  Tic Tac Toe
//
//  Created by KhoiLe on 12/01/2022.
//

import Foundation
import SwiftUI

struct GameSquareView: View {
    
    var proxy: GeometryProxy
    
    var body: some View {
        Circle()
            .foregroundColor(.blue).opacity(0.5)
            .frame(width: proxy.size.width/3 - 15, height: proxy.size.width/3 - 15)
    }
}

struct PlayerIndicator: View {
    var systemImageName: String
    
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
    }
}
