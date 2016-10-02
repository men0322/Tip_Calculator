//
//  HomeController.swift
//  TipCalculator
//
//  Created by hungnguyeniOS on 9/20/16.
//  Copyright © 2016 hungnguyeniOS. All rights reserved.
//

import UIKit

protocol HomeDelegate{
    func didEndCaculator(tipResult:Cls_Tip)
    func didEndSetClassVenue(venues:[Cls_Venue])
}
class HomeController: NSObject {
      var eventHandler: HomeDelegate?
    
    func calulatorAmount(tip:Cls_Tip){

        tip.tipAmount = tip.totalBill * tip.tipPercent / 100

        tip.totalAmount = tip.totalBill + tip.tipAmount
        
        tip.personAmount = tip.totalAmount / tip.numberPepole
        
        if(self.eventHandler?.didEndCaculator != nil){
            self.eventHandler?.didEndCaculator(tipResult: tip)
        }
    }
    
    func percentUp(tip:Cls_Tip){
        tip.tipPercent =  tip.tipPercent + 1
        self.calulatorAmount(tip: tip)
    }
    
    func percentDown(tip:Cls_Tip){
        if(tip.tipPercent == 0){
            return
        }
        tip.tipPercent = tip.tipPercent - 1
        self.calulatorAmount(tip: tip)
    }
    
    func numberPepoleUp(tip:Cls_Tip){
        tip.numberPepole = tip.numberPepole + 1
        self.calulatorAmount(tip: tip)
    }
    
    func numberPepoleDown(tip:Cls_Tip){
        if(tip.numberPepole == 1){
            return
        }
        tip.numberPepole = tip.numberPepole - 1
        self.calulatorAmount(tip: tip)
    }
    
    func createListVenue(){
        var venues  = [Cls_Venue]()
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
        
        if(self.eventHandler?.didEndSetClassVenue != nil){
            self.eventHandler?.didEndSetClassVenue(venues: venues)
        }
        
    }
}


enum ServiceType: Int{
    case Bad      = 1
    case Good     = 2
    case VeryGood = 3
    case None     = 4

}
