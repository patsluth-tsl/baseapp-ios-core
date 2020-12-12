//
//  UIApplication+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2018-10-27.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import PromiseKit
import UIKit
import UserNotifications

#if os(iOS)

public extension UIApplication {
    static var sharedSafe: UIApplication? {
        let sharedSelector = NSSelectorFromString("shared")
        guard UIApplication.responds(to: sharedSelector) else { return nil }
        let shared = UIApplication.perform(sharedSelector)
        let application = shared?.takeUnretainedValue() as? UIApplication
        return application
    }
    
    @available(iOS 10.0, *)
    func userNotificationsSettings() -> Guarantee<UNNotificationSettings> {
        let nc = UNUserNotificationCenter.current()
        
        return Guarantee<UNNotificationSettings>(resolver: { resolver in
            nc.getNotificationSettings(completionHandler: { settings in
                resolver(settings)
            })
        })
    }
    
    @available(iOS 10.0, *)
    func userNotificationsAuthorizationStatus() -> Guarantee<UNAuthorizationStatus> {
        return userNotificationsSettings()
            .map({ settings in
                settings.authorizationStatus
            })
    }
    
    @available(iOS 10.0, *)
    func authorizeUserNotifications(options: UNAuthorizationOptions) -> Promise<UNNotificationSettings> {
        let nc = UNUserNotificationCenter.current()
        
        return userNotificationsSettings()
            .then({ settings in
                Promise<UNNotificationSettings>(resolver: { resolver in
                    switch settings.authorizationStatus {
                    case .notDetermined:
                        nc.requestAuthorization(options: options) { _, error in
                            if let error = error {
                                resolver.reject(error)
                            } else {
                                self.userNotificationsSettings()
                                    .done({ settings in
                                        resolver.fulfill(settings)
                                    })
                            }
                        }
                    default:
                        resolver.fulfill(settings)
                    }
                })
            })
    }
}

#endif
