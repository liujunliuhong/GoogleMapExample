//
//  GoogleMapHelper.swift
//  GoogleMapExample
//
//  Created by apple on 2019/10/31.
//  Copyright © 2019 yinhe. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces


public struct GoogleMapHelper {
    public static let shared = GoogleMapHelper()
    
    
    /// 注册
    /// - Parameter key: key
    public func registerGoogleMap(with key: String) {
        GMSServices.provideAPIKey(key)
        GMSPlacesClient.provideAPIKey(key)
    }
    
    
    /// 获取当前位置（方法一）
    /// 获取到的是一个地点集合
    /// 文档:https://developers.google.com/places/ios-sdk/current-place
    public func getCurrentLocation1() {
        let field = (GMSPlaceField.name.rawValue | GMSPlaceField.formattedAddress.rawValue | GMSPlaceField.placeID.rawValue | GMSPlaceField.coordinate.rawValue)
        guard let fields = GMSPlaceField(rawValue: field) else { return }
        
        GMSPlacesClient.shared().findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: fields) { (placeLikelihoodList, error) in
            if let error = error {
                print("error: \(error)")
                return
            }
            
            guard let placeLikelihoodList = placeLikelihoodList else {
                print("placeLikelihoodList is nil.")
                return
            }
            
            for (_, placeLikelihood) in placeLikelihoodList.enumerated() {
                let name = placeLikelihood.place.name ?? ""
                let placeID = placeLikelihood.place.placeID ?? ""
                let formattedAddress = placeLikelihood.place.formattedAddress ?? ""
                let la = placeLikelihood.place.coordinate.latitude
                let lo = placeLikelihood.place.coordinate.longitude
                print("========================================================")
                print("name: \(name)")
                print("placeID: \(placeID)")
                print("formattedAddress: \(formattedAddress)")
                print("la: \(la)")
                print("lo: \(lo)")
                print("========================================================")
            }
        }
    }
    
    /// 获取当前位置（方法二）
    /// 获取到的是一个地点集合
    /// 文档:https://developers.google.com/places/ios-sdk/start
    public func getCurrentLocation2() {
        GMSPlacesClient.shared().currentPlace { (placeLikelihoodList, error) in
            if let error = error {
                print("error: \(error)")
                return
            }
            
            guard let placeLikelihoodList = placeLikelihoodList else {
                print("placeLikelihoodList is nil.")
                return
            }
            
            for (_, placeLikelihood) in placeLikelihoodList.likelihoods.enumerated() {
                let name = placeLikelihood.place.name ?? ""
                let placeID = placeLikelihood.place.placeID ?? ""
                let formattedAddress = placeLikelihood.place.formattedAddress ?? ""
                let la = placeLikelihood.place.coordinate.latitude
                let lo = placeLikelihood.place.coordinate.longitude
                print("========================================================")
                print("name: \(name)")
                print("placeID: \(placeID)")
                print("formattedAddress: \(formattedAddress)")
                print("la: \(la)")
                print("lo: \(lo)")
                print("========================================================")
            }
        }
    }
}
