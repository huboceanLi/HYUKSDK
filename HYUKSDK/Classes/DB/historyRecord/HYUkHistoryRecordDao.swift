//
//  HYUkHistoryRecordDao.swift
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/6.
//

import Foundation
import WCDBSwift

private let HY_MOIVE_HISTORY_TABLE_NAME = "HY_MOIVE_HISTORY_TABLE_NAME"

struct HYUkHistoryRecordDao {
    
    static var `default` = HYUkHistoryRecordDao()
    
    func createTable(database: Database) {
        try? database.create(table: HY_MOIVE_HISTORY_TABLE_NAME, of: HYUkHistoryRecordModel.self)
    }
    
    func insertHistoryRecord(model: HYUkHistoryRecordModel) {
        
        guard let database = HYVideoDataBaseTool.default.base else {
            return
        }
        
        do {
            try database.insertOrReplace(objects: [model], intoTable: HY_MOIVE_HISTORY_TABLE_NAME)
        } catch  {
            print("HYUkSearchKeyModel error: \(error)")
        }
    }
    
    func clearData() {
        guard let database = HYVideoDataBaseTool.default.base else {
            return
        }
        
        do {
            try database.delete(fromTable: HY_MOIVE_HISTORY_TABLE_NAME)
        } catch  {
            print("HYUkSearchKeyModel error: \(error)")
        }
    }
    
    func queryAppointRecord(videoId: Int) -> [HYUkHistoryRecordModel] {
        
        guard let database = HYVideoDataBaseTool.default.base else {
            return []
        }
        
        let condion: Condition = HYUkHistoryRecordModel.Properties.tvId == videoId
        let result: [HYUkHistoryRecordModel]? = try? database.getObjects(fromTable: HY_MOIVE_HISTORY_TABLE_NAME, where: condion)
        if let r = result {
            return r
        }
        return []
    }
    
    func queryHistoryRecordList(createTime: Int, count: Int) -> [HYUkHistoryRecordModel] {
        guard let database = HYVideoDataBaseTool.default.base else {
            return []
        }
        
        let condion: Condition = HYUkHistoryRecordModel.Properties.create_Time < createTime

        let result: [HYUkHistoryRecordModel]? = try? database.getObjects(fromTable: HY_MOIVE_HISTORY_TABLE_NAME, where: condion, orderBy: [HYUkHistoryRecordModel.Properties.create_Time.asOrder(by: .descending)], limit: count)

        if let r = result {
            return r
        }
        return []
    }
}
