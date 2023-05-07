//
//  HYVideoSearchLogic.swift
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/6.
//

import Foundation

@objcMembers public class HYVideoSearchLogic: NSObject {
    
    static public let share = HYVideoSearchLogic()
    

    
    public func insertMovieList(model: HYUkSearchKeyModel) {
        

    }

    public func clearData() {
        HYUkSearchKeyDao.default.clearData()
    }
}
