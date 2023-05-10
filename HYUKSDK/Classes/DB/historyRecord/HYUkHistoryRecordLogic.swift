//
//  HYUkHistoryRecordLogic.swift
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/10.
//

import Foundation

@objcMembers public class HYUkHistoryRecordLogic: NSObject {
    
    static public let share = HYUkHistoryRecordLogic()
    
    public func clearData() {
        HYUkHistoryRecordDao.default.clearData()
    }
    
    public func queryHistoryRecordList(createTime: Int, count: Int) -> [HYUkHistoryRecordModel] {
        let models = HYUkHistoryRecordDao.default.queryHistoryRecordList(createTime: createTime, count: count)
        return models
    }

    public func insertHistoryRecord(recordModel: HYUkHistoryRecordModel) {
        HYUkHistoryRecordDao.default.insertHistoryRecord(model: recordModel)
    }

    public func queryAppointRecord(videoId: Int) -> HYUkHistoryRecordModel? {
        let models = HYUkHistoryRecordDao.default.queryAppointRecord(videoId: videoId)
        if models.count > 0 {
            return models.first
        }
        return nil
    }
}
