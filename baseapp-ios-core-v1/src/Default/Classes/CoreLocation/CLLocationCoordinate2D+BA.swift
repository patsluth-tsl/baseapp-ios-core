//
//  CLLocationCoordinate2D+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2018-01-30.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import CoreLocation
import Foundation

public extension CLLocationCoordinate2D {
	func bearing(to coordinate: CLLocationCoordinate2D) -> CLLocationDegrees {
		let x = sin(coordinate.longitude.toRad - longitude.toRad) * cos(coordinate.latitude.toRad)
		let y = cos(latitude.toRad) *
            sin(coordinate.latitude.toRad) -
            sin(latitude.toRad) *
            cos(coordinate.latitude.toRad) *
            cos(coordinate.longitude.toRad - longitude.toRad)
        let bearing = atan2(x, y)
//        return bearing.toDeg
        return bearing.wrapped(max: .tau).toDeg
	}

    func bearing<T>(to coordinate: CLLocationCoordinate2D) -> T
        where T: FloatingPointType {
        return T(bearing(to: coordinate))
    }

    func bearing(to location: CLLocation) -> CLLocationDegrees {
        return bearing(to: location.coordinate)
    }

    func bearing<T>(to location: CLLocation) -> T
        where T: FloatingPointType {
        return bearing(to: location.coordinate)
    }

    func distance(from coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
//        let lat1 = latitude.toRad
//        let lat2 = coordinate.latitude.toRad
//        let Δlon = (coordinate.longitude - longitude).toRad
//
//        return acos(sin(lat1) * sin(lat2) + cos(lat1) * cos(lat2) * cos(Δlon)) * .earth_m

        // Testing above, should be more accurate
        let lat1 = latitude.toRad
        let lat2 = coordinate.latitude.toRad
        let Δlat = (coordinate.latitude - latitude).toRad
        let Δlong = (coordinate.longitude - longitude).toRad
        let a = sin(Δlat / 2) * sin(Δlat / 2) + cos(lat1) * cos(lat2) * sin(Δlong / 2) * sin(Δlong / 2)
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))
        let km = .earth_km * c
        return km * 1000
    }

    func distance<T>(from coordinate: CLLocationCoordinate2D) -> T
        where T: FloatingPointType {
        return T(distance(from: coordinate))
    }

    func distance(from location: CLLocation) -> CLLocationDistance {
        return distance(from: location.coordinate)
    }

    func distance<T>(from location: CLLocation) -> T
        where T: FloatingPointType {
        return distance(from: location.coordinate)
    }

    init(distance d: CLLocationDistance,
         bearing b: CLLocationDegrees,
         from coordinate: CLLocationCoordinate2D) {
        guard !d.isEqual(to: 0.0) else {
            self = coordinate
            return
        }
        
        let lat1 = coordinate.latitude.toRad
        let lon1 = coordinate.longitude.toRad
        let lat2 = asin(
            sin(lat1) * cos(d / .earth_m) + cos(lat1) * sin(d / .earth_m) * cos(b.toRad)
        )
        let lon2 = lon1 + atan2(
            sin(b.toRad) * sin(d / .earth_m) * cos(lat1),
            cos(d / .earth_m) - sin(lat1) * sin(lat2)
        )

        self.init(latitude: lat2.toDeg,
                  longitude: lon2.toDeg)
    }

    init(distance d: CLLocationDistance,
         bearing b: CLLocationDegrees,
         from location: CLLocation) {
        self.init(distance: d, bearing: b, from: location.coordinate)
    }
}
