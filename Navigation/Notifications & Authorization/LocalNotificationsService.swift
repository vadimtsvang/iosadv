//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Vadim on 07.10.2022.
//

import Foundation
import UserNotifications

final class LocalNotificationsService: NSObject {
    
    static var shared = LocalNotificationsService()
    
    private let center = UNUserNotificationCenter.current()
    
    private override init() {
        super.init()
        center.delegate = self
    }
    
    func registeForLatestUpdatesIfPossible() {
        
        center.requestAuthorization(options: [.sound, .badge, .provisional]) { granted, error in
            
            guard granted else { return }
            
            self.registerUpdatesCategory()
            
            if let error = error as? NSError {
                print("🔔 Accessing the Notification center error: \(error.localizedDescription)")
                return
            }
        }
    }
    
    func registerUpdatesCategory() {
        
        let actionFeed = UNNotificationAction(
            identifier: "notification.button.feed",
            title: "show.feed".localized,
            options: .foreground
            
        )
        let actionMusic = UNNotificationAction(
            identifier: "notification.button.music",
            title: "show.music".localized,
            options: .foreground
        )
        
        let category = UNNotificationCategory(
            identifier: "notifications.categories",
            actions: [actionFeed, actionMusic],
            intentIdentifiers: []
        )
        
        center.setNotificationCategories([category])
    }
    
    func sendNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "notification.late.title".localized
        content.body = "notification.late.body".localized
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "notifications.categories"
        
        let date = DateComponents(hour: 19)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7, repeats: false) // оставил для проверяющего :)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        center.add(request) { error in
            if let error = error as? NSError {
                print ("🔔 sending notification error: \(error.localizedDescription)")
            }
        }
    }
}

extension LocalNotificationsService: UNUserNotificationCenterDelegate {
    
    // Чтобы уведомление появлялось когда приложение в Foreground
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            
        completionHandler([.sound, .banner])
    }
    
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
        case "notification.button.feed" :
            NotificationCenter.default.post(name: NSNotification.Name.showFeed, object: nil)
            
        case "notification.button.music" :
            NotificationCenter.default.post(name: NSNotification.Name.showMusic, object: nil)
            
        default:
            break
        }
        
        completionHandler()
    }
}

