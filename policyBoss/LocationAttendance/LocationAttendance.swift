//
//  LocationAttendance.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 08/05/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import SwiftUI

struct LocationAttendanceView: View {
    
    @Environment(\.presentationMode) var presentationMode
   
    @State var txtSearch : String = ""
    @StateObject var locationViewModel = LocationViewModel()
    
    var body: some View {
        ScrollView{
            
          
            VStack(alignment: .leading) {
                
                HStack(spacing: 0){
                    
                    Button {
                     presentationMode.wrappedValue.dismiss()
                        
                        
                    }
                label: {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 24))
                           
                            .frame(width: 60, height: 40)
                            .foregroundColor(.blue)
                    }
                    
                    Text("PolicyBoss Attendance!!")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                }.padding(.leading, -20)
                   
                   
                
                 TextField("Type Something Here..", text: $txtSearch)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                
                Button {
                    saveButtonClick()
                } label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(
                            Color.accentColor
                        )
                        .cornerRadius(10)
                }

            }.padding(14)
            
           
                         
                            
                            
        }
        .animation(nil)
        .navigationTitle("Add an Item 🖋️")
       
    }
    
    func saveButtonClick(){
         
        print("Done")
       
    }
}

struct LocationAttendance_Previews: PreviewProvider {
    static var previews: some View {
        LocationAttendanceView()
    }
}
