//
//  VilleModele.swift
//  zoomCarte
//
//  Created by Philippe MICHEL on 11/03/2024.
//

import Foundation
import SwiftUI
import MapKit

struct VilleModele:Identifiable {
    var id:UUID = UUID()
    var nom:String
    var latitude:Double
    var longitude:Double
    var deltaLat:CLLocationDegrees
    var deltaLong:CLLocationDegrees
}
