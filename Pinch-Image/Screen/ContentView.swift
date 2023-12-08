//
//  ContentView.swift
//  Pinch-Image
//
//  Created by Khan on 04.12.23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isAnimating: Bool = false
    @State private var imageScale : CGFloat = 1
    var body: some View {
     
        NavigationView {
            
            ZStack {
                
                Image("magazine-front-cover")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 12, x: 2, y: 2 )
                    .opacity(isAnimating ? 1 :  0)
                    .scaleEffect(imageScale)
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        }
                        else {
                            withAnimation(.spring()) {
                                imageScale = 1
                            }
                        }
                    })
                    .padding()
                
            } // : ZSTACK
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)) {
                    isAnimating = true
                }
            })
        } //: Navigation
        .navigationViewStyle(.stack)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
