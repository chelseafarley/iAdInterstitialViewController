//
//  IAdInterstitialViewController.swift
//  IAdViewControllerSample
//
//  Created by Chelsea Farley on 16/06/15.
//  Copyright (c) 2015 Trip Wire. All rights reserved.
//

import iAd
import UIKit

public class IAdInterstitialViewController : UIViewController, ADInterstitialAdDelegate {
    var interstitialAd : ADInterstitialAd!
    var interstitialAdView : UIView!
    var closeButton : UIButton!
    
    override public func viewDidLoad()
    {
        super.viewDidLoad()
        
        // any viewDidLoad logic you have
        
        closeButton = UIButton.buttonWithType(UIButtonType.System)
            as! UIButton
        closeButton.frame = CGRectMake(self.view.frame.width - 42,
            10, 32, 32)
        closeButton.layer.cornerRadius = 16
        
        // Note: I have an image asset named "Close"
        // You will need to add one for this to work
        var closeImage = UIImage(named: "Close")
        closeButton.backgroundColor = UIColor.whiteColor()
        closeButton.tintColor = UIColor.blackColor()
        closeButton.setImage(closeImage,
            forState: UIControlState.Normal)
        closeButton.addTarget(self, action: "closeAd:",
            forControlEvents: .TouchDown)
    }
    
    func closeAd(sender: UIButton)
    {
        closeButton.removeFromSuperview()
        if ((interstitialAdView) != nil) {
            interstitialAdView.removeFromSuperview()
        }
    }
    
    // call whenever you want to show an ad
    public func showAd()
    {
        interstitialAd = ADInterstitialAd()
        interstitialAd.delegate = self
    }
    
    public func interstitialAdDidLoad(interstitialAd: ADInterstitialAd!)
    {
        interstitialAdView = UIView()
        interstitialAdView.frame = self.view.bounds
        self.view.addSubview(interstitialAdView)
        
        interstitialAd.presentInView(interstitialAdView)
        UIViewController.prepareInterstitialAds()
        
        interstitialAdView.addSubview(closeButton)
    }
    
    public func interstitialAdDidUnload(interstitialAd: ADInterstitialAd!)
    {
        closeAd(closeButton)
    }
    
    // can do things with the error if you want to... I chose not to
    public func interstitialAd(interstitialAd: ADInterstitialAd!,
        didFailWithError error: NSError!)
    {
        closeAd(closeButton)
    }
}
