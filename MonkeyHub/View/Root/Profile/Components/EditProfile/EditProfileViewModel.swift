//
//  EditProfileViewModel.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 29.05.2021.
//

import SwiftUI

class EditProfileViewModel: ObservableObject {

    private let user: User

    init(user: User) {
        self.user = user
    }

    func saveUserData() {
        print("saved data")
    }

}
