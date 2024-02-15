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
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "ios-wetterapp.fetchWeather", using: nil) {task in
            self.handleRefreshTask(task as! BGAppRefreshTask)
        }
        NSLog("Backgroundtask registriert!")
    }
    
    @available(iOS 13.0, *)
    func scheduleRefreshBackgroundTask() {
        let backgroundTaskIdentifier = "ios-wetterapp.fetchWeather"
        
        // Create a request for the background task
        let request = BGAppRefreshTaskRequest(identifier: backgroundTaskIdentifier)
        //request.requiresNetworkConnectivity = true // Set to true if network connectivity is required
        //request.requiresExternalPower = false // Set to true if external power is required
        
        // Set the interval for how often the task should be performed (in seconds)
        request.earliestBeginDate = Date(timeIntervalSinceNow: 60) // 1 min seconds
        
        do {
            // Schedule the background task
            try BGTaskScheduler.shared.submit(request)
            NSLog("scheduled background task!")
        } catch {
            print("Error scheduling background task: \(error)")
        }
    }
    
    func handleRefreshTask(_ task: BGAppRefreshTask) {
        task.expirationHandler = {
            NSLog("The Task expired!")
            task.setTaskCompleted(success: false)
        }
        
        NSLog("completing task")
        
        if let location = LocationManager.getInstance().last {
            let pirateWeater = try! PirateWeather.getInstance()
            pirateWeater.fetchWeatherData(location) { weatherData in
                NSLog("Neues Wettermodel im backgroundtask: \(String(describing: weatherData))")
                NSLog("Task completed successfully.")
                task.setTaskCompleted(success: true)
                self.scheduleRefreshBackgroundTask()
            }
        }
    
        
        
        
    }
    
}

