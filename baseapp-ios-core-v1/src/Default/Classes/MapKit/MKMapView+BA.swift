//
//  MKMapView+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-19.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import Foundation
import MapKit
import ObjectiveC

@available(iOS 11.0, *)
public extension MKMapView {
    func register<T>(_ type: T.Type,
                     reuseIdentifier: String = "\(T.self)")
        where T: MKAnnotationView {
            register(type, forAnnotationViewWithReuseIdentifier: reuseIdentifier)
    }
    
    @available(iOS 11.0, *)
    func dequeue<T>(_ type: T.Type,
                    reuseIdentifier: String = "\(T.self)") -> T?
        where T: MKAnnotationView {
            return dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? T
    }
    
    @available(iOS 11.0, *)
    func dequeue<T>(_ type: T.Type,
                    for annotation: MKAnnotation,
                    reuseIdentifier: String = "\(T.self)") -> T
        where T: MKAnnotationView {
            // swiftlint:disable:next force_cast
            return dequeueReusableAnnotationView(withIdentifier: reuseIdentifier, for: annotation) as! T
    }
}
