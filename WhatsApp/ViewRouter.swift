//
//  ViewRouter.swift
//  WhatsApp
//
//  Created by Nunzio Ricci on 23/11/22.
//

import SwiftUI

struct ViewRouter: WAView {
    @StateObject var model: Model = .init()
    
    var body: some View {
        ZStack {
            TabView(selection: $model.currentTab) {
                StatusView(model: model)
                    .tag(Tab.status)
                    .tabItem {
                        Label("States", systemImage: "circle.dashed")
                    }
            }
            switch model.overlyingPage {
            case .statusCarusel:
                StatusCaruselView()
            case nil:
                EmptyView()
            }
        }
    }
}

struct ViewRouter_Previews: PreviewProvider {
    static var previews: some View {
        ViewRouter().preview
    }
}
