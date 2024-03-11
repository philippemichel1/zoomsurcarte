//
//  ContentView.swift
//  zoomCarte
//
//  Created by Philippe MICHEL on 11/03/2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var villes:[VilleModele] = [VilleModele(nom: "Angers", latitude: 47.469746, longitude: -0.551544, deltaLat: 1, deltaLong: 1),VilleModele(nom: "Paris", latitude: 48.8568, longitude: 2.3522, deltaLat: 1, deltaLong: 1),VilleModele(nom: "Tokyo", latitude: 35.6897, longitude: 139.6922, deltaLat: 1, deltaLong: 1),VilleModele(nom: "Londre", latitude: 51.707222, longitude: -0.01275, deltaLat: 1, deltaLong: 1),VilleModele(nom: "Ottawa", latitude: 45.41117, longitude: -75.69812, deltaLat: 1, deltaLong: 1),VilleModele(nom: "Canberra", latitude: -35.282000, longitude: 149.128684, deltaLat: 1, deltaLong: 1),VilleModele(nom: "Pékin", latitude: 39.903315, longitude: 116.408703, deltaLat: 1, deltaLong: 1),VilleModele(nom: "Séoul", latitude: 37.551891, longitude: 126.991794, deltaLat: 1, deltaLong: 1), VilleModele(nom: "Doha", latitude: 25.291610, longitude: 51.530437, deltaLat: 1, deltaLong: 1), VilleModele(nom: "Odessa", latitude: 46.482526, longitude: 30.723309, deltaLat: 1, deltaLong: 1), VilleModele(nom: "Conakry", latitude: 9.509167, longitude: -13.712222, deltaLat: 1, deltaLong: 1)]
        // trie le tableau par ordre alphabetique
        .sorted(by:{$0.nom < $1.nom})
    
    @State var selectionVille:Int = 0
    @State private var zoomCarte: Double = 1.0
    
    @State private var positionCamera:MapCameraPosition = .region(
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:  47.469746, longitude: -0.551544),
                           span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)))
    
    var body: some View {
        Map(position: $positionCamera)
        // Gestion des boutons sur la carte
            .mapControls {
                // Bouton 3D sur carte
                MapPitchToggle()
            }
            .mapStyle(.hybrid(elevation: .realistic))
        
        VStack {
            HStack{
                Spacer()
                Text("Villes")
                    .font(.headline)
                    .padding(.top, 8)
                Spacer()
                    
                Text("Zoom")
                    .font(.headline)
                    .padding(.top, 8)
                Spacer()
            }
        }
        HStack {
            Spacer()
                Picker("Villes", selection: $selectionVille) {
                    ForEach(0..<villes.count) { index in
                        Text(villes[index].nom)
                    }
                }
            .frame(height: 100)
            .onChange(of: selectionVille) {
                positionCamera = .region(
                    MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:  villes[selectionVille].latitude, longitude: villes[selectionVille].longitude),
                                       span: MKCoordinateSpan(latitudeDelta: villes[selectionVille].deltaLat, longitudeDelta: villes[selectionVille].deltaLong)))
                //Réinitialise le zoom de la carte à sa valeur minimum
                        zoomCarte = 1.0
            }
            // le style de picker
            .pickerStyle((.inline))
          
            Slider(value: $zoomCarte, in: 1.0...300.0, step: 1.0) {
                    Text("Zoom")
                } minimumValueLabel: {
                    Text("Min")
                        .font(.headline)
                    
                } maximumValueLabel: {
                    Text("Max")
                        .font(.headline)
                }
                .frame(width:180)
                .padding(.horizontal)
                .onChange(of: zoomCarte) {
                    zoomCarteRegion()
                }
        }
        Spacer()
    }
    // fonction de la gestion du zoom de la carte
   private func zoomCarteRegion() {
           positionCamera = .region(
               MKCoordinateRegion(
                   center: CLLocationCoordinate2D(
                       latitude: villes[selectionVille].latitude,
                       longitude: villes[selectionVille].longitude
                   ),
                   span: MKCoordinateSpan(
                       latitudeDelta: villes[selectionVille].deltaLat / zoomCarte,
                       longitudeDelta: villes[selectionVille].deltaLong / zoomCarte
                   )
               )
           )
       }
}
#Preview {
    ContentView()
}
