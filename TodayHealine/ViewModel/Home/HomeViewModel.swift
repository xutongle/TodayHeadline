//
//  HomeViewModel.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/24.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import ObjectMapper
import PromiseKit

class HomeViewModel {
    lazy var banners: [Banner] = [Banner]()
    
}

extension HomeViewModel {
    func loadBanner(finished: @escaping (Void) -> Void) {
        let para = ["app_id": "com.jzyd.BanTang",
                    "app_installtime": "1482905598",
                    "app_versions": "5.9.5",
                    "channel_name": "appStore",
                    "client_id": "bt_app_ios",
                    "client_secret": "9c1e6634ce1c5098e056628cd66a17a5",
                    "oauth_token": "4150e754a624ecdc255ad1d13f6287bc",
                    //"last_get_time":"1463238932",
            
            "os_versions": "10.2",
            "screensize": "750",
            "track_device_info": "iPhone8,4",
            "track_device_uuid": "DE964894-8C6F-48BF-9F6C-A47167353EAC",
            "track_deviceid": "BAEA9AD2-16E3-4D12-8E28-4EB9F15A1412",
            "track_user_id": "2777434",
            "v": "24",
            "page": "0",
            "pagesize": "20"
        ]
        
        let req: Promise<BannerGroup> = RequstManager.requst("http://open3.bantangapp.com/recommend/operationElement?", param: para)
        req.then { group -> Void in
            if let banners = group.banner {
                self.banners = banners
                finished()
            }
        }.catch { erro in
            print(erro)
        }
    }
}

fileprivate class BannerGroup: Model {
    var banner: [Banner]?
    fileprivate  override func mapping(map: Map) {
        banner <- map["banner"]
    }
}
