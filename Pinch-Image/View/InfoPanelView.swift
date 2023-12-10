//
//  InfoPanelView.swift
//  Pinch-Image
//
//  Created by Khan on 10.12.23.
//

import SwiftUI

struct InfoPanelView: View {
    var body: some View {
        
        HStack {
            
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30, height: 30)
            
            Spacer()
        }
    }
}

struct InfoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelView()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
