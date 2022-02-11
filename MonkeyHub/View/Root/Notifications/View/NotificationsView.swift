//
//  NotificationsView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 24.05.2021.
//

import SwiftUI

struct NotificationsView: View {
    @ObservedObject var viewmodel = NotificationsViewModel()

    var body: some View {

        if viewmodel.notifications.count == 0 {
            VStack {
                Text("You haven't received any notifications yet")
                    .foregroundColor(.secondary)
            }
        } else {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(viewmodel.notifications) { notification in
                        LazyView(NotificationCell(viewmodel: NotificationCellViewModel(notification: notification)))
                            .padding(.top)
                    }
                }
            }
        }

    }
}

// struct NotificationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationsView()
//    }
// }
