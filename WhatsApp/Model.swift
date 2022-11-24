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
    
     
    func previewSetup() {
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
    @Published var displayOverlay: Bool = false
    
    // Data
    @Published var userList: [User] = []
    @Published var statusList: [Status] = []
    var myAccount: User? {
        userList.first
    }
    
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
    @Published var stateDuration: TimeInterval = 3.0
    @Published var caruselProgress: Double = 0
    @Published var isPaused = false
    @Published var timer: Timer? = nil
    
    func startStory() {
        timer?.invalidate()
        caruselProgress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            withAnimation(.linear(duration: 0.1)) {
                if !self.isPaused {
                    self.caruselProgress += 0.1
                }
                if self.caruselProgress >= self.stateDuration {
                    timer.invalidate()
                    self.nextStatus()
                    self.startStory()
                }
            }
        }
    }
    
    func searchingFor(user: User) -> Bool {
        guard statusSerchText != "" else {
            return true
        }
        return user.name.contains(statusSerchText)
    }
    
    func showInRecentUpdates(_ user: User) -> Bool {
        firstUnviewedStatus(of: user) != nil && user != myAccount
    }
    
    var showRecentUpdates: Bool {
        !userList.filter { user in
            showInRecentUpdates(user)
        }.isEmpty
    }
    
    func showInViewedUpdates(_ user: User) -> Bool {
        !showInRecentUpdates(user) && (firstStatus(of: user) != nil)  && user != myAccount
    }
    
    var showViewedUpdates: Bool {
        !userList.filter { user in
            showInViewedUpdates(user)
        }.isEmpty
    }
    
    func statusShownInThumnail(of user: User) -> Status? {
        firstUnviewedStatus(of: user) ?? firstStatus(of: user)
    }
    
    var currentUserInCarusel: User {
        userList[userIndex]
    }
    
    var currentStatusInCarusel: Status {
        let status = statusList(of: currentUserInCarusel)[statusIndex]
        status.viewed = true
        return status
    }
    
    func selectStatus(of user: User) {
        userIndex = index(of: user) ?? 0
        statusIndex = index(of: statusShownInThumnail(of: user)!, by: user)!
    }
    
    func nextStatus() {
        statusIndex += 1
        if statusIndex >= statusList(of: currentUserInCarusel).count {
            userIndex += 1
            if userIndex >= userList.count {
                userIndex = 0
            }
            statusIndex = 0
        }
        caruselProgress = 0
    }
    
    func previousStatus() {
        statusIndex -= 1
        if statusIndex < 0 {
            userIndex -= 1
            if userIndex < 0 {
                userIndex = userList.count - 1
            }
            statusIndex = statusList(of: currentUserInCarusel).count - 1
        }
        caruselProgress = 0
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
