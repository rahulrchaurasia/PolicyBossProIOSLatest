//
//  LocationViewModel.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 08/05/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import Foundation


class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    @Published var locationText = "Location not available"
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func fetchLocation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .denied:
            locationText = "Location permission denied"
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            locationText = "Location access restricted"
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        locationText = "Latitude: \(userLocation.coordinate.latitude), Longitude: \(userLocation.coordinate.longitude)"
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationText = "Error getting location"
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .denied:
            locationText = "Location permission denied"
        case .notDetermined:
            break
        case .restricted:
            locationText = "Location access restricted"
        default:
            break
        }
    }
}
