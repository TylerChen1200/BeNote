//
//  LocationManager.swift
//  BeNote
//
//  Created by Jiana Ang on 12/1/24.
//


import CoreLocation
import Foundation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    // Completion handler to return location details
    var locationCompletion: ((String?, String?) -> Void)?
    
    override init() {
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            // Request permission for the first time
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            // Handle denied access
            locationCompletion?(nil, nil)
            print("Location access is restricted or denied.")
        case .authorizedWhenInUse, .authorizedAlways:
            // Location is authorized, proceed to request location
            locationManager.requestLocation()
        @unknown default:
            print("Unhandled authorization status.")
        }
    }

    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        // Use Geocoder to convert coordinates to city and state
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let placemark = placemarks?.first,
                  let city = placemark.locality,
                  let state = placemark.administrativeArea else {
                self?.locationCompletion?(nil, nil)
                return
            }
            
            self?.locationCompletion?(city, state)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
        locationCompletion?(nil, nil)
    }
}
