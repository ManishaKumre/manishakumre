//
//  HeadLinesViewController.swift
//  manishakumre
//
//  Created by Rajeshwari Sharma on 22/11/23.
//

import UIKit
import Kingfisher

class HeadLinesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var mtableview: UITableView!
   
    let reachability = try! Reachability()
    
    var headlineViewModel=HeadlineViewModel()
   
 
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Helllloooooooooo")
        CallingApi()
    //    OrangeView.backgroundColor = UIColor(hex: 0xfd7e14)
        mtableview.delegate=self
        mtableview.dataSource=self
        mtableview.register(UINib(nibName: "HeadlineCell", bundle: Bundle.main), forCellReuseIdentifier: "HeadlineCell")
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async { [self] in
            NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
                do{
                    try self.reachability.startNotifier()
                }catch{
                  print("could not start reachability notifier")
                }
        }
    }
    @objc func reachabilityChanged(note: Notification) {

      let reachability = note.object as! Reachability

      switch reachability.connection {
      case .wifi:
          print("Reachable via WiFi")
      case .cellular:
          print("Reachable via Cellular")
      case .none:
        print("Network not reachable")
         
          
          
          
          
          
          
      default:
          break
      }
    }
    
  deinit{
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            print("Swipee")
          
         
            self.navigationController?.popViewController(animated: true)
           
        }
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return comissionerViewModel.comissionerDataModel?.dtVal?.count ?? 0
        return headlineViewModel.headNewsModel?.articles?.count ?? 0
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
       
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeadlineCell") as! HeadlineCell
//            \(comissionerViewModel.comissionerDataModel?.dtVal?[indexPath.row].sTD_Code ?? "")"
            cell.nsamelbl.text = "\(headlineViewModel.headNewsModel?.articles![indexPath.row].source?.name ?? "")"
            cell.headlinelbl.text = "\(headlineViewModel.headNewsModel?.articles?[indexPath.row].title ?? "")"
        
        
        let originalDateString = "\(headlineViewModel.headNewsModel?.articles?[indexPath.row].publishedAt ?? "")"

        let isoDateFormatter = ISO8601DateFormatter()
        if let date = isoDateFormatter.date(from: originalDateString) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let extractedDate = dateFormatter.string(from: date)
            cell.date.text  = extractedDate
            print(extractedDate)
        } else {
            print("Invalid date format")
        }
        
        
//
            if let imageUrlString = headlineViewModel.headNewsModel?.articles?[indexPath.row].urlToImage, !imageUrlString.isEmpty {
                // Convert the URL string to a URL object
                if let imageUrl = URL(string: imageUrlString) {
                    // Use Kingfisher to load and cache the image
                    cell.img.kf.setImage(with: imageUrl)
                } else {
                    // Handle invalid URL
                    print("Invalid URL")
                }
            } else {
                // Handle the case where the model doesn't have a valid image URL
                print("Image URL not available or invalid in the model")
            }

               
            
            return cell
      
     
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hgg")
        guard let selectedArticle = headlineViewModel.headNewsModel?.articles?[indexPath.row] else {
                    return
                }

                let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
        detailViewController.articles=headlineViewModel.headNewsModel?.articles?[indexPath.row].description ?? ""
        detailViewController.titles=headlineViewModel.headNewsModel?.articles?[indexPath.row].title ?? ""
        detailViewController.authorss=headlineViewModel.headNewsModel?.articles?[indexPath.row].author ?? ""
        let originalDateString = headlineViewModel.headNewsModel?.articles?[indexPath.row].publishedAt ?? ""

        let isoDateFormatter = ISO8601DateFormatter()
        if let date = isoDateFormatter.date(from: originalDateString) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let extractedDate = dateFormatter.string(from: date)
            detailViewController.dates = extractedDate
            print(extractedDate)
        } else {
            print("Invalid date format")
        }
        
        
        
        
        
   
        detailViewController.images=headlineViewModel.headNewsModel?.articles?[indexPath.row].urlToImage ?? ""
        detailViewController.modalPresentationStyle = .fullScreen
             present(detailViewController, animated: true)
    }
    
    func CallingApi(){
        print("Callingapi")
//        LoadingIndicator.shared.startLoading()
        headlineViewModel.NewsGetApi{ [weak self] result in
            switch result {
                
            case .success(let data):
                self?.headlineViewModel.headNewsModel = data
                print(data)
                DispatchQueue.main.async {
                   
                    let cleanedString=self?.headlineViewModel.headNewsModel?.articles?.count ?? 0
                    print("Sonu\(cleanedString)")
                    if cleanedString > 0{
                        self?.mtableview.reloadData()
//                        LoadingIndicator.shared.stopLoading()
                        
                    }
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
                
            }
        }
        
    }
    
    
    
    
    
}




