//
//  User.swift
//  WhatsApp
//
//  Created by Nunzio Ricci on 23/11/22.
//

import Foundation

class User: ObservableObject {
    @Published var id: UUID = UUID()
    @Published var name: String
    
    init(_ name: String) {
        self.name = name
    }
}
