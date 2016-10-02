//
//  Cls_Venue.swift
//  TipCalculator
//
//  Created by hungnguyeniOS on 9/20/16.
//  Copyright © 2016 hungnguyeniOS. All rights reserved.
//

import UIKit

class Cls_Venue: NSObject {
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
    
}
