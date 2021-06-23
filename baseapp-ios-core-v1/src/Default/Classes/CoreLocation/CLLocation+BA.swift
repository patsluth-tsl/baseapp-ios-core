//
//  CLLocation+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2018-01-30.
//  Copyright © 2018 SilverLogic. All rights reserved.
//

import CoreLocation
import Foundation

public extension CLLocation {
    func bearing(to coordinate: CLLocationCoordinate2D) -> CLLocationDegrees {
        return coordinate.bearing(to: coordinate)
    }

    func bearing<T>(to coordinate: CLLocationCoordinate2D) -> T
        where T: FloatingPointType {
        return coordinate.bearing(to: coordinate)
    }

    func bearing(to location: CLLocation) -> CLLocationDegrees {
        return coordinate.bearing(to: location.coordinate)
    }

    func bearing<T>(to location: CLLocation) -> T
        where T: FloatingPointType {
        return coordinate.bearing(to: location.coordinate)
    }
}
