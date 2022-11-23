//
//  StatusCaruselView.swift
//  WhatsApp
//
//  Created by Nunzio Ricci on 23/11/22.
//

import SwiftUI

struct StatusCaruselView: WAView {
    @ObservedObject var model: Model = .init()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct StatusCaruselView_Previews: PreviewProvider {
    static var previews: some View {
        StatusCaruselView().preview
    }
}
