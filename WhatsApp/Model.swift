//
//  Model.swift
//  WhatsApp
//
//  Created by Nunzio Ricci on 23/11/22.
//

import SwiftUI

class Model: ObservableObject {
    // Development
    lazy private(set) var isPreview = {
        let isPreview = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        if isPreview {
            self.userList.append(User("Nunzio"))
            self.userList.append(User("Vladimiro"))
            self.userList.append(User("Marina"))
            self.userList.append(User("Valeed"))
            self.userList.append(User("Ali"))
            
            for user in self.userList {
                for i in 1...Int.random(in: 1...8) {
                    let cap = "yotobi \(i)"
                    self.statusList.append(Status(
                        ownerId: user.id,
                        image: UIImage(named: cap)!,
                        caption: cap))
                }
            }
        }
        return isPreview
    }()
    
    // Navigation
    @Published var currentTab: Tab = .status
    @Published var overlyingPage: Overlying? = nil
    
    // Data
    @Published var userList: [User] = []
    @Published var statusList: [Status] = []
    
    func statusList(of owner: User) -> [Status] {
        statusList.filter({ status in
            status.ownerId == owner.id
        })
    }
    
    // Status data
    @Published var statusSerchText = ""
    
}

enum Tab {
    case status
}

enum Overlying {
    case statusCarusel
}
