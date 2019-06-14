//
//  TopView.swift
//  WeatherForecast
//
//  Created by Daisy on 11/06/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

class TopView: UIView {
    
    // 시간설정
//    let dataFormatta: DateFormatter = {
//        let format = DateFormatter()
//        format.locale = Locale(identifier: "ko_kr")
//        format.dateFormat = "a:mm"
//    let time = format.date(from: )
//        return format
//    }()
    
    let locationLabel = UILabel()
    let timeNow = UILabel()
    let refreshButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("↻", for: .normal)
        button.setTitleColor(.black, for: .normal)
    
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addsubView()
        callLocationInfo()
        configure()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addsubView() {
        addSubview(locationLabel)
        addSubview(timeNow)
        addSubview(refreshButton)
    
    }
    

    
    override func layoutSubviews() {
        locationLabel.center.x = center.x
        timeNow.center.x = center.x
    }
    
    private func configure() {
        
        locationLabel.text = ""
        locationLabel.frame = CGRect(x: 0 , y: 0, width: 200, height: 50)
        locationLabel.center.y = self.frame.height + 20
        
        locationLabel.textAlignment = .center
        
        timeNow.text = "파리의 시간을 살아가는중"
        timeNow.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        timeNow.textAlignment = .center
        timeNow.center.y = self.frame.height + 42
        
        refreshButton.addTarget(self, action: #selector(didtapButton(_:)), for: .touchUpInside)
        refreshButton.center.x = frame.width/2
        refreshButton.frame =  CGRect(x: 0, y: 0, width: 200, height: 50)
    
        autolayouts()
    }
    
    private func callLocationInfo() {
        WeatherApiControl.shared.nowTempInfo { (currentLocation, localInfo, sky) in
            DispatchQueue.main.async {
        
                self.locationLabel.text = (localInfo.city ?? "") + " " + (localInfo.county ?? "")
                
            }
        }
    }
    
    private func autolayouts() {
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        let guide = self.safeAreaLayoutGuide
        refreshButton.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        refreshButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        refreshButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        refreshButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    @objc func didtapButton(_ sender: UIButton) {
        print("Button tapped")
    }
    
    
}
