//
//  StatusCaruselView.swift
//  WhatsApp
//
//  Created by Nunzio Ricci on 23/11/22.
//

import SwiftUI

struct StatusCaruselView: WAView {
    @ObservedObject var model: Model = .init()
    @Namespace var animation
    var body: some View {
        GeometryReader { rect in
            let diameter = sqrt(rect.size.width*rect.size.width+rect.size.height*rect.size.height) + 100
            ZStack {
                Color.black.ignoresSafeArea()
                Image(uiImage: model.currentStatusInCarusel.image)
                    .resizable()
                    .matchedGeometryEffect(id: "\(model.currentUserInCarusel.name)-image", in: model.animation ?? animation)
                    .scaledToFit()
                
                Text(model.currentStatusInCarusel.caption)
                    .foregroundColor(.white)
                    .frame(width: rect.size.width)
                    .background(.black.opacity(0.3))
                    .offset(y: rect.size.height / 3)
                HStack {
                    Button {
                        model.previousStatus()
                    } label: {
                        Color.black.opacity(0)
                            .frame(width: rect.size.width/3, height: rect.size.height)
                    }
                    Spacer()
                }
                VStack {
                    ProgressBar()
                    HStack {
                        Button {
                            withAnimation {
                                model.overlyingPage = nil
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                        }.padding()
                        VStack(alignment: .leading) {
                            Text(model.currentUserInCarusel.name)
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Text(model.currentStatusInCarusel.formattedTimeElapsed)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
            .mask {
                Circle()
                    .matchedGeometryEffect(id: "\(model.currentUserInCarusel.name)-circle", in: model.animation ?? animation)
                    .frame(width: diameter, height: diameter)
            }
            .onTapGesture {
                model.nextStatus()
            }
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ _ in
                    model.isPaused = true
                })
                .onEnded({ _ in
                    model.isPaused = false
                })
        )
        .onAppear {
            model.startStory()
        }
    }
}

struct StatusCaruselView_Previews: PreviewProvider {
    static var previews: some View {
        StatusCaruselView().preview
    }
}
