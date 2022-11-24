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
                ThumbnailImage(of: user)
            }.frame(width: height)
            VStack (alignment: .leading) {
                Text(user.name)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .fontWidth(.standard)
                Text(model.statusList(of: user).last?.formattedTimeElapsed ?? "")
                    .foregroundColor(.gray)
            }
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
    
    func ThumbnailImage(of user: User) -> some View {
        Group {
            //if !model.inCarusel(user) {
                Image(uiImage: model.statusShownInThumnail(of: user)?.image ?? UIImage(named: "yotobi 8")!)
                    .resizable()
                    .matchedGeometryEffect(id: "\(user.name)-image", in: model.animation ?? animation)
                    .scaledToFill()
            //}
        }.mask {
            //if !model.inCarusel(user) {
                Circle().matchedGeometryEffect(id: "\(user.name)-circle", in: model.animation ?? animation)
            //}
        }
        .padding(3.5)
    }
}

struct StatusThumbnailView_Previews: PreviewProvider {
    static var view = StatusView().preview
    static var previews: some View {
        view.Thumnail(of: view.model.userList[0])
            .padding()
    }
}
