//
//  HomeViewController.swift
//  TipCalculator
//
//  Created by hungnguyeniOS on 9/20/16.
//  Copyright © 2016 hungnguyeniOS. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,HomeDelegate ,UITextFieldDelegate{
    //MARK: - HOME DELEGATE
    internal func didEndCaculator(tipResult: Cls_Tip) {
         self.fillDataWithTip(tip: tipResult)
    }
    
    internal func didEndSetClassVenue(venues: [Cls_Venue]) {
        self.drawScrollView(venues: venues)
        self.venues = venues
    }


    @IBOutlet weak var tfInputAmount: UITextField!
    @IBOutlet weak var venueScrollView: UIScrollView!
    
    //LABLE
    @IBOutlet weak var lblTipAmount: UILabel!
    @IBOutlet weak var lblTipEachPerson: UILabel!
    @IBOutlet weak var lblTipPercent: UILabel!
    @IBOutlet weak var lblNumberPepole: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    
    //IMAGE
    @IBOutlet weak var imgBad: UIImageView!
    @IBOutlet weak var imgGood: UIImageView!
    @IBOutlet weak var imgVeryGood: UIImageView!
    
    
    //
    var homeController = HomeController()
    var serviceType : ServiceType = ServiceType.None
    var venues  = [Cls_Venue]()
    var clsTip: Cls_Tip = Cls_Tip()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var previousBtn = UIButton()
    var currentVenue: Cls_Venue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLayout()
        self.createObjective()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func hideKeyboardAmount(sender: UITapGestureRecognizer){
        tfInputAmount.resignFirstResponder()
    }
    
    func createObjective(){
        let tapper = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.hideKeyboardAmount(sender:)))
        view.addGestureRecognizer(tapper)
        
        homeController.eventHandler = self
        
        tfInputAmount.delegate = self
        
        homeController.createListVenue()
    }
    private func initLayout(){
        tfInputAmount.attributedPlaceholder = NSAttributedString(string:"Tap to enter your bill amount",
                                                                             attributes:[NSForegroundColorAttributeName: UIColor.white])
    }
    
    
    private func fillDataWithTip(tip:Cls_Tip){
        lblTipAmount.text = "$\(tip.tipAmount)"
        lblTipEachPerson.text = "$\(tip.personAmount)"
        lblTipPercent.text = "\(tip.tipPercent)%"
        lblNumberPepole.text = "\(tip.numberPepole)"
        lblTotalAmount.text = "$\(tip.totalAmount)"
        tfInputAmount.text = "\(tip.totalBill)"
        if(tip.totalBill == 0){
                tfInputAmount.text = ""
        }
    }
    private func resetAllRateServiceImage(){
        imgBad.alpha = 0.5
        imgGood.alpha = 0.5
        imgVeryGood.alpha = 0.5
    }
    private func drawRateService(serviceRating: ServiceType){
        self.resetAllRateServiceImage()
        switch serviceRating {
        case .Bad:
            imgBad.alpha = 1
            break
        case .Good:
            imgGood.alpha = 1
            break
        case .VeryGood:
            imgVeryGood.alpha = 1
            break
            
        default:
            break
        }
        
    
    }
    //MARK: - ADD DATA FOR SCROLLVIEW
    private func drawScrollView(venues: [Cls_Venue]){
         let iconSize:CGFloat = 80.0
        
        let margin: CGFloat = (appDelegate.screenWidth - iconSize * 3.0) / 4
        var totalMargin = margin
        var x :CGFloat = margin
        
        for i in 0...venues.count - 1{
            let venue = venues[i]
            self.venueScrollView.addSubview(self.createViewIconVenue(frame: CGRect(x: x, y: 5, width: iconSize , height : 80), imageName: venue.imageName, tagButton: i))
            x = x +  iconSize + margin
            totalMargin = totalMargin + margin
        }
        
        self.venueScrollView.contentSize = CGSize(width: iconSize * CGFloat(venues.count) + totalMargin , height: 0)
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
        
        return iconVenue
     }
    
    func selectVenue(btn:UIButton){
        previousBtn.backgroundColor = UIColor.clear
        btn.backgroundColor = UIColor(white: 1, alpha: 0.5)
        previousBtn = btn
        if(serviceType == .None){
            serviceType = .Good
            self.drawRateService(serviceRating: serviceType)
        }
        let venue = venues[btn.tag]
        currentVenue = venue
        self.clsTip.tipPercent = venue.getPercentWithServiceType(serviceType: serviceType)
        homeController.calulatorAmount(tip: self.clsTip)
    }
    
    func resetVenueMode(){
        serviceType = .None
        currentVenue = Cls_Venue()
        previousBtn.backgroundColor = UIColor.clear
        self.drawRateService(serviceRating: serviceType)
    }
    //MARK: - ACTION CLICK UP DOWN
    @IBAction func percentUpActionClick(_ sender: AnyObject) {
        
        homeController.percentUp(tip: clsTip)
        self.resetVenueMode()
    }
    
    @IBAction func percentDownActionClick(_ sender: AnyObject) {
        homeController.percentDown(tip: clsTip)
        self.resetVenueMode()
    }
    
    @IBAction func numberPepoleUpActionClick(_ sender: AnyObject) {
        homeController.numberPepoleUp(tip: clsTip)
    }
    
    @IBAction func numberPeopleDownActionClick(_ sender: AnyObject) {
        homeController.numberPepoleDown(tip: clsTip)
    }
    
    //MARK: - ACTION CLICK SERVICE
    @IBAction func rateYourServiceActionClick(_ sender: AnyObject) {
        if let service = ServiceType(rawValue: (sender as! UIButton).tag){
            serviceType = service
            self.drawRateService(serviceRating: serviceType)
            if let venueSelected = currentVenue{
                self.clsTip.tipPercent = venueSelected.getPercentWithServiceType(serviceType: serviceType)
                homeController.calulatorAmount(tip: self.clsTip)
            }
        }
        
    }
    @IBAction func newActionClick(_ sender: AnyObject) {
        clsTip = Cls_Tip()
        fillDataWithTip(tip: clsTip)
        self.resetVenueMode()
    }
    @IBAction func gotoSettingActionClick(_ sender: AnyObject) {
        let settingView = SettingViewController(nibName: "SettingViewController", bundle: nil)
        self.navigationController?.pushViewController(settingView, animated: true)
    }
    //MARK: - TEXTFIELD DELEGATE 
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.clsTip.totalBill = (textField.text! as NSString).integerValue
        homeController.calulatorAmount(tip: self.clsTip)
    }
    
    
    

    
}
