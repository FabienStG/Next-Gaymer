//
//  CircleBackgroundView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 17/01/2022.
//

import SwiftUI

struct CircleBackgroundView: View {

  @Binding var startAnimation: Bool
  @Binding var bottomEdge: CGFloat

  var body: some View {
    ZStack {

      let animationOffset: CGFloat = (startAnimation ? (startAnimation ? 15 : 18) : (bottomEdge == 0 ? 26 : 27))
      let offset: CGSize = bottomEdge == 0 ?
      CGSize(width: animationOffset, height: 31) :
      CGSize(width: animationOffset, height: 36)
      Rectangle()
        .fill(Color("Purple"))
        .frame(width: 45, height: 45)
        .offset(y: 40)
      Circle()
        .fill(.white)
        .frame(width: 45, height: 45)
        .scaleEffect(bottomEdge == 0 ? 0.8 : 1)
        .offset(x: offset.width, y: offset.height)
      Circle()
        .fill(.white)
        .frame(width: 45, height: 45)
        .scaleEffect(bottomEdge == 0 ? 0.8 : 1)
        .offset(x: -offset.width, y: offset.height)
    }
  }
}
