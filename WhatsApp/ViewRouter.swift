//
//  ViewRouter.swift
//  WhatsApp
//
//  Created by Nunzio Ricci on 23/11/22.
//

import SwiftUI

struct ViewRouter: WAView {
    @StateObject var model: Model = .init()
    @Namespace var animation
    
    var body: some View {
        ZStack {
            Group {
                if model.overlyingPage == nil {
                    TabView(selection: $model.currentTab) {
                        StatusView(model: model)
                            .tag(Tab.status)
                            .tabItem {
                                Label("States", systemImage: "circle.dashed")
                            }
                    }
                }
            }.zIndex(0)
            Group {
                switch model.overlyingPage {
                case .statusCarusel:
                    StatusCaruselView(model: model)
                case nil:
                    EmptyView()
                }
            }.zIndex(1)
        }
        .onAppear {
            model.animation = animation
            _ = model.isPreview
        }
    }
}

struct ViewRouter_Previews: PreviewProvider {
    static var previews: some View {
        ViewRouter().preview
    }
}
