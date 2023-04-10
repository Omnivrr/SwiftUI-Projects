//
//  CustomDivider.swift
//  Moonshot
//
//  Created by Bukhari Sani on 29/03/2023.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
           Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)

    }
}

struct CustomDivider_Previews: PreviewProvider {
    static var previews: some View {
        CustomDivider()
    }
}
