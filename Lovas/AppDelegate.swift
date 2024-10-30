//
//  AppDelegate.swift
//  Lovas
//
//  Created by Battonyai-Fehér László on 28/06/2024.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure();
        print("✅ - Firebase configured!")
// MARK: Lovardák és Lokációk letöltése és eltárolása
        Task
        {
            // lovardák
            do
            {
                let lovardak = try await Lovarda.Download()
                DataStorage.shared.setLovardaStrorage(lovardak: lovardak)
                print("✅ - Downloading Lovardák")
            } catch
            {
                print("❌ - Downloading Lovardák")
            }
            
            // lokációk
            do
            {
                let locations = try await Location.Download()
                DataStorage.shared.setLocationStorage(locations: locations)
                print("✅ - Downloading Locations")
            } catch {
                print("❌ - Downloading Locations")
            }
            
            // értesítés küldés a letötlések befejezéséről
            NotificationCenter.default.post(name: .locationsDownloaded, object: nil)
        }
        
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

extension Notification.Name
{
    static let locationsDownloaded = Notification.Name("locationsDownloaded")
    static let lovardaSelected = Notification.Name("lovardaSelected")
}

