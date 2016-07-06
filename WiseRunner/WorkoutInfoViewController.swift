
//
//  WorkoutInfoViewController.swift
//  WiseRunner
//
//  Created by Dima Cheverda on 7/6/16.
//  Copyright © 2016 Dima Cheverda. All rights reserved.
//

import UIKit
import MapKit

class WorkoutInfoViewController: UIViewController {

  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var distanceLabel: UILabel!
  @IBOutlet weak var averageSpeedLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var mapView: MKMapView!
  
  var workout: Workout!
  let dateFormatter = NSDateFormatter()
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dateFormatter.dateStyle = .ShortStyle
    dateFormatter.timeStyle = .MediumStyle

    setupMapView()
    setupInfoLabels()
  }
  
  // MARK: - Setup
  
  func setupMapView() {
    mapView.delegate = self
    
    if let region = mapRegion() {
      mapView.region = region
    }
    
    mapView.addOverlay(pathPolyline())
  }
  
  func setupInfoLabels() {
    dateLabel.text = dateFormatter.stringFromDate(workout.startDate)
    timeLabel.text = String.fromSeconds(workout.duration)
    distanceLabel.text = String(format: "%.1f m", workout.distance)
    averageSpeedLabel.text = String(format: "%.1f mps", workout.distance / Double(workout.duration))
    typeLabel.text = WorkoutType.typeString(atIndex: workout.type)
  }
  
  // MARK: - Helpers
  
  func mapRegion() -> MKCoordinateRegion? {
    
    guard workout.locations.count > 0 else {
      return nil
    }
    
    var region = MKCoordinateRegion()
    
    var minLat = workout.locations.first!.latitude
    var maxLat = workout.locations.first!.latitude
    var minLong = workout.locations.first!.longitude
    var maxLong = workout.locations.first!.longitude
    
    for location in workout.locations {
      if location.latitude < minLat {
        minLat = location.latitude
      }
      if location.latitude > maxLat {
        maxLat = location.latitude
      }
      if location.longitude < minLong {
        minLong = location.longitude
      }
      if location.longitude > maxLong {
        maxLong = location.longitude
      }
    }
    
    region.center.latitude = (minLat + maxLat) / 2.0
    region.center.longitude = (minLong + maxLong) / 2.0
    
    region.span.latitudeDelta = (maxLat - minLat) * 2
    region.span.longitudeDelta = (maxLong - minLong) * 2
    
    return region
  }
  
  func pathPolyline() -> MKPolyline {
    var coordinates: [CLLocationCoordinate2D] = []
    
    for location in workout.locations {
      coordinates.append(CLLocationCoordinate2DMake(location.latitude, location.longitude))
    }
    
    return MKPolyline(coordinates: &coordinates, count: coordinates.count)
  }
  
}


extension WorkoutInfoViewController: MKMapViewDelegate {
  
  func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
    
    if let polyline = overlay as? MKPolyline {
      let polylineRenderer = MKPolylineRenderer(overlay: polyline)
      polylineRenderer.strokeColor = UIColor.blueColor()
      polylineRenderer.lineWidth = 3
      
      return polylineRenderer
    }
    
    let renderer = MKOverlayRenderer(overlay: overlay)
    
    return renderer
  }

}
