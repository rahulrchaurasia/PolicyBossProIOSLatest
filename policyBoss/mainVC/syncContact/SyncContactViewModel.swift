//
//  SyncContactViewModel.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 23/03/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import Foundation

class SyncContactViewModel{
    
    static let shareInstance = SyncContactViewModel()

    func fetchDataFromApi( subContactList : [ContactMainModel],rawData : String, completionHandler : @escaping Handler) {
        
        
        
        let urlString = String("https://horizon.policyboss.com:5443/sync_contacts/contact_entry")
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        debugPrint("URL :-", urlString)
        
        guard let FBAId = (UserDefaults.standard.string(forKey: "FBAId"))
        else{ return }
        
        guard let parentid = (UserDefaults.standard.string(forKey: "parentid"))
        else{ return }
        
        guard let ssid = (UserDefaults.standard.string(forKey: "POSPNo"))
        else{ return }
        
        var fbaid = ""
        var sub_fba_id = ""
        if (parentid.trimmingCharacters(in: .whitespacesAndNewlines) == "" || parentid == "0" ) {
            
            fbaid = FBAId
            sub_fba_id = parentid
            
        } else {
            fbaid = parentid
            sub_fba_id = FBAId
        }
        let syncReqData = SyncContactModelRequest(
            fbaid: fbaid,
            ssid: ssid,
            sub_fba_id: sub_fba_id,
            raw_data: rawData,
            contactlist: subContactList
        )
        do {
            let jsonReq = try JSONEncoder().encode(syncReqData)
            debugPrint("Request:-", syncReqData)
            request.httpBody = jsonReq
        } catch {
            print(error.localizedDescription)
        }
        
        
        
        URLSession.shared.dataTask(with: request) { (  data, response, error) in
            
            if let error = error {
                completionHandler(.failure(.custom(message: error.localizedDescription)))
                return
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completionHandler(.failure(.custom(message: serverError)))
                return
            }
            guard let data = data else {
                
                completionHandler(.failure(.custom(message: serverUnavailbleError)))
                return
            }
            
            debugPrint("***RESPONSE****" , data)
            
            do {
                
                let respData  = try
                JSONDecoder().decode(SyncContactResponse.self, from: data)
                
                
                if respData.StatusNo == 0 {
                    
                    completionHandler(.success(respData))
                }else{
                    
                    completionHandler(.failure(.custom(message: respData.Message ?? serverUnavailbleError)))
                }
                //switch
                
                
            } catch let error {
                debugPrint("Error",error.localizedDescription)
                completionHandler(.failure(.custom(message: error.localizedDescription)))
            }
        }.resume()
        //}
        
        
    }
    
    func fetchDataFromApiNOTINUSED( subContactList : [ContactMainModel], completionHandler : @escaping Handler) {
        


        let urlString = String("https://horizon.policyboss.com:5443/sync_contacts/contact_entry")
                guard let url = URL(string: urlString) else {
                    return
                }
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            debugPrint("URL :-", urlString)
        
        let syncReqData = SyncContactModelRequest(
                    fbaid: "89435",
                    ssid: "119227",
                    sub_fba_id: "0",
                    raw_data: "",
                    contactlist: subContactList
                    )
                do {
                    let jsonReq = try JSONEncoder().encode(syncReqData)
                    debugPrint("Request:-", syncReqData)
                    request.httpBody = jsonReq
                } catch {
                    print(error.localizedDescription)
                }
        
        
       
            URLSession.shared.dataTask(with: request) { (  data, response, error) in
                
                if let error = error {
                    completionHandler(.failure(.custom(message: error.localizedDescription)))
                           return
                       }
                
                if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    completionHandler(.failure(.custom(message: serverError)))
                           return
                       }
                guard let data = data else {
        
                    completionHandler(.failure(.custom(message: serverUnavailbleError)))
                           return
                       }
                
                debugPrint("***RESPONSE****" , data)
                
                do {
                   
                    let respData  = try
                       JSONDecoder().decode(SyncContactResponse.self, from: data)
                    
                   
                    if respData.StatusNo == 0 {
                        
                        completionHandler(.success(respData))
                    }else{
                        
                        completionHandler(.failure(.custom(message: respData.Message ?? serverUnavailbleError)))
                    }
                    //switch
                    
                    
                } catch let error {
                    debugPrint("Error",error.localizedDescription)
                    completionHandler(.failure(.custom(message: error.localizedDescription)))
                }
            }.resume()
        //}
            
        
    }
}


struct SyncContactModelRequest : Encodable {
    var fbaid : String
    var ssid : String
    var sub_fba_id : String
    var device_id : String?
    var raw_data : String
    var contactlist : [ContactMainModel] = []
   
}
// Encodable : For Swift To JSON
struct ContactMainModel :Identifiable, Encodable  {
    
    //var id1 = UUID().uuidString
    var id : Int
    var name : String
    var mobileno : String
}


struct ContactModel :Identifiable, Encodable {
    var id = UUID().uuidString
    
    var Name: String //= "No firstName"
    var PhoneNumbers: [String] //= []
    var EmailAddresses: [String]// = []
    
    var OrganizationName: String
    
    var PostalAddress: [String]
    
    var Nickname: String
  

}





struct SyncContactResponse: Codable {
    let Message , Status: String?
    let StatusNo: Int?

   
}
