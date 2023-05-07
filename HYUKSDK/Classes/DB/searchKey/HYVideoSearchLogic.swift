//
//  HYVideoSearchLogic.swift
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/6.
//

import Foundation

@objcMembers public class HYVideoSearchLogic: NSObject {
    
    static public let share = HYVideoSearchLogic()
    

    
    public func insertMovieList(name: String) {
        let model = HYUkSearchKeyModel()
        model.name = name
        let t = Int(HYUkConfigManager.sharedInstance().getNowTimeTimestamp())
        model.create_Time = t ?? 0
        HYUkSearchKeyDao.default.insertMovieList(model: model)
    }

    public func clearData() {
        HYUkSearchKeyDao.default.clearData()
    }
    
    public func querySearchList() -> [String] {
        let models = HYUkSearchKeyDao.default.querySearchList()
        var keys: [String] = []
        
        for item in models {
            keys.append(item.name)
        }
        return keys
    }
}
