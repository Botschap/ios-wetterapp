//
//  AppDelegate.swift
//  ios-wetterapp
//
//  Created by admin on 04.01.24.
//

import UIKit
import BackgroundTasks
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 13, *) {
            registerBackgroundTask()
        }
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                NSLog("Authorization for usernotifications granted!")
            } else {
                NSLog("Authorization for usernotifications not granted!")
            }
        }
        
        return true
    }
    
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
        
        // Set the interval for how often the task should be performed (in seconds)
        request.earliestBeginDate = Date(timeIntervalSinceNow: 60 * 30) // 30 min seconds, but would be higher normally
        
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
            let pirateWeater = try! OpenWeather.getInstance()
            pirateWeater.fetchWeatherData(location) { weatherData in
                NSLog("new weatherdata in backgroundtask!")
                
                if let weather = weatherData?.list[1] {
                    if weather.rain != nil || weather.snow != nil || weather.wind.speed > 15 || weather.clouds.all >= 40 {
                        self.sendUserNotification(weather.weather[0].description)
                    }

                }
                
                NSLog("task completed successfully!")
                task.setTaskCompleted(success: true)
                self.scheduleRefreshBackgroundTask()
            }
        }
    }
    
    func sendUserNotification(_ message: String){
        let content = UNMutableNotificationContent()
        content.title = "Warnung"
        content.body = message
        content.sound = UNNotificationSound.default

        // Create a trigger for the notification
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // Create a request for the notification
        let request = UNNotificationRequest(identifier: "weatherWarning", content: content, trigger: trigger)

        // Add the request to the notification center
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                NSLog("Error scheduling notification: \(error.localizedDescription)")
            }
        }

    }
    
}

