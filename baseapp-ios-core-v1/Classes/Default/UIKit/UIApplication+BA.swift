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

public extension UIApplication {
	static var sharedSafe: UIApplication? {
		let sharedSelector = NSSelectorFromString("shared")
		guard UIApplication.responds(to: sharedSelector) else { return nil }
		let shared = UIApplication.perform(sharedSelector)
		let application = shared?.takeUnretainedValue() as? UIApplication
		return application
	}
    
	@available(iOS 10.0, *)
	func authorizeUserNotifications(options: UNAuthorizationOptions) -> Promise<UNNotificationSettings> {
        let nc = UNUserNotificationCenter.current()
        let (promise, resolver) = Promise<UNNotificationSettings>.pending()
        
        nc.getNotificationSettings(completionHandler: {
            switch $0.authorizationStatus {
            case .notDetermined:
                nc.requestAuthorization(options: options) { _, error in
                    if let error = error {
                        resolver.reject(error)
                    } else {
                        nc.getNotificationSettings(completionHandler: {
                            resolver.fulfill($0)
                        })
                    }
                }
            default:
                resolver.fulfill($0)
            }
        })
        
        return promise
	}
}
