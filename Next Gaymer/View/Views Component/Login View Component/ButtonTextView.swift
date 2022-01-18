//
//  LogButtonView.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 13/01/2022.
//

import SwiftUI

struct ButtonTextView: View {
    
    @Binding var status: RequestStatus
    
    var text: String
    
    var body: some View {
        if status == .processing {
            ProgressView()
                .frame(width: 150, height: 60, alignment: .center)
        } else {
        Text(text)
            .foregroundColor(.white)
            .frame(width: 177, height: 55, alignment: .center)
            .background(.blue)
            .cornerRadius(10)
        }
    }
}

struct ButtonTextView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTextView(status: .constant(RequestStatus.initial), text: "Test").previewLayout(.sizeThatFits)
    }
}
