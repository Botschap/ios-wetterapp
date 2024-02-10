//
//  AppDelegate.swift
//  ios-wetterapp
//
//  Created by admin on 04.01.24.
//

import UIKit
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 13, *) {
            registerBackgroundTask()
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

    
    func applicationDidEnterBackground(_ application: UIApplication) {
        NSLog("App did enter background")
        if #available(iOS 13, *) {
            //self.scheduleFetchBackgroundTask()
        }
    }
    
    @available(iOS 13.0, *)
    func registerBackgroundTask(){
        NSLog("Backgroundtask registrieren")
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.foo.ios-wetterapp.scheduel.FetchWeather", using: nil, launchHandler: {task in
            NSLog("Startet Backgorund Task")
            // fetchData
            
            task.setTaskCompleted(success: true)
            //self.scheduleFetchBackgroundTask()
        })
    }
    
    

}

