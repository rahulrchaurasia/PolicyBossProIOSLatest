//
//  SyncContactVC.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 17/03/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import UIKit
import Contacts

class SyncContactVC: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var lblTotalCount: UILabel!
    
    @IBOutlet weak var lblResult: UILabel!
    var contactMainData = [ContactMainModel]()
    var contactData = [ContactModel]()
   // var addressData = [AddressModel]()
    let syncContactQueue = DispatchQueue(label: "com.policybosspro.syncqueue"
                                        )

    override func viewDidLoad() {
        super.viewDidLoad()

      
      
    
        getContactData()
       
       
    }
    
    @IBAction func btnBack(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: false)
    }
    
  
    
    func fetchDataFromApi( subContactList : [ContactMainModel],  maxProgress : Int, currntValue : Float,step : Int ) {
        
    

        let urlString = String("https://horizon.policyboss.com:5443/sync_contacts/contact_entry")
                guard let url = URL(string: urlString) else {
                    return
                }
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            debugPrint("URL :-", urlString)
        
        let syncReqData = SyncContactModelRequest(
                    fbaid: 89435,
                    ssid: 119227,
                    sub_fba_id: 0,
                    raw_data: "",
                    contactlist: contactMainData
                    )
                do {
                    let jsonReq = try JSONEncoder().encode(syncReqData)
                    debugPrint("Request:-", syncReqData)
                    request.httpBody = jsonReq
                } catch {
                    print(error.localizedDescription)
                }
        
        
       // DispatchQueue.global(qos: .utility).async { [weak self]  in
       // syncContactQueue.async { [weak self]  in
            
            URLSession.shared.dataTask(with: request) { [weak self](  data, response, error) in
                
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let syncData  = try decoder.decode(SyncContactResponse.self, from: data)
                    
                    debugPrint("***RESPONSE****" , syncData)
                   
                    DispatchQueue.main.async {
                       
                     
    
                        if(step == maxProgress){
                            self?.progressView.progress = 1.0
                        }else{
                            
                            let currentProgress = Float(step) * currntValue
                            self?.progressView.progress = currentProgress
                            debugPrint("****CURRENT PROGRESS*****",currentProgress, "STEP:",step )
                        }
                        

                    }
                    
                } catch let error {
                    print("Error: ", error)
                }
            }.resume()
        //}
            
        
    }
    
    
    func getContactData(){
    
       

            // Do any additional setup after loading the view.
            
            let store = CNContactStore()
                let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)

            
            // 2
                if authorizationStatus == .notDetermined {
                  // 3
                  store.requestAccess(for: .contacts) { [weak self] didAuthorize,
                  error in
                    if didAuthorize {
                       self?.retrieveContacts(from: store)
                    }
                  }
                } else if authorizationStatus == .authorized {
                    

                    /******** Retreive All the data *******/
                    
                    retrieveContacts(from: store)
                    
                   
                    for contact in self.contactData{
                        
                        let mobilenoList = contact.PhoneNumbers.map{$0}
                        let name = contact.Name
                        
                        if(mobilenoList.count > 0){
                            
//                            for mobile in mobilenoList {
//                                self.contactMainData.append(
//                                    ContactMainModel(id:1, name: name, mobileno: mobile)
//
//                                )
//                            }
                            
                            for (index, mobile) in mobilenoList.enumerated() {
                                self.contactMainData.append(
                                    ContactMainModel(id:index + 1, name: name, mobileno: mobile)
                                   
                                )
                            }
                            
                            

                        }
                        
                    }
                    
                    do{
                        
                        //Mark : comment  For Showing contactMainData Details
                        
//                        let encodedData = try JSONEncoder().encode(contactMainData)
//                        let jsonString = String(data: encodedData,
//                                                encoding: .utf8)
//
//                        if let data = jsonString {
//
//                           var listdata =  data.replacingOccurrences(of: "\\", with: "")
//                            print("maindata",listdata)
//                        }
                        
                        
//                        for index in 0...contactMainData.count{
//                            debugPrint( "Contact SIZE", self.contactMainData.count)
//
//
//                            fetchDataFromApi(step: index) // called api
//
//                        }
                        
                       
                        
                      //  syncContactQueue.async { [weak self]  in
                            
                        // guard let ContactMainList = self.contactMainData else { return  }
                            
                        let ContactMainList = self.contactMainData
                            var   maxProgress = ContactMainList.count / 2

                        let   remainderProgress = ContactMainList.count % 2
                                 
                            
                            if (remainderProgress > 0) {
                                
                                maxProgress = maxProgress + 1
                                
                            }
                            //var  currentProgress  = 1.0 / Float(maxProgress)
                            let progressValue =   1.0 / Float(maxProgress)
                        var currentProgress : Float = 0.0
                            for index in stride(from: 0, to: ContactMainList.count, by: 2) {
                                
                               
                            //    var subContactList = ContactMainList.filter{$0.id > index && $0.id <= (3 + index)}

//                                var subContactList =  ContactMainList.filter {  contactModel in
//                                    contactModel.id > 3
//                                }
                                let subContactList =  ContactMainList.filter { (contactModel) -> Bool in
                                    
                                   return  contactModel.id < 2
                                }
                                var step = (index / 2) + 1
                                //"Filter List ",subContactList
                                debugPrint("STEP BY", step)
                                
                                // Mark : called api
                                /******** API For Sync Contact Data *******/
                                
                                //currentProgress = currentProgress + progressValue
                                //debugPrint("****CURRENTProgress*******", currentProgress)
                                self.fetchDataFromApi(subContactList:subContactList, maxProgress: maxProgress, currntValue: progressValue, step: step)
                                
                                //currentProgress = currentProgress + progressValue
                               
                                
                            }
                            
                       // }
                        
                    
                        
                    }
                    catch let error {
                        print("Error: ", error)
                    }
                    
                  
                    
                    
                }
        
    }
    
    func retrieveContacts(from store: CNContactStore) {
        
        
        DispatchQueue.global(qos: .utility).sync { [weak self]  in
            
            let keys = [CNContactGivenNameKey,CNContactPhoneNumbersKey,CNContactFamilyNameKey,CNContactEmailAddressesKey,
                CNContactOrganizationNameKey,
                
                CNContactPostalAddressesKey,
                //CNContactBirthdayKey,
                //CNContactNoteKey,
                CNContactNicknameKey
                ]
            
            
            let request  = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
            
            self?.contactData = [ContactModel]()
           
            do{
                
                try   store.enumerateContacts(with: request, usingBlock:
                                                
                                                { contact, stop in
                   

                    let tempPhoneData  =  contact.phoneNumbers.filter{ $0.value.stringValue.count >= 10

                    }.compactMap { $0.value.stringValue.digitOnly}

                    
                    var PhoneDataArray = [String]()
                    
                
                  
                    tempPhoneData.forEach { element in

                        if(element.count >= 10){

                            let c =   element.suffix(10)

                            PhoneDataArray.append(String(c))


                        }


                    }
                    
                    debugPrint("Filter Data :", PhoneDataArray)
                
    //
                    self?.contactData.append(
                        ContactModel(
                            Name :"\(contact.givenName) \(contact.familyName)",
                            
                            
    //                        PhoneNumbers: contact.phoneNumbers.compactMap { $0.value.stringValue.removeSpecialCharactersWithoutSpace},

                            PhoneNumbers: PhoneDataArray,
                            
                            EmailAddresses: contact.emailAddresses.compactMap{$0.value as String },
                            
                            OrganizationName:  contact.organizationName,
                           
                           
                            PostalAddress: contact.postalAddresses.compactMap{
                                
                               return  "\($0.value.street) \($0.value.city) \($0.value.postalCode) "
                                
                                
                            },
                        
                            Nickname: contact.nickname
                            
                            // Note: contact.note,
                            
                        ))
                    
                   
                   
                })
               
                

                let encodedData = try JSONEncoder().encode(self?.contactData)
                let jsonString = String(data: encodedData,
                                        encoding: .utf8)

                if let data = jsonString {

                    let listdata =  data.replacingOccurrences(of: "\\", with: "")
                    print(listdata)
                }
                
                
              
                
                
                 //print(self.contactData)
            }catch let err {
                debugPrint("print to fetch Contact" ,  err)
            }
            
           
            
           
           
            DispatchQueue.main.async {
               
                //self?.progressView.progress = 0.4
            }
            
            
        }
        
        
        
        
        
    }
    


}
extension SyncContactVC {
    
    static func shareInstance() -> SyncContactVC
    {
        return SyncContactVC.initiateFromStoryboard(name: storyBoardName.SyncContact)
    }
}


struct SyncContactModelRequest : Encodable {
    var fbaid : Int
    var ssid : Int
    var sub_fba_id : Int
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




