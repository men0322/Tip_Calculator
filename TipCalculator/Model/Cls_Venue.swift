//
//  Cls_Venue.swift
//  TipCalculator
//
//  Created by hungnguyeniOS on 9/20/16.
//  Copyright © 2016 hungnguyeniOS. All rights reserved.
//

import UIKit

class Cls_Venue: NSObject{
    var name: String = ""
    var imageName: String = ""
    var badPercent : Int = 0
    var goodPercent: Int = 0
    var veryGoodPercent :Int = 0
    
    func getPercentWithServiceType(serviceType:ServiceType) ->Int{
        switch serviceType {
        case .Bad:
            return badPercent
        case .Good:
            return goodPercent
        case .VeryGood:
            return veryGoodPercent
        default:
            return 0
        }
    }
    override init(){

    }
    required  init(coder decoder: NSCoder) {

        if let nameNotNull = decoder.decodeObject(forKey: "name") as? String{
            self.name = nameNotNull
        }
        
        if let imageNameNotNull = (decoder.decodeObject(forKey: "imageName") as? String){
            self.imageName = imageNameNotNull
        }
        self.badPercent = decoder.decodeInteger(forKey: "badPercent")
        self.goodPercent = decoder.decodeInteger(forKey: "goodPercent")
        self.veryGoodPercent = decoder.decodeInteger(forKey: "veryGoodPercent")
        
       
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.imageName, forKey: "imageName")
        coder.encodeCInt(Int32(self.badPercent), forKey: "badPercent")
        coder.encodeCInt(Int32(self.goodPercent), forKey: "goodPercent")
        coder.encodeCInt(Int32(self.veryGoodPercent), forKey: "veryGoodPercent")
    }
    
}
