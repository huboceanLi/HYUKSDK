//
//  HYUkDownListDao.swift
//  AFNetworking
//
//  Created by Ocean 李 on 2023/5/14.
//

import Foundation
import WCDBSwift

private let HY_MOIVE_DOWN_TABLE_NAME = "HY_MOIVE_DOWN_TABLE_NAME"

struct HYUkDownListDao {
    
    static var `default` = HYUkDownListDao()
    
    func createTable(database: Database) {
        try? database.create(table: HY_MOIVE_DOWN_TABLE_NAME, of: HYUkDownListModel.self)
    }
    
    func insertDownList(list: [HYUkDownListModel]) {
        
        guard let database = HYVideoDataBaseTool.default.base else {
            return
        }
        
        if list.count == 0 {
            return
        }
        do {
            try database.insert(objects: list, intoTable: HY_MOIVE_DOWN_TABLE_NAME)
        } catch  {
            print("Collection insertMovieList error: \(error)")
        }
    }

    func clearData() {
        guard let database = HYVideoDataBaseTool.default.base else {
            return
        }
        
        do {
            try database.delete(fromTable: HY_MOIVE_DOWN_TABLE_NAME)
        } catch  {
            print("HYUkSearchKeyModel error: \(error)")
        }
    }
    
    func removeAppointDown(videoId: Int) {
        guard let database = HYVideoDataBaseTool.default.base else {
            return
        }
        let condion: Condition = HYUkDownListModel.Properties.video_id == videoId

        do {
            try database.delete(fromTable: HY_MOIVE_DOWN_TABLE_NAME, where: condion)
        } catch  {
            print("removeAppointCollection error: \(error)")
        }
    }
    
//    func queryAppointCollection(videoId: Int) -> [HYUkCollectionModel] {
//
//        guard let database = HYVideoDataBaseTool.default.base else {
//            return []
//        }
//
//        let condion: Condition = HYUkCollectionModel.Properties.video_id == videoId
//        let result: [HYUkCollectionModel]? = try? database.getObjects(fromTable: HY_MOIVE_COLLECTION_TABLE_NAME, where: condion)
//        if let r = result {
//            return r
//        }
//        return []
//    }
    
//    func queryCollectionList(createTime: Int) -> [HYUkCollectionModel] {
//        guard let database = HYVideoDataBaseTool.default.base else {
//            return []
//        }
//
//        let condion: Condition = HYUkCollectionModel.Properties.create_Time < createTime
//
//        let result: [HYUkCollectionModel]? = try? database.getObjects(fromTable: HY_MOIVE_COLLECTION_TABLE_NAME, where: condion, orderBy: [HYUkCollectionModel.Properties.create_Time.asOrder(by: .descending)], limit: 20)
//
//        if let r = result {
//            return r
//        }
//        return []
//    }
}
