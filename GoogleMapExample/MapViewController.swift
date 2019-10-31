//
//  MapViewController.swift
//  GoogleMapExample
//
//  Created by apple on 2019/10/31.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit
import GoogleMaps
import SnapKit

class MapViewController: UIViewController {

    lazy var mapView: GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.isTrafficEnabled = true
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "地图"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancel))
        
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.size.height+44)
        }
    }
}

extension MapViewController {
    @objc
    func cancel() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
