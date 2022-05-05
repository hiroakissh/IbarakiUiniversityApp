//
//  AppDelegate.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2021/10/01.
//

import UIKit
import UserNotifications
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var documentCount: Int = 0
    var todoCount: Int = 0

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            if granted {
                UNUserNotificationCenter.current().delegate = self
            } else {
                print("Not autorization")
            }
        }

        // マイグレーションの処理
        var config = Realm.Configuration()
        config.migrationBlock = { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                migration.enumerateObjects(ofType: RealmDocumentModel.className()) { oldObject, newObject in
                    oldObject!["uuidString"]
                    newObject!["todoUUID"]
                }
            }
        }
        config.schemaVersion = 1
        Realm.Configuration.defaultConfiguration = config
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
 
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.badge, .sound, .alert])
    }
}
