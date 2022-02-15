//
//  LoaderView2.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 28.05.2021.
//

import SwiftUI

struct LoaderView2: View {

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
                .opacity(0.25)

            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .pink))
                .scaleEffect(3)
        }
        .zIndex(5)

    }

}

struct LoaderView2_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView2()
    }
}
