//
//  LocationManager.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2018-01-24.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import CoreLocation
import Foundation
import RxCocoa
import RxSwift

/// A singleton that provides access the the device location.
public final class LocationManager: NSObject {
    public static let shared = LocationManager()
    
    let coreLocationManager: CLLocationManager
    
    private let _currentLocation = BehaviorRelay<CLLocation?>(value: nil)
    public var currentLocation: CLLocation? {
        return _currentLocation.value
    }
    public var onCurrentLocation: Observable<CLLocation> {
        return _currentLocation
            .asObservable()
            .startWith(currentLocation)
            .unwrap()
    }
    private let _currentHeading = BehaviorRelay<CLHeading?>(value: nil)
    public var currentHeading: CLHeading? {
        return _currentHeading.value
    }
    public var onCurrentHeading: Observable<CLHeading> {
        return _currentHeading
            .asObservable()
            .startWith(currentHeading)
            .unwrap()
    }
    public var onUpdate: Observable<(CLLocation, CLHeading)> {
        return Observable.combineLatest(onCurrentLocation, onCurrentHeading)
    }
    private let _onError = PublishSubject<Error>()
    public var onError: Observable<Error> {
        return _onError.asObservable()
    }
    
    private override init() {
        coreLocationManager = CLLocationManager.make({
            $0.pausesLocationUpdatesAutomatically = false
            $0.distanceFilter = kCLDistanceFilterNone
            $0.headingFilter = kCLHeadingFilterNone
            $0.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        })
        
        super.init()
        
        defer {
            coreLocationManager.delegate = self
            locationManager(coreLocationManager,
                            didChangeAuthorization: CLLocationManager.authorizationStatus())
        }
    }
    
    func requestLocation() {
        coreLocationManager.requestLocation()
    }
}


// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager,
                                didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            coreLocationManager.startUpdatingLocation()
            coreLocationManager.startUpdatingHeading()
        case .notDetermined, .restricted:
            coreLocationManager.requestWhenInUseAuthorization()
        case .denied:
            break
        @unknown default:
            break
        }
    }
    
    public func locationManager(_ manager: CLLocationManager,
                                didUpdateLocations locations: [CLLocation]) {
        //        _currentLocation.accept(locations.min(by: {
        //            $0.horizontalAccuracy < $1.horizontalAccuracy
        //        }))
        _currentLocation.accept(manager.location)
    }
    
    public func locationManager(_ manager: CLLocationManager,
                                didUpdateHeading newHeading: CLHeading) {
        _currentHeading.accept(newHeading)
    }
    
    public func locationManager(_ manager: CLLocationManager,
                                didFailWithError error: Error) {
        _onError.onNext(error)
    }
}
