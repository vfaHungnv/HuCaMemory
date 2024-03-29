//
//  GoogleAdMobHelper.swift
//  HuCaMemory
//
//  Created by HungNV on 12/15/19.
//  Copyright © 2019 hungnv. All rights reserved.
//

import UIKit
import GoogleMobileAds

struct GoogleAdsUnitID {
    struct Test {
        static var strBannerAdsID = "ca-app-pub-3940256099942544/2934735716"
        static var strInterstitialAdsID = "ca-app-pub-3940256099942544/4411468910"
    }
    
    struct Live {
        static var strBannerAdsID = "ca-app-pub-8391716737248301/3595481925"
        static var strInterstitialAdsID = "ca-app-pub-8391716737248301/6465187846"
    }
}

struct BannerViewSize {
    static var screenWidth: CGFloat = UIScreen.main.bounds.size.width
//    static var screenHeight: CGFloat = 64 //Top
    static var screenHeight: CGFloat = UIScreen.main.bounds.size.height //Bottom
    static var height: CGFloat = CGFloat(UIDevice.current.userInterfaceIdiom == .pad ? 90 : 50)
}

class GoogleAdMobHelper: NSObject, GADInterstitialDelegate, GADBannerViewDelegate {
    static let shared: GoogleAdMobHelper = {
        let instance = GoogleAdMobHelper()
        return instance
    }()
    
    private var isBannerViewDisplay = false
    private var isInitializeBannerView = false
    private var isInitializeInterstitial = false
    private var isBannerLiveID = false
    private var isInterstitialLiveID = false
    private var interstitialAds: GADInterstitial!
    private var bannerView: GADBannerView!
    
    func initializeBannerView(isLiveUnitID: Bool) {
        self.isInitializeBannerView = true
        self.isBannerLiveID = isLiveUnitID
        self.createBannerView()
    }
    
    @objc private func createBannerView() {
        if UIApplication.shared.keyWindow?.rootViewController == nil {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(createBannerView), object: nil)
            self.perform(#selector(createBannerView), with: nil, afterDelay: 0.5)
        } else {
            isBannerViewDisplay = true
            bannerView = GADBannerView(frame: CGRect(x: 0, y: -(BannerViewSize.screenHeight), width: BannerViewSize.screenWidth, height: BannerViewSize.height))
            if self.isBannerLiveID == false {
                self.bannerView.adUnitID = GoogleAdsUnitID.Test.strBannerAdsID
            } else {
                self.bannerView.adUnitID = GoogleAdsUnitID.Live.strBannerAdsID
            }
            
            self.bannerView.rootViewController = UIApplication.shared.keyWindow?.rootViewController
            self.bannerView.delegate = self
            self.bannerView.backgroundColor = .gray
            self.bannerView.load(GADRequest())
            UIApplication.shared.keyWindow?.addSubview(bannerView)
        }
    }
    
    //MARK:- Show/Hide banner view
    func showBannerView() {
        isBannerViewDisplay = true
        if isInitializeBannerView == false {
            #if DEBUG
                print("First initalize banner view")
            #endif
        } else {
            #if DEBUG
                print("isBannerViewCreate: true")
            #endif
            /* UIView.animate(withDuration: 0.3, animations: {
                self.bannerView.frame = CGRect(x: 0, y: BannerViewSize.screenHeight, width: BannerViewSize.screenWidth, height: BannerViewSize.height)
            })*/ //Top
            
            self.bannerView.frame = CGRect(x: 0, y: (BannerViewSize.screenHeight - 100), width: BannerViewSize.screenWidth, height: BannerViewSize.height) //Bottom
        }
    }
    
    func hideBannerView() {
        isBannerViewDisplay = false
        if self.bannerView != nil {
            /* UIView.animate(withDuration: 0.3, animations: {
                 self.bannerView.frame = CGRect(x: 0, y: -(BannerViewSize.screenHeight), width: BannerViewSize.screenWidth, height: BannerViewSize.height)
             })*/ //Top
            self.bannerView.frame = CGRect(x: 0, y: (BannerViewSize.screenHeight + 100), width: BannerViewSize.screenWidth, height: BannerViewSize.height) //Bottom
        }
    }
    
    @objc private func showBanner() {
        if self.bannerView != nil && isBannerViewDisplay == true {
            self.bannerView.isHidden = false
        }
    }
    
    private func hideBanner() {
        if self.bannerView != nil {
            self.bannerView.isHidden = true
        }
    }
    
    //MARK:- Create Interstitial Ads
    func initializeInterstitial(isLiveUnitID: Bool) {
        self.isInitializeInterstitial = true
        self.isInterstitialLiveID = isLiveUnitID
        self.createInterstitial()
    }
    
    private func createInterstitial() {
        if self.isInterstitialLiveID == false {
            interstitialAds = GADInterstitial(adUnitID: GoogleAdsUnitID.Test.strInterstitialAdsID)
        } else {
            interstitialAds = GADInterstitial(adUnitID: GoogleAdsUnitID.Live.strInterstitialAdsID)
        }
        
        interstitialAds.delegate = self
        interstitialAds.load(GADRequest())
    }
    
    func showInterstitial() {
        if isInitializeInterstitial == false {
            #if DEBUG
                print("First initalize interstitial")
            #endif
        } else {
            if interstitialAds.isReady {
                interstitialAds.present(fromRootViewController: (UIApplication.shared.keyWindow?.rootViewController)!)
            } else {
                #if DEBUG
                    print("Interstitial not ready")
                #endif
                self.createInterstitial()
            }
        }
    }
    
    //MARK:- GADBannerViewDelegate
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        #if DEBUG
            print("adViewDidReceiveAd")
        #endif
    }
    
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        #if DEBUG
            print("adViewDidDismissScreen")
        #endif
    }
    
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        #if DEBUG
            print("adViewWillDismissScreen")
        #endif
    }
    
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        #if DEBUG
            print("adViewWillPresentScreen")
        #endif
    }
    
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        #if DEBUG
            print("adViewWillLeaveApplication")
        #endif
    }
    
    //MARK:- GADInterstitialDelegate
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        #if DEBUG
            print("interstitialDidReceiveAd")
        #endif
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        #if DEBUG
            print("interstitialDidDismissScreen")
        #endif
        self.createInterstitial()
    }
    
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        #if DEBUG
            print("interstitialWillDismissScreen")
        #endif
        
        //self.showBannerView()
    }
    
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        #if DEBUG
            print("interstitialWillPresentScreen")
        #endif
        //self.hideBannerView()
    }
    
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        #if DEBUG
            print("interstitialWillLeaveApplication")
        #endif
    }
    
    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        #if DEBUG
            print("interstitialDidFail")
        #endif
    }
    
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        #if DEBUG
            print("interstitial")
        #endif
    }
}
