//
//  WorkoutSession.swift
//  WiseRunner
//
//  Created by Dima Cheverda on 7/5/16.
//  Copyright © 2016 Dima Cheverda. All rights reserved.
//

import Foundation
import CoreLocation
import RealmSwift

class WorkoutSession: NSObject {
  
  var startDate = NSDate()
  var distance: CLLocationDistance = 0.0
  var duration: Int = 0
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
    startDate = NSDate()
    locationManager.startUpdatingLocation()
  }
  
  func endWorkout() {
    locationManager.stopUpdatingLocation()
    saveWorkout()
  }
  
  // MARK: - Realm
  
  private func saveWorkout() {
    let workout = Workout()
    workout.distance = distance
    workout.startDate = startDate
    workout.duration = duration
    
    for rawLocation in locations {
      let location = Location()
      location.latitude = rawLocation.coordinate.latitude
      location.longitude = rawLocation.coordinate.longitude
      location.timestamp = rawLocation.timestamp
      location.speed = rawLocation.speed
      
      workout.locations.append(location)
    }
    
    let realm = try! Realm()
    
    do {
      try realm.write({
        realm.add(workout)
      })
    } catch {
      print("Something went wrong")
    }
  }
  
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
