//
//  MapViewController.swift
//  Capp
//
//  Created by Ronak Shah on 10/27/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    var matchingItems:[MKMapItem] = []
    let locationManager = CLLocationManager()
    var location = CLLocation()
    let searchRadius: CLLocationDistance = 2000
    var searchQuery:String?
    let initialLocation = CLLocation(latitude: 52.3740300, longitude: 4.8896900)
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
   
        
        if let usrloc = mapView.userLocation.location {
          let coordinateRegion = MKCoordinateRegionMakeWithDistance(usrloc.coordinate, searchRadius * 2.0, searchRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        searchInMap()
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
    }
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    @IBAction func search(_ sender: UIBarButtonItem) {
        mapView.removeAnnotations(mapView.annotations)
        searchInMap()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func searchInMap(){
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = self.searchQuery
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start {
            (response: MKLocalSearchResponse!, error: Error!) in
            self.matchingItems = response.mapItems
            for item in response.mapItems {
                self.addPinToMapView(title: item.name!, latitude: (item.placemark.location?.coordinate.latitude)!, longitude: (item.placemark.location?.coordinate.longitude)!)
            }
        }
    }
    
    func addPinToMapView(title: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MyAnnotations(coordinate: location, title: title)
        self.mapView.addAnnotation(annotation)
    }
}
extension MapViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.first!
    }
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
            //locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
}

extension MapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        
        if annotation is MKUserLocation {
            return nil
        }else {
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            }else {
                annotationView!.annotation = annotation
            }
        }
        annotationView?.canShowCallout = true
        annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return annotationView
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        var item = MKMapItem()
        var placeName:String?
        if let name = view.annotation?.title ?? "empty" {
            placeName=name
            item=getMathingItem(name: name)
        }
        let address=parseAddress(selectedItem: item.placemark)
        print(placeName!+" "+address)
        
    }
    func getMathingItem( name:String) -> MKMapItem {
        for item in self.matchingItems{
            if item.placemark.name == name {
                return item
            }
        }
        return MKMapItem()
    }
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let thirdSpace = (selectedItem.administrativeArea != nil && selectedItem.postalCode != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? "",
            thirdSpace,
            // zip code
            selectedItem.postalCode ?? ""
        )
        return addressLine
    }
}
