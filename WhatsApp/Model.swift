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
        //if isPreview {
            previewSetup()
        //}
        return isPreview
    }()
    
    private func previewSetup() {
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
    
    // Navigation
    @Published var currentTab: Tab = .status
    @Published var overlyingPage: Overlying? = nil
    @Published var animation: Namespace.ID? = nil
    
    // Data
    @Published var userList: [User] = []
    @Published var statusList: [Status] = []
    
    func isStatus(_ status: Status, of user: User) -> Bool {
        status.ownerId == user.id
    }
    
    func index(of theUser: User) -> Int? {
        for (index, aUser) in userList.enumerated() {
            if aUser.id == theUser.id {
                return index
            }
        }
        return nil
    }
    
    func index(of theStatus: Status) -> Int? {
        for (index, aStatus) in statusList.enumerated() {
            if aStatus.id == theStatus.id {
                return index
            }
        }
        return nil
    }
    
    func index(of theStatus: Status, by user: User) -> Int? {
        for (index, aStatus) in statusList(of: user).enumerated() {
            if aStatus.id == theStatus.id {
                return index
            }
        }
        return nil
    }
    
    func statusList(of user: User) -> [Status] {
        statusList.filter({ status in
            isStatus(status, of: user)
        })
    }
    
    func statesCount(of user: User) -> Int {
        statusList(of: user).count
    }
    
    func statesViewedCount(of user: User) -> Int {
        statusList.filter({ status in
            isStatus(status, of: user) && status.viewed
        }).count
    }
    
    func firstStatus(of user: User) -> Status? {
        for status in statusList {
            if isStatus(status, of: user) {
                return status
            }
        }
        return nil
    }
    
    func firstUnviewedStatus(of user: User) -> Status? {
        let userStates = statusList(of: user)
        for status in userStates {
            if !status.viewed {
                return status
            }
        }
        return nil
    }
    
    
    // StatusView data
    @Published var statusSerchText = ""
    @Published var userIndex = 0
    @Published var statusIndex = 0
    
    func showInRecentUpdates(_ user: User) -> Bool {
        firstUnviewedStatus(of: user) != nil
    }
    
    func showInViewedUpdates(_ user: User) -> Bool {
        !showInRecentUpdates(user) && (firstStatus(of: user) != nil)
    }
    
    func statusShownInThumnail(of user: User) -> Status? {
        firstUnviewedStatus(of: user) ?? firstStatus(of: user)
    }
    
    var currentUserInCarusel: User {
        userList[userIndex]
    }
    
    var currentStatusInCarusel: Status {
        statusList(of: currentUserInCarusel)[statusIndex]
    }
    
    func selectStatus(of user: User) {
        userIndex = index(of: user) ?? 0
        statusIndex = index(of: statusShownInThumnail(of: user)!, by: user)!
    }
    
    func nextStatus() {
        statusIndex += 1
        if statusIndex >= statusList(of: currentUserInCarusel).count {
            statusIndex = 0
            userIndex += 1
            if userIndex >= userList.count {
                userIndex = 0
            }
        }
    }
    
    func inCarusel(_ user: User) -> Bool {
        return (overlyingPage == .statusCarusel) && (currentUserInCarusel.name == user.name)
    }
}

enum Tab {
    case status
}

enum Overlying {
    case statusCarusel
}
