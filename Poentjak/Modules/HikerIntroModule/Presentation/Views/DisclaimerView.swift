//
//  DisclaimerView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 30/10/24.
//

import SwiftUI

struct DisclaimerView: View {
    var body: some View {
        VStack{
            Spacer()
            VStack(spacing: 16){
                Image(systemName: "exclamationmark.circle")
                    .font(.largeTitleEmphasized)
                Text("Legal Disclaimer")
                    .font(.title1Emphasized)
            }
            Spacer()
            
            VStack(alignment: .leading, spacing: 25){
                Text("Hikewise is designed to assist by providing\nalerts to **local rangers in emergency\nsituations.** However, we cannot guarantee\nassistance or outcomes, especially in areas\nwith poor or no signal.")
                    
                
                Text("It is the user’s responsibility to **follow\nsafety guidelines and make responsible\ndecisions while hiking.** Hikewise is not\nliable for any incidents resulting from\nfailure to follow instructions, lack of signal,\nor reckless behavior. ")
                
                Text("Always hike with caution and be **aware of\nyour surroundings.**")
            }
            .font(.calloutRegular)
            
            Spacer()
            
            NavigationLink(destination: FirstNameLastNameView()){
                CustomLargeButtonComponent(state: .enabled, text: "I agree"){
                    print("ASDFASDF")
                }
                .allowsHitTesting(false)
            }
            
            
            Spacer()
            
        }
        .foregroundStyle(Color.primaryGreen500)
        .padding()
        
    }
}

#Preview {
    DisclaimerView()
}
