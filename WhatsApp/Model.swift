//
//  Model.swift
//  WhatsApp
//
//  Created by Nunzio Ricci on 23/11/22.
//

import Foundation

class Model: ObservableObject {
    @Published var currentTab: Tab = .state
    @Published var overlyingPage: Overlying? = nil
}

enum Tab {
    case state
}

enum Overlying {
    case stateCarusel
}
