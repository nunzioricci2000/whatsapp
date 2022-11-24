//
//  Status.swift
//  WhatsApp
//
//  Created by Nunzio Ricci on 23/11/22.
//

import SwiftUI

class Status: ObservableObject, Equatable {
    static func == (lhs: Status, rhs: Status) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: UUID = UUID()
    var ownerId: UUID
    var image: UIImage
    var caption: String = ""
    var datestamp: Date = Date()
    var viewed: Bool = false
    
    var formattedTimeElapsed: String {
        let sec = Date().timeIntervalSince(datestamp)
        switch sec {
        case ..<60:
            return "now"
        case ..<(60*60):
            let min = sec / 60
            return "\(Int(min.rounded()))m ago"
        default:
            let h = sec / 60 / 60
            return "\(Int(h.rounded()))h ago"
        }
    }
    
    init(ownerId: UUID, image: UIImage, caption: String = "") {
        self.ownerId = ownerId
        self.image = image
        self.caption = caption
    }
}
