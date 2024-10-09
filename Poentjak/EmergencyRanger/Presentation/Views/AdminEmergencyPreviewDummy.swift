//
//  AdminEmergencyPreviewDummy.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 07/10/24.
//

import SwiftUI
import MapKit

struct AdminEmergencyPreviewDummy: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -6.200000, longitude: 106.816666),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        VStack(spacing: 0) {
            Map(coordinateRegion: $region)
                .frame(height: 500)
            
            VStack(alignment: .leading) {
                
                HStack {
                    Image("dummy")
                        .resizable()
                        .clipShape(Rectangle())
                        .frame(width: 86, height: 86)
                        .cornerRadius(17)
                    
                    VStack(alignment: .leading) {
                        Text("Lorem Joe")
                            .font(.headline)
                        
                        HStack {
                            Text("47% 4 mins ago")
                                .font(.footnote)
                            
                            Text("OVERDUE")
                                .font(.footnote)
                                .foregroundStyle(.red)
                        }
                        
                        Text("Arrival: Sun 6 Oct 17.00")
                            .font(.footnote)
                        
                        Text("HYPOTHERMIA")
                            .foregroundStyle(.blue)
                        
                        
                    }
                    .padding(.leading, 8)
                }
                
                HStack(alignment: .center, spacing: 16) {
                    
                    VStack(alignment: .leading) {
                        Text("Last seen")
                        Text("POS 2")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Last seen")
                        Text("POS 2")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Last")
                        Text("POS 2")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Last")
                        Text("POS 2")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Last")
                        Text("POS 2")
                    }
                    
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Due by 7 pm")
                    Text("6 hr 27 min from now")
                }
                
                Divider()
                    .padding(.horizontal)
                
                Button(action: {
                    
                }) {
                    Text("Select Rangers")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 400)
            .background(Color.white)
            .cornerRadius(20)
            .padding(24)
        }
        .ignoresSafeArea(edges: .top)
    }
}
#Preview {
    AdminEmergencyPreviewDummy()
}
