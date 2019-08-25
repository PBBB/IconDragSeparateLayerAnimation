//
//  ContentView.swift
//  IconDragSeparateLayer
//
//  Created by PBB on 8/24/19.
//  Copyright © 2019 PBB. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    enum DragState {
        case inactive
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
    }
    
    @GestureState var dragState = DragState.inactive
//    @State var viewState = CGSize.zero
    
    var body: some View {
        
        let dragGeture = DragGesture()
            .updating($dragState) { (value, state, transaction) in
                state = .dragging(translation: value.translation)
        }
        .onEnded { value in
//            self.viewState = .zero
        }
        
        var animationDuration: Double {
            switch self.dragState {
            case .inactive:
                return 0.2
            default:
                return 0.02
            }
        }
        
        return ZStack {
            Rectangle()
                .frame(width: 75.0, height: 75.0, alignment: .center)
                .foregroundColor(.yellow)
                .cornerRadius(10, antialiased: true)
                
            Circle()
                .frame(width: 30.0 , height: 30.0, alignment: .center)
                .foregroundColor(.green)
        }
        .fixedSize()
        .frame(alignment: .center)
        .offset(dragState.translation)
        .gesture(dragGeture)
        .animation(.easeInOut(duration: animationDuration))
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
