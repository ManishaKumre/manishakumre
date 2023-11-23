//
//  HeadlineViewModel.swift
//  manishakumre
//
//  Created by Rajeshwari Sharma on 23/11/23.
//




import Foundation
import Alamofire


final class HeadlineViewModel{

    var headNewsModel:HeadlineModel?
func NewsGetApi( completion: @escaping (Result<HeadlineModel, Error>) -> Void) {
            // URL of the XML data source
    
    let strurl="https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=3846db1af2974b6892f7f0bdc55321c3"
    print("strurl",strurl)
            guard let url = URL(string: strurl) else {
                print("Invalid URL")
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                if let data = data {
                    // Parse the XML data and print it to the console
                    
                   
                                do {
                                    self.headNewsModel = try JSONDecoder().decode(HeadlineModel.self, from: data)
                                    print(self.headNewsModel!,"headNewsModel")
                                    completion(.success(self.headNewsModel!))
                                //    self.impNewsDataModel = jsonData // Assign the array of NotesDataModel
                               
                                    // Assign the parsed model to your property
                                    
                                } catch {
                                    print("Error decoding XML: \(error)")
                                    completion(.failure(error) )
                                }
                            }
                    
                }
            
            
   task.resume()
        }







}





/*print("raja")
 let urlStr = "https://schoolforme.in:5000/api/students/me/personal"
 let hearder=["token":Defaults().token]
 Alamofire.request(urlStr, method: .get,encoding: JSONEncoding.default,headers: hearder).responseData { [self] response in // note the change to responseData
     switch response.result {
     case .failure(let error):
         print(error)
     case .success(let data):
         
         do{
             
             self.personalArray =  try JSONDecoder().decode(PersonalInfoModel.self,from: data)
             print("yooo\(self.personalArray)")
             Defaults().countryId=self.personalArray?.data?.country ?? 0
             Defaults().stateId=self.personalArray?.data?.state ?? 0
             Defaults().cityId=self.personalArray?.data?.city ?? 0
             DispatchQueue.main.async {
                 Defaults().aadharImage=self.personalArray?.data?.aadhar_card ?? ""
                 Defaults().Samagraimage=self.personalArray?.data?.samagra_Id ?? ""
                 Defaults().profileimage=self.personalArray?.data?.profile ?? ""
                 Defaults().placeofbirthimage=self.personalArray?.data?.birth_certificate ?? ""
                 activityIndicator.stopAnimating()
                 self.TableView.reloadData()
                 //  let type=personalArray?.data.studentParents[IndexPath.row].parent_type ?? ""
             }
      
         }catch
         { print(error) }
   
         
     }
 }
 
}*/
