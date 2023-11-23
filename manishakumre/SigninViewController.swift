//
//  ViewController.swift
//  manishakumre
//
//  Created by Rajeshwari Sharma on 22/11/23.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import GoogleSignIn



class SigninViewController: UIViewController {
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    
    @IBOutlet weak var Loginbuttonoutlet: UIButton!
    
    
    @IBOutlet weak var textflied: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        Loginbuttonoutlet.layer.cornerRadius=25
        //
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        if let gifURL = Bundle.main.url(forResource: "1u13", withExtension: "gif"),
           let gifData = try? Data(contentsOf: gifURL),
           let animatedImage = createAnimatedImage(with: gifData) {
            backgroundImageView.animationImages = animatedImage
            backgroundImageView.animationDuration = TimeInterval(animatedImage.count) * 0.1 // Adjust the duration as needed
            backgroundImageView.startAnimating()
        }
    }
    @objc func dismissKeyboard() {
      
       
       view.endEditing(true)
         
        }
    func createAnimatedImage(with gifData: Data) -> [UIImage]? {
        guard let source = CGImageSourceCreateWithData(gifData as CFData, nil) else {
            return nil
        }
        
        let frameCount = CGImageSourceGetCount(source)
        var images = [UIImage]()
        
        for i in 0..<frameCount {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                let uiImage = UIImage(cgImage: cgImage)
                images.append(uiImage)
            }
        }
        
        return images
    }
    
    @IBAction func Signingaction(_ sender: Any) {
        
             let nextvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HeadLinesViewController") as! HeadLinesViewController
             
             
             nextvc.modalPresentationStyle = .fullScreen
                  present(nextvc, animated: true)
             
        
        guard let phoneNumber = textflied.text, !phoneNumber.isEmpty else {
         
            return
        }
        print(phoneNumber)
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        PhoneAuthProvider.provider().verifyPhoneNumber("+91\(phoneNumber)", uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                // Handle verification error
                print("Error: \(error.localizedDescription)")
                return
            }
            
            // Save verificationID for later use
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
       
            
            
            
        }
    }

        
        
        
        
        
        
        
  
//    let nextvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HeadLinesViewController") as! HeadLinesViewController
//    nextvc.modalPresentationStyle = .fullScreen
//             
//        present(nextvc, animated: true)
        
        
       
  
    
    
    @IBAction func Appleaction(_ sender: Any) {
    }
    
    @IBAction func GoogleAction(_ sender: Any) {
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
          guard error == nil else { return }

          // If sign in succeeded, display the app's main content View.
        }
    }
}

extension UIImageView {
    static func fromGif(frame: CGRect, resourceName: String) -> UIImageView? {
        guard let path = Bundle.main.path(forResource: "Universe", ofType: "gif") else {
            print("Gif does not exist at that path")
            return nil
        }
        let url = URL(fileURLWithPath: path)
        guard let gifData = try? Data(contentsOf: url),
            let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { return nil }
        var images = [UIImage]()
        let imageCount = CGImageSourceGetCount(source)
        for i in 0 ..< imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        let gifImageView = UIImageView(frame: frame)
        gifImageView.animationImages = images
        return gifImageView
    }
}
