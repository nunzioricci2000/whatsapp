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
            let diameter = sqrt(rect.size.width*rect.size.width+rect.size.height*rect.size.height)
            ZStack {
                Color.black
                Image(uiImage: model.currentStatusInCarusel.image)
                    .resizable()
                    .matchedGeometryEffect(id: "\(model.currentUserInCarusel.name)-image", in: model.animation ?? animation)
                    .scaledToFit()
                
                Text(model.currentStatusInCarusel.caption)
                    .foregroundColor(.white)
                    .frame(width: rect.size.width)
                    .background(.black.opacity(0.3))
                    .offset(y: rect.size.height / 3)
                Button {
                    withAnimation {
                        model.overlyingPage = nil
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .position(x: 40, y: 80)
                }
            }
            .mask {
                Circle()
                    .matchedGeometryEffect(id: "\(model.currentUserInCarusel.name)-circle", in: model.animation ?? animation)
                    .frame(width: diameter, height: diameter)
            }
        }.ignoresSafeArea()
    }
}

struct StatusCaruselView_Previews: PreviewProvider {
    static var previews: some View {
        StatusCaruselView().preview
    }
}
