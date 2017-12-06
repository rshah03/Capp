///
//  MapViewController.swift
//  Capp
//
//  Created by Ronak Shah on 10/27/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


protocol MapSearchBarPin {
    func dropSearchPin(placemark:MKPlacemark)
}

class MapViewController: UIViewController, MapSearchBarPin {
    var matchingItems:[MKMapItem] = []
    let locationManager = CLLocationManager()
    var location = CLLocation()
    let searchRadius: CLLocationDistance = 2000
    var searchQuery:String?
    let initialLocation = CLLocation(latitude: 52.3740300, longitude: 4.8896900)
    var resultSearchController:UISearchController? = nil
    var shops = [Shop]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shops = self.importShopList()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        self.mapView.showsUserLocation = true
        
        if let usrloc = locationManager.location {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance((usrloc.coordinate), searchRadius * 2.0, searchRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        
        
        searchInMap()
        self.mapView.delegate = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "List View", style: .plain, target: self, action: #selector (listView))
        
        
        //map search bar
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = self.mapView
        locationSearchTable.MapSearchBarDelegate = self
        
        
        
    }
    
    
    @objc func listView(){
        self.performSegue(withIdentifier: "ToTableView", sender: self)
    }
    
    @IBAction func search(_ sender: UIBarButtonItem) {
        mapView.removeAnnotations(mapView.annotations)
        searchInMap()
    }
    
    @IBAction func searchNearyby(_ sender: Any) {
        mapView.removeAnnotations(mapView.annotations)
        locationManager.startUpdatingLocation()
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
    
    func dropSearchPin(placemark:MKPlacemark){
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
    
    
    func addPinToMapView(title: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MyAnnotations(coordinate: location, title: title)
        self.mapView.addAnnotation(annotation)
    }
}

extension MapViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last!
        
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: (location.coordinate.latitude), longitude: (location.coordinate.longitude))
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(myLocation, searchRadius * 2.0, searchRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        manager.stopUpdatingLocation()
        //self.map.showsUserLocation = true
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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        self.performSegue(withIdentifier: "ToDetailView", sender: self)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "ToTableView"){
            let dvc = segue.destination as! TableViewController
            dvc.matchingItems=self.matchingItems
        }
        else if (segue.identifier == "ToDetailView"){
            
        }
    }
    
    func importShopList() -> [Shop]{
        let path = Bundle.main.path(forResource: "shopList", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let jsonData = try! Data(contentsOf: url)
        do {
            let shopList = try JSONDecoder().decode([Shop].self, from: jsonData)
            print("IMPORT SHOPLIST: SUCCESS\n\n")
            return shopList
        }
        catch{
            print("\(error)")
        }
        
        
        print("IMPORT SHOPLIST: FAIL\n")
        return [Shop]()
    }
}
