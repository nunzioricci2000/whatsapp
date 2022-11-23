//
//  StatusThumbnail.swift
//  WhatsApp
//
//  Created by Nunzio Ricci on 23/11/22.
//

import SwiftUI

private let height: CGFloat = 60

extension StatusView {
    func Thumnail(of user: User) -> some View {
        HStack {
            ZStack {
                StoryCircle(storyNumber: model.statesCount(of: user), viewedStories: model.statesViewedCount(of: user))
                Image(uiImage: model.statusShownInThumnail(of: user)?.image ?? UIImage(named: "yotobi 8")!)
                    .resizable()
                    .matchedGeometryEffect(id: "\(user.name)-image", in: model.animation ?? animation)
                    .scaledToFill()
                    .mask {
                        Circle().matchedGeometryEffect(id: "\(user.name)-circle", in: model.animation ?? animation)
                    }
                    .padding(3.5)
            }.frame(width: height)
            Text(user.name)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .fontWidth(.standard)
                .padding()
            Spacer()
        }
        .frame(width: .infinity, height: 60)
        .onTapGesture {
            withAnimation {
                model.selectStatus(of: user)
                model.overlyingPage = .statusCarusel
            }
        }
    }
}

struct StatusThumbnailView_Previews: PreviewProvider {
    static var view = StatusView().preview
    static var previews: some View {
        view.Thumnail(of: view.model.userList[0])
            .padding()
    }
}
