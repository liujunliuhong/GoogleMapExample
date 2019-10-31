//
//  ViewController.swift
//  GoogleMapExample
//
//  Created by apple on 2019/10/31.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation

class ViewController: UIViewController {

    lazy var authorizationButton: UIButton = {
        let authorizationButton = UIButton(type: .system)
        authorizationButton.setTitle("授权", for: .normal)
        authorizationButton.setTitleColor(.white, for: .normal)
        authorizationButton.backgroundColor = .gray
        authorizationButton.addTarget(self, action: #selector(authorization), for: .touchUpInside)
        return authorizationButton
    }()
    
    lazy var locationButton: UIButton = {
        let locationButton = UIButton(type: .system)
        locationButton.setTitle("获取当前地点", for: .normal)
        locationButton.setTitleColor(.white, for: .normal)
        locationButton.backgroundColor = .gray
        locationButton.addTarget(self, action: #selector(getCurrentLocation), for: .touchUpInside)
        return locationButton
    }()
    
    lazy var mapButton: UIButton = {
        let mapButton = UIButton(type: .system)
        mapButton.setTitle("地图", for: .normal)
        mapButton.setTitleColor(.white, for: .normal)
        mapButton.backgroundColor = .gray
        mapButton.addTarget(self, action: #selector(map), for: .touchUpInside)
        return mapButton
    }()
    
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(authorizationButton)
        view.addSubview(locationButton)
        view.addSubview(mapButton)
        
        authorizationButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
        locationButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(authorizationButton.snp_bottom).offset(60)
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
        
        mapButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(locationButton.snp_bottom).offset(60)
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
    }
}


extension ViewController {
    /// 授权
    @objc func authorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    /// 获取当前位置
    @objc func getCurrentLocation() {
        GoogleMapHelper.shared.getCurrentLocation1()
    }
    
    /// 显示地图
    @objc func map() {
        let mapVC = MapViewController()
        let navi = UINavigationController(rootViewController: mapVC)
        navi.modalPresentationStyle = .fullScreen
        present(navi, animated: true, completion: nil)
    }
}


extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("notDetermined")
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
        case .denied:
            print("denied")
        case .restricted:
            print("restricted")
        default:
            print("\(status)")
        }
    }
}
