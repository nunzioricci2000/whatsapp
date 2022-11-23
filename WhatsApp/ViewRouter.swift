//
//  ViewRouter.swift
//  WhatsApp
//
//  Created by Nunzio Ricci on 23/11/22.
//

import SwiftUI

struct ViewRouter: View {
    @StateObject var model = Model()
    
    var body: some View {
        ZStack {
            TabView(selection: $model.currentTab) {
                StateView()
                    .tag(Tab.state)
                    .tabItem {
                        Label("States", systemImage: "circle.dashed")
                    }
            }
            switch model.overlyingPage {
            case .stateCarusel:
                StateView()
            case nil:
                EmptyView()
            }
        }.environmentObject(model)
    }
}

struct ViewRouter_Previews: PreviewProvider {
    static var previews: some View {
        ViewRouter()
    }
}
