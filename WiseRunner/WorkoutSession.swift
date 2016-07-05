//
//  WorkoutSession.swift
//  WiseRunner
//
//  Created by Dima Cheverda on 7/5/16.
//  Copyright © 2016 Dima Cheverda. All rights reserved.
//

import Foundation
import CoreLocation

class WorkoutSession: NSObject {
  
  var distance: CLLocationDistance = 0.0
  var seconds: Int = 0
  let locationManager = CLLocationManager()
  var locations: [CLLocation] = []
  
  // MARK: - Init
  
  override init() {
    super.init()
    
    setupLocationUpdates()
    startWorkout()
  }
  
  // MARK: - Setup
  
  func setupLocationUpdates() {
    locationManager.requestAlwaysAuthorization()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.activityType = .Fitness
    locationManager.distanceFilter = 10
  }
  
  // MARK: - Actions
  
  func startWorkout() {
    locationManager.startUpdatingLocation()
  }
  
  func endWorkout() {
    locationManager.stopUpdatingLocation()
  }
  
  // MARK: - Realm
  
}

extension WorkoutSession: CLLocationManagerDelegate {
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print("CLLocation's: \(locations)")
    
    for location in locations {
      if location.horizontalAccuracy < 20 {
        
        if self.locations.count > 0 {
          distance += self.locations.last!.distanceFromLocation(location)
        }
        
        self.locations.append(location)
      }
    }
  }
  
}
