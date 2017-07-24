//
//  LocationSearchTableViewController.swift
//  TapIn
//
//  Created by James Daubert on 7/24/17.
//  Copyright © 2017 James Daubert. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTable: UITableViewController {
    var matchingItems: [MKMapItem] = []
    var mapView: MKMapView? = nil
    
}

extension LocationSearchTable: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}
