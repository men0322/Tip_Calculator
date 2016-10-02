//
//  VenueController.swift
//  TipCalculator
//
//  Created by HungN on 10/2/16.
//  Copyright © 2016 hungnguyeniOS. All rights reserved.
//

import UIKit
protocol VenueDelegate{
    func didEndSetClassVenue(venues:[Cls_Venue])
}
class VenueController: NSObject {
    var eventHandler: VenueDelegate?
    var venues  = [Cls_Venue]()
    func createListVenue(){
        
        for i in 0...5{
            let clasVenue = Cls_Venue()
            switch i {
            case 0:
                clasVenue.name = "Bar"
                clasVenue.imageName = "venue_bar"
                clasVenue.badPercent = 5
                clasVenue.goodPercent = 10
                clasVenue.veryGoodPercent = 15
                break
            case 1:
                clasVenue.name = "Coffee"
                clasVenue.imageName = "venue_coffee"
                clasVenue.badPercent = 10
                clasVenue.goodPercent = 15
                clasVenue.veryGoodPercent = 20
                break
            case 2:
                clasVenue.name = "Dining"
                clasVenue.imageName = "venue_eat"
                clasVenue.badPercent = 15
                clasVenue.goodPercent = 20
                clasVenue.veryGoodPercent = 25
                break
            case 3:
                clasVenue.name = "Parking"
                clasVenue.imageName = "venue_parking"
                clasVenue.badPercent = 5
                clasVenue.goodPercent = 10
                clasVenue.veryGoodPercent = 15
                break
            case 4:
                clasVenue.name = "Delivery"
                clasVenue.imageName = "venue_pizza"
                clasVenue.badPercent = 10
                clasVenue.goodPercent = 15
                clasVenue.veryGoodPercent = 20
                break
            case 5:
                clasVenue.name = "Taxi"
                clasVenue.imageName = "venue_taxi"
                clasVenue.badPercent = 5
                clasVenue.goodPercent = 10
                clasVenue.veryGoodPercent = 15
                break
            default:
                break
            }
            
            venues.append(clasVenue)
        }
        
      
        
    }
    
    func getListVenue(){
        if let data = UserDefaults.standard.object(forKey: "venues") as? NSData
        {
            venues = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Cls_Venue]
        }else{
            self.createListVenue()
        }
        
        if(self.eventHandler?.didEndSetClassVenue != nil){
            self.eventHandler?.didEndSetClassVenue(venues: venues)
        }
    }
    
    
    
    func saveVenue(){
        let data  = NSKeyedArchiver.archivedData(withRootObject: venues)
        let defaults = UserDefaults.standard
        defaults.set(data, forKey:"venues" )
    }
    
    
}
