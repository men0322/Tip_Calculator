//
//  SettingViewController.swift
//  TipCalculator
//
//  Created by HungN on 10/2/16.
//  Copyright © 2016 hungnguyeniOS. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var scrollViewVenue: UIScrollView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var venues  = [Cls_Venue]()
    var previousBtn = UIButton()
    @IBOutlet weak var lblVeryGoodPercent: UILabel!
    @IBOutlet weak var lblGoodPercent: UILabel!
    @IBOutlet weak var lblBadPercent: UILabel!
     var currentVenue: Cls_Venue?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.venues = appDelegate.venueController.venues
        self.drawScrollView(venues: self.venues)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //MARK: - ADD DATA FOR SCROLLVIEW
    private func drawScrollView(venues: [Cls_Venue]){
        let iconSize:CGFloat = 80.0
        
        let margin: CGFloat = (appDelegate.screenWidth - iconSize * 3.0) / 4
        var totalMargin = margin
        var x :CGFloat = margin
        
        for i in 0...venues.count - 1{
            let venue = venues[i]
            self.scrollViewVenue.addSubview(self.createViewIconVenue(frame: CGRect(x: x, y: 5, width: iconSize , height : 80), imageName: venue.imageName, tagButton: i))
            x = x +  iconSize + margin
            totalMargin = totalMargin + margin
        }
        
        self.scrollViewVenue.contentSize = CGSize(width: iconSize * CGFloat(venues.count) + totalMargin , height: 0)
    }
    
    //MARK: - CREATE VIEW ICON VENUE FOR SCROLLVIEW
    private func createViewIconVenue(frame:CGRect,imageName:String,tagButton:Int) -> UIView{
        let iconSize:CGFloat = 80.0
        let iconVenue = UIView(frame: frame)
        
        //Create image
        let iconImage = UIImageView(image: UIImage(named: imageName))
        iconImage.frame = CGRect(x: frame.size.width / 2 - iconSize / 4, y: frame.size.height / 2 - iconSize / 4, width: iconSize / 2, height: iconSize / 2)
        iconVenue.addSubview(iconImage)
        iconImage.alpha = 0.5
        
        iconVenue.layer.cornerRadius = iconSize / 2
        iconVenue.layoutIfNeeded()
        
        iconVenue.layer.borderWidth = 0.5
        iconVenue.layer.borderColor = UIColor(white: 1, alpha: 0.5).cgColor
        
        //Create Button touch
        let iconButton = UIButton(frame: CGRect(x: 0, y: 0, width: iconSize , height : iconSize))
        iconButton.tag = tagButton
        
        iconButton.layer.cornerRadius = iconSize / 2
        iconButton.layoutIfNeeded()
        iconButton.backgroundColor = UIColor.clear
        iconButton.addTarget(self, action: #selector(HomeViewController.selectVenue(btn:)), for: UIControlEvents.touchUpInside)
        iconVenue.addSubview(iconButton)
        //
        if(tagButton == 0){
            self.setDefualtButtonSelected(btn: iconButton)
        }
        
        return iconVenue
    }
    func setDefualtButtonSelected(btn:UIButton){
        previousBtn = btn
        let venue = venues[0]
        currentVenue = venue
        btn.backgroundColor = UIColor(white: 1, alpha: 0.5)
        if let venue = currentVenue{
            self.fillDataSetting(venue: venue)
        }
    }
    func selectVenue(btn:UIButton){
        previousBtn.backgroundColor = UIColor.clear
        btn.backgroundColor = UIColor(white: 1, alpha: 0.5)
        previousBtn = btn
        let venue = venues[btn.tag]
        currentVenue = venue
        if let venue = currentVenue{
            self.fillDataSetting(venue: venue)
        }
        
    }

    func fillDataSetting(venue: Cls_Venue){
        lblBadPercent.text = "$\(venue.badPercent)"
        lblGoodPercent.text = "$\(venue.goodPercent)"
        lblVeryGoodPercent.text = "$\(venue.veryGoodPercent)"
    }
    @IBAction func backActionClick(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func downPercentActionClick(_ sender: AnyObject) {
        let btn = sender as! UIButton
        switch btn.tag {
        case 1:
            if(currentVenue?.badPercent == 0){
                return
            }
            currentVenue?.badPercent = (currentVenue?.badPercent)! - 1
            break
        case 2:
            if(currentVenue?.goodPercent == 0){
                return
            }
            currentVenue?.goodPercent = (currentVenue?.goodPercent)! - 1
            break
        case 3:
            if(currentVenue?.veryGoodPercent == 0){
                return
            }
            currentVenue?.veryGoodPercent = (currentVenue?.veryGoodPercent)! - 1
            break
        default:
            break
        }
        
        if let venue = currentVenue{
            self.fillDataSetting(venue: venue)
        }
    }

    @IBAction func upPercentActionClick(_ sender: AnyObject) {
        let btn = sender as! UIButton
        switch btn.tag {
        case 1:
            if(currentVenue?.badPercent == 100){
                return
            }
            currentVenue?.badPercent = (currentVenue?.badPercent)! + 1
            
            break
        case 2:
            if(currentVenue?.goodPercent == 100){
                return
            }
            currentVenue?.goodPercent = (currentVenue?.goodPercent)! + 1
            break
        case 3:
            if(currentVenue?.veryGoodPercent == 100){
                return
            }
            currentVenue?.veryGoodPercent = (currentVenue?.veryGoodPercent)! + 1
            break
        default:
            break
        }
        
        if let venue = currentVenue{
            self.fillDataSetting(venue: venue)
        }
    }
}
