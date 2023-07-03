//
//  HYUKNoticeListDao.swift
//  AFNetworking
//
//  Created by Ocean 李 on 2023/7/1.
//

import Foundation
import WCDBSwift

private let HY_MOIVE_NORICE_TABLE_NAME = "HY_MOIVE_NORICE_TABLE_NAME"

struct HYUKNoticeListDao {
    
    static var `default` = HYUKNoticeListDao()
    
    func createTable(database: Database) {
        try? database.create(table: HY_MOIVE_NORICE_TABLE_NAME, of: HYUKNoticeListModel.self)
    }
    
    func insertNoticeList(list: [HYUKNoticeListModel]) {
        
        guard let database = HYVideoDataBaseTool.default.base else {
            return
        }
        
        if list.count == 0 {
            return
        }
        do {
            try database.insertOrReplace(objects: list, intoTable: HY_MOIVE_NORICE_TABLE_NAME)
        } catch  {
            print("Collection insertMovieList error: \(error)")
        }
    }
    
    func getUnReadCount() -> Int {
        guard let database = HYVideoDataBaseTool.default.base else {
            return 0
        }
        let condion: Condition = HYUKNoticeListModel.Properties.isRead == 0
        let result: [HYUKNoticeListModel]? = try? database.getObjects(fromTable: HY_MOIVE_NORICE_TABLE_NAME, where: condion)
        if let r = result {
            return r.count
        }
        return 0
    }
    
    func queryNoticeList() -> [HYUKNoticeListModel] {
        guard let database = HYVideoDataBaseTool.default.base else {
            return []
        }
        let result: [HYUKNoticeListModel]? = try? database.getObjects(fromTable: HY_MOIVE_NORICE_TABLE_NAME, orderBy: [HYUKNoticeListModel.Properties.created_time.asOrder(by: .descending)])

        if let r = result {
            return r
        }
        return []
    }
    
    func queryNoticeMaxTime() -> Int {
        guard let database = HYVideoDataBaseTool.default.base else {
            return 0
        }
//        let condion: Condition = HYUKNoticeListModel.Properties.created_time > time

        let result: [HYUKNoticeListModel]? = try? database.getObjects(fromTable: HY_MOIVE_NORICE_TABLE_NAME, orderBy: [HYUKNoticeListModel.Properties.created_time.asOrder(by: .descending)], limit: 1)

        if let r = result {
            return r.first?.created_time ?? 0
        }
        return 0
    }
    
    func markIsRead(ID: Int, complete:() -> Void) {
        guard let database = HYVideoDataBaseTool.default.base else {
            return
        }
        
        let msgEntity = HYUKNoticeListModel()
        msgEntity.isRead = 1
        
        do {
            try database.update(table: HY_MOIVE_NORICE_TABLE_NAME, on: HYUKNoticeListModel.Properties.isRead, with: msgEntity, where: HYUKNoticeListModel.Properties.ID == ID)
            complete()
        } catch  {
            print("markIsRead error: \(error)")
        }
    }
    
    func markAllIsRead(complete:() -> Void) {
        guard let database = HYVideoDataBaseTool.default.base else {
            return
        }
        
        let msgEntity = HYUKNoticeListModel()
        msgEntity.isRead = 1
        
        do {
            try database.update(table: HY_MOIVE_NORICE_TABLE_NAME, on: HYUKNoticeListModel.Properties.isRead, with: msgEntity, where: HYUKNoticeListModel.Properties.isRead == 0)
            complete()
        } catch  {
            print("markAllIsRead error: \(error)")
        }
    }
}
