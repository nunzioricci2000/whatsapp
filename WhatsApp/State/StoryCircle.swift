//
//  StoryCircle.swift
//  Socialize
//
//  Created by Nunzio Ricci on 15/11/22.
//

import SwiftUI

struct StoryArc: Shape {
    var size: Angle
    var startPoint: Angle
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let center = CGPoint (
            x: rect.midX,
            y: rect.midY
        )
        let radius = min(
            center.x,
            center.y
        )
        
        p.addArc(center: center, radius: radius, startAngle: startPoint, endAngle: startPoint + size, clockwise: false)
        
        return p.strokedPath(.init(lineWidth: 3, lineCap: .round))
    }
}

extension StatusView {
    fileprivate func Arc(_ index: Int, storyNumber: Int, viewedStories: Int, arcGap: Double = 10.0) -> some View {
        let sector = 360.0 / Double(storyNumber)
        let size = sector - arcGap
        
        return StoryArc(size: Angle.degrees(size), startPoint: Angle.degrees(sector * Double(index) - 90.0 + arcGap/2.0))
            .foregroundColor(index >= viewedStories ? .accentColor : .secondary)
    }
    
    fileprivate func StoryArcs(storyNumber: Int, viewedStories: Int) -> some View {
        let arcGap: Double = 10.0
        
        return ZStack {
            ForEach((0..<storyNumber), id: \.self) { i in
                Arc(i, storyNumber: storyNumber, viewedStories: viewedStories, arcGap: arcGap)
            }
        }
        
    }
    
    fileprivate func SingleStoryCircle(viewed: Bool) -> some View {
        Circle()
            .stroke(viewed ? .secondary : Color.accentColor, style: .init(lineWidth: 3))
        
    }
    
    func StoryCircle(storyNumber: Int, viewedStories: Int) -> some View {
        if storyNumber > 1 {
            return AnyView(StoryArcs(storyNumber: storyNumber, viewedStories: viewedStories))
        }
        return AnyView(SingleStoryCircle(viewed: viewedStories > 0))
    }
}

struct StoryCircle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StatusView().preview
                .StoryCircle(storyNumber: 1, viewedStories: 0)
                .frame(width: 65, height: 65)
            StatusView().preview
                .StoryCircle(storyNumber: 5, viewedStories: 2)
                .frame(width: 65, height: 65)
        }
    }
}
