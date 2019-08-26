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
    
    var body: some View {
        
        let dragGeture = DragGesture()
            .updating($dragState) { (value, state, transaction) in
                state = .dragging(translation: value.translation)
        }
        
        var animationDuration: Double {
            switch self.dragState {
            case .inactive:
                return 0.2
            default:
                return 0.02
            }
        }
        
        var iconForegroundAnimation: Animation {
            switch self.dragState {
            case .inactive:
                return Animation.easeInOut(duration: animationDuration)
            default:
                return Animation.interpolatingSpring(stiffness: 4000, damping: 50)
            }
        }
        
        return ZStack {
            Circle()
                .frame(width: 75.0, height: 75.0, alignment: .center)
                .foregroundColor(.yellow)
//                .cornerRadius(10, antialiased: true)
                .animation(.easeInOut(duration: animationDuration))
            Rectangle()
                .frame(width: 30.0, height: 30.0, alignment: .center)
                .foregroundColor(.green)
                .cornerRadius(4, antialiased: true)
                .animation(iconForegroundAnimation)
        }
        .fixedSize()
        .frame(alignment: .center)
        .offset(dragState.translation)
        .gesture(dragGeture)
        
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
