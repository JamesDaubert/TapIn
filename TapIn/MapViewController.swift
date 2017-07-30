//
//  MapViewController.swift
//  TapIn
//
//  Created by James Daubert on 7/24/17.
//  Copyright © 2017 James Daubert. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var resultSearchController: UISearchController? = nil
    var selectedPin:MKPlacemark? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "SearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for bars"
        navigationItem.titleView =  resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
       
        locationSearchTable.mapView = mapView
        
        locationSearchTable.handleMapSearchDelegate = self
        
        
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.location!.coordinate
        mapView.region = MKCoordinateRegionMakeWithDistance(mapView.centerCoordinate, 2000, 2000)
    }
    
    @IBAction func zoomIn(_ sender: Any) {
        let userLocation = mapView.userLocation
        
        let region = MKCoordinateRegionMakeWithDistance(userLocation.location!.coordinate, 2000, 2000)
        
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func changeMapType(_ sender: Any) {
        if (mapView.mapType == MKMapType.standard) {
            mapView.mapType = MKMapType.satellite
        } else {
            mapView.mapType = MKMapType.standard
        }
        
    }
    
}

extension MapViewController: HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark) {
        selectedPin = placemark
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city), \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.5, 0.5)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
}

extension MapViewController {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.orange
        pinView?.canShowCallout = true
//        let smallSquare = CGSize(width: 30, height: 30)
//        let button = UIButton()
//        button.sizeThatFits(smallSquare)
//        let car = UIImage(named: "car")
//        button.setBackgroundImage(car, for: .normal)
//        button.addTarget(self, action: "openUber", for: .touchUpInside)
//        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
    
}
