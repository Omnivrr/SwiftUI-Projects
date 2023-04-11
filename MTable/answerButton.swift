//
//  answerButton.swift
//  MTable
//
//  Created by Bukhari Sani on 21/03/2023.
//

import SwiftUI

struct answerButton: View {
    var number : Int
    var body: some View {
        Text("\(number)")
            .frame(width: 120, height: 90)
            .font(.system(size: 40, weight: .bold))
            .background(Color.blue)
            .shadow(radius: 0.5)
            .foregroundColor(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .padding()
    
    }
}

struct answerButton_Previews: PreviewProvider {
    static var previews: some View {
        answerButton(number: 50)
    }
}
