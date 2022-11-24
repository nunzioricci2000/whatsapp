//
//  StatusView.swift
//  WhatsApp
//
//  Created by Nunzio Ricci on 23/11/22.
//

import SwiftUI

struct StatusView: WAView {
    @ObservedObject var model: Model = .init()
    @Namespace var animation
    
    var body: some View {
        NavigationStack {
            List {
                if let myAccount = model.myAccount, model.statusSerchText == "" {
                    Section {
                        Thumnail(of: myAccount)
                    }
                }
                if model.showRecentUpdates {
                    Section("Recent updates") {
                        ForEach (model.userList, id: \.id) { user in
                            if model.showInRecentUpdates(user), model.searchingFor(user: user) {
                                Thumnail(of: user)
                            }
                        }
                    }
                }
                if model.showViewedUpdates {
                    Section("Viewed updates") {
                        ForEach (model.userList, id: \.id) { user in
                            if model.showInViewedUpdates(user), model.searchingFor(user: user) {
                                Thumnail(of: user)
                            }
                        }
                    }
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Status")
            .searchable(text: $model.statusSerchText)
            .toolbar {
                Button("New Status") {
                    
                }
            }
        }
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StatusView().preview
        }
    }
}
