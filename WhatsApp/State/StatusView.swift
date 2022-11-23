//
//  StatusView.swift
//  WhatsApp
//
//  Created by Nunzio Ricci on 23/11/22.
//

import SwiftUI

struct StatusView: WAView {
    @ObservedObject var model: Model = .init()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("prova")
                        .onTapGesture {
                            model.overlyingPage = .statusCarusel
                        }
                }
                Section("Recent updates") {
                    ForEach (model.userList, id: \.id) { user in
                        Text(user.name)
                    }
                }
                Section("Viewed updates") {
                    
                }
            }.navigationTitle("Status")
                .searchable(text: $model.statusSerchText)
        }
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView().preview
    }
}
