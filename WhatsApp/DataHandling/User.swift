//
//  User.swift
//  WhatsApp
//
//  Created by Nunzio Ricci on 23/11/22.
//

import Foundation

class User: ObservableObject, Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
    @Published var id: UUID = UUID()
    @Published var name: String
    
    init(_ name: String) {
        self.name = name
    }
}
