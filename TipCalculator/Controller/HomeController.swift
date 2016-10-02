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
    //func didEndSetClassVenue(venues:[Cls_Venue])
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
        if(tip.tipPercent == 100){
            return
        }
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
    
  
}


enum ServiceType: Int{
    case Bad      = 1
    case Good     = 2
    case VeryGood = 3
    case None     = 4

}
