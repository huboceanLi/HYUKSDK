//
//  HYVideoCollectionLogic.swift
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/8.
//

import Foundation

@objcMembers public class HYVideoCollectionLogic: NSObject {
    
    static public let share = HYVideoCollectionLogic()
    
    public func clearData() {
        HYUkCollectionDao.default.clearData()
    }
    
    public func queryCollectionList(createTime: Int) -> [HYUkCollectionModel] {
        let models = HYUkCollectionDao.default.queryCollectionList(createTime: createTime)
        
        return models
    }

    public func queryAppointCollection(videoId: Int) -> HYUkCollectionModel? {
        let models = HYUkCollectionDao.default.queryAppointCollection(videoId: videoId)
        if models.count > 0 {
            return models.first
        }
        return nil
    }
    
    public func insertCollectionList(list: [HYUkCollectionModel]) {
        HYUkCollectionDao.default.insertCollectionList(list: list)
    }
    
    public func removeAppointCollection(videoId: Int) {
        HYUkCollectionDao.default.removeAppointCollection(videoId: videoId)
    }
}
