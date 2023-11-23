//
//  NewsDetailsViewController.swift
//  manishakumre
//
//  Created by Rajeshwari Sharma on 23/11/23.
//

import UIKit


class NewsDetailsViewController: UIViewController {

    
   
    
    var articles:String=""
    var images:String=""
    var titles:String=""
    var authorss:String=""
    var dates:String=""
    
    
    
    
    
    
    
    
    @IBOutlet weak var imaged: UIImageView!
    @IBOutlet weak var detailview: UIView!
    
    @IBOutlet weak var deatiltitle: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var decsriptionlbl: UILabel!
    
    @IBOutlet weak var timelbl: UILabel!
    
    var selectedArticle:String?
    override func viewDidLoad() {
        super.viewDidLoad()
print("dj\(articles)")
        decsriptionlbl.text=articles
        name.text=authorss
        timelbl.text=dates
        deatiltitle.text=titles
        
        if !images.isEmpty {
            // Convert the URL string to a URL object
            if let imageUrl = URL(string: images) {
                // Use Kingfisher to load and cache the image
                imaged.kf.setImage(with: imageUrl)
            } else {
                // Handle invalid URL
                print("Invalid URL")
            }
        } else {
            // Handle the case where the model doesn't have a valid image URL
            print("Image URL not available or invalid in the model")
        }

//        if let article = selectedArticle {
//                    // Update UI elements with article details
//                    deatiltitle.text = article.title
//                    name.text = article.source?.name
//                    decsriptionlbl.text = article.description
//                    timelbl.text = article.publishedAt
//
//                    // Load and display the image asynchronously
//                    if let imageUrlString = article.urlToImage, !imageUrlString.isEmpty {
//                        if let imageUrl = URL(string: imageUrlString) {
//                            imaged.kf.setImage(with: imageUrl)
//                        } else {
//                            print("Invalid URL")
//                        }
//                    } else {
//                        print("Image URL not available or invalid in the model")
//                    }
//                }
            }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}
