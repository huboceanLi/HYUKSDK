//
//  HYVideoDBManager.swift
//  HYVideoDB
//
//  Created by oceanMAC on 2023/4/19.
//

import Foundation

@objcMembers public class HYVideoDBLogic: NSObject {
    
    static public let share = HYVideoDBLogic()
    
    public func initDB() {
        HYVideoDataBaseTool.default.initDB(userID: "jkdfhksdfgvsb")
    }
}
