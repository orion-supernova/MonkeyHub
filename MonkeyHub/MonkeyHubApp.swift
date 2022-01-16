//
//  MonkeyHubApp.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 24.05.2021.
//

import SwiftUI
import Firebase
import FirebaseMessaging
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self

        // APNS Registration
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, _ in
            guard success else { return }
        }
        application.registerForRemoteNotifications()

        return true
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        //
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else { return }
            print("DEBUG: APNS Token: " + token)
        }
    }
}

@main
struct MonkeyHubApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
        }
    }
}
