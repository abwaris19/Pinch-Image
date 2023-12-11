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
    @State private var imageOffset: CGSize = .zero
    
    func resetImageState(){
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    var body: some View {
     
        NavigationView {
            
            ZStack {
                Color.clear
                
                Image("kabulView")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 12, x: 2, y: 2 )
                    .opacity(isAnimating ? 1 :  0)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale)
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        }
                        else {
                           resetImageState()
                        }
                    })
                    .gesture (
                    DragGesture()
                        .onChanged{ value in
                            withAnimation(.linear(duration: 1)) {
                                imageOffset = value.translation
                            }
                        }
                        .onEnded { _ in
                            if imageScale <= 1 {
                                
                            resetImageState()
                            }
                        }
                    )
                
            } // : ZSTACK
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)) {
                    isAnimating = true
                }
            })
            
            .overlay(
            
            InfoPanelView(scale: imageScale, offset: imageOffset)
                .padding(.horizontal)
                .padding(.top, 30)
            , alignment: .top
            )
            
            // MARK: Controls
            
            .overlay(
            
                Group {
                    HStack {
                       
                        // SCALE DOWN
                        
                        Button {
                            
                            withAnimation(.spring()) {
                                if imageScale > 1 {
                                    imageScale -= 1
                                    if imageScale <= 1 {
                                        resetImageState()
                                    }
                                }
                            }
                            
                        } label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                                .font(.system(size: 36))
                        }
                        
                        // RESET
                        
                        Button {
                            resetImageState()
                        } label: {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                                .font(.system(size: 36))
                        }
                        
                        // SCALE UP
                        
                        Button {
                            
                            withAnimation(.spring()) {
                                if imageScale < 5 {
                                    imageScale += 11
                                    
                                    if imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            }
                            
                            
                        } label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                                .font(.system(size: 36))
                        }
                    
                        
                    } // : CONTROLS
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                }
                
                    .padding(.bottom, 30),
                alignment: .bottom
            )
           
            
        } //: Navigation
        .navigationViewStyle(.stack)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
