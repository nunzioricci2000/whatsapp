//
//  StoryCarouselProgressBar.swift
//  Socialize
//
//  Created by Nunzio Ricci on 19/11/22.
//

import SwiftUI

extension StatusCaruselView {
    func ProgressBar() -> some View {
        HStack {
            ForEach(model.statusList(of: model.currentUserInCarusel), id: \.id) { status in
                Group {
                    if status == model.currentStatusInCarusel {
                        ProgressBarSegment(progress: model.caruselProgress / model.stateDuration)
                    } else if model.index(of: status, by: model.currentUserInCarusel) ?? -1 < model.index(of: model.currentStatusInCarusel, by: model.currentUserInCarusel) ?? 10000 {
                        ProgressBarSegment(progress: 1)
                    } else {
                        ProgressBarSegment(progress: 0)
                    }
                }
            }
        }.frame(height: 5)
    }
    
    fileprivate func ProgressBarSegment(progress: Double) -> some View {
        GeometryReader { rect in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.white.opacity(0.2))
                Rectangle()
                    .fill(.white)
                    .frame(width: rect.size.width * progress)
            }
        }
    }
}

struct StatusCaruselProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            StatusCaruselView().preview.ProgressBar()
        }
    }
}
