//
//  WAView.swift
//  WhatsApp
//
//  Created by Nunzio Ricci on 23/11/22.
//

import SwiftUI

protocol WAView: View {
    var model: Model { get }
}

extension WAView {
    var preview: Self {
        _ = model.isPreview
        return self
    }
}
