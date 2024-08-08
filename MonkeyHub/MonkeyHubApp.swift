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
import FirebaseAuth

enum Identifiers {
    static let viewAction = "VIEW_IDENTIFIER"
    static let messageCategory = "MESSAGE_CATEGORY"
}

class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self

        configureTabBarAppearance()
        registerForPushNotifications()
        AppGlobal.shared.fcmToken = Messaging.messaging().fcmToken

        // Check if launched from notification
        let notificationOption = launchOptions?[.remoteNotification]
        if  let notification = notificationOption as? [String: AnyObject], let aps = notification["aps"] as? [String: AnyObject] {
            //
        }
        return true
    }

    // MARK: - Apple Push Notifications Service
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, _ in
            print("Permission granted: \(granted)")
            guard granted else { return }

            let viewAction = UNNotificationAction(
                identifier: Identifiers.viewAction,
                title: "Açalım bakalım",
                options: [.foreground])

            let newsCategory = UNNotificationCategory(
                identifier: Identifiers.messageCategory,
                actions: [viewAction],
                intentIdentifiers: [],
                options: [])

            UNUserNotificationCenter.current().setNotificationCategories([newsCategory])

            self?.getNotificationSettings()
        }
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        guard let aps = userInfo["aps"] as? [String: AnyObject] else {
            completionHandler(.failed)
            return
        }
        //
    }

    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else { return }
            print("DEBUG: APNS Token: " + token)
        }
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        guard let apnsDict = notification.request.content.userInfo as? [String: Any] else { return [.badge] }
        if apnsDict["user"] as? String != Auth.auth().currentUser?.uid {
            return [.alert, .badge, .sound]
        } else {
            return [.badge]
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        let userInfo = response.notification.request.content.userInfo

        if let aps = userInfo["aps"] as? [String: AnyObject] {
            //            (window?.rootViewController as? UITabBarController)?.selectedIndex = 1

            if response.actionIdentifier == Identifiers.viewAction,
               let url = URL(string: aps["link_url"] as? String ?? "") {
//                let safari = SFSafariViewController(url: url)
//                window?.rootViewController?.present(safari, animated: true, completion: nil)
            }
        }

        completionHandler()
    }

    private func configureTabBarAppearance() {
        // MARK: - UINavigationBar default translucent issue after iOS 15 and XCode 13
        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithDefaultBackground()
            UINavigationBar.appearance().standardAppearance   = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance    = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
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
