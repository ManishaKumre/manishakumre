//
//  CardViewExtension.swift
//  STudentSchoolforme
//
//  Created by user229548 on 3/1/23.
//

import Foundation
import UIKit


@IBDesignable class CardView :UIView{
    
    
  @IBInspectable  var cornerradius:CGFloat = 5
    var ofsetWifth:CGFloat = 0
    var ofsetHeight:CGFloat = 5
    var ofsetShadow:CGFloat = 2
    @IBInspectable  var colour:UIColor = UIColor.systemGray4
    
    var ofsetShadowOpacity:Float = 5
    override func layoutSubviews() {
        layer.cornerRadius = self.cornerradius
        layer.shadowColor = self.colour.cgColor
        layer.shadowOffset = CGSize(width: self.ofsetWifth, height: self.ofsetHeight)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.cornerradius).cgPath
        layer.shadowOpacity = Float(ofsetShadow)
        
        
    }
    
    
}
