//
//  TitleRow.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 21.01.2022.
//

import SwiftUI

struct TitleRow: View {
    var monkeyURL = URL(string: "https://images.unsplash.com/photo-1581828060707-37894f1ed9b8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2340&q=80")
    var name = "Hebele Hübele"

    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: monkeyURL) { _ in
                Image("barbara")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(50)
            } placeholder: {
                ProgressView()
            }

            VStack(alignment: .leading) {
                Text(name)
                    .font(.title.bold())
                Text("Online")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Image(systemName: "phone.fill")
                .foregroundColor(Color("White-Black"))
                .padding(10)
                .background(Color("Black-White"))
                .cornerRadius(50)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.ultraThickMaterial)
    }
}

struct TitleRow_Previews: PreviewProvider {
    static var previews: some View {
        TitleRow()

    }
}
