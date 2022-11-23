//
//  Status.swift
//  WhatsApp
//
//  Created by Nunzio Ricci on 23/11/22.
//

import SwiftUI

class Status: ObservableObject {
    var id: UUID = UUID()
    var ownerId: UUID
    var image: UIImage
    var caption: String = ""
    var datestamp: Date = Date()
    var viewed: Bool = false
    
    init(ownerId: UUID, image: UIImage, caption: String = "") {
        self.ownerId = ownerId
        self.image = image
        self.caption = caption
    }
}
