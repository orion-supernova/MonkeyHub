//
//  Extensions.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 24.05.2021.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
