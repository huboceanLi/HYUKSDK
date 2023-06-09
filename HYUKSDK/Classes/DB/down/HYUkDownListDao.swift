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
    
    func deleteAll(status: Int) {
        guard let database = HYVideoDataBaseTool.default.base else {
            return
        }
        let condion: Condition = HYUkDownListModel.Properties.status == status

        do {
            try database.delete(fromTable: HY_MOIVE_DOWN_TABLE_NAME, where: condion)
        } catch  {
            print("deleteAll error: \(error)")
        }
    }
    
    func removeAppointDown(primaryId: String) {
        guard let database = HYVideoDataBaseTool.default.base else {
            return
        }
        let condion: Condition = HYUkDownListModel.Properties.primary_Id == primaryId

        do {
            try database.delete(fromTable: HY_MOIVE_DOWN_TABLE_NAME, where: condion)
        } catch  {
            print("removeAppointDown error: \(error)")
        }
    }
    
    func queryAppointDown(primaryId: String) -> [HYUkDownListModel] {

        guard let database = HYVideoDataBaseTool.default.base else {
            return []
        }

        let condion: Condition = HYUkDownListModel.Properties.primary_Id == primaryId
        let result: [HYUkDownListModel]? = try? database.getObjects(fromTable: HY_MOIVE_DOWN_TABLE_NAME, where: condion)
        if let r = result {
            return r
        }
        return []
    }
    
    func queryDownCompleteList(createTime: Int) -> [HYUkDownListModel] {
        guard let database = HYVideoDataBaseTool.default.base else {
            return []
        }

        let condion: Condition = HYUkDownListModel.Properties.create_Time < createTime && HYUkDownListModel.Properties.status == 0

        let result: [HYUkDownListModel]? = try? database.getObjects(fromTable: HY_MOIVE_DOWN_TABLE_NAME, where: condion, orderBy: [HYUkDownListModel.Properties.create_Time.asOrder(by: .descending)])

        if let r = result {
            return r
        }
        return []
    }
    
    func queryDownAllList() -> [HYUkDownListModel] {
        guard let database = HYVideoDataBaseTool.default.base else {
            return []
        }

        let result: [HYUkDownListModel]? = try? database.getObjects(fromTable: HY_MOIVE_DOWN_TABLE_NAME, orderBy: [HYUkDownListModel.Properties.create_Time.asOrder(by: .descending)])

        if let r = result {
            return r
        }
        return []
    }
    func queryDownProgressList(createTime: Int) -> [HYUkDownListModel] {
        guard let database = HYVideoDataBaseTool.default.base else {
            return []
        }

        let condion: Condition = HYUkDownListModel.Properties.create_Time < createTime && HYUkDownListModel.Properties.status != 0

        let result: [HYUkDownListModel]? = try? database.getObjects(fromTable: HY_MOIVE_DOWN_TABLE_NAME, where: condion, orderBy: [HYUkDownListModel.Properties.create_Time.asOrder(by: .descending)])

        if let r = result {
            return r
        }
        return []
    }

    func updateDownProgress(primaryId: String, progress: Int) {
        guard let database = HYVideoDataBaseTool.default.base else {
            return
        }

        
        let msgEntity = HYUkDownListModel()
        msgEntity.progress = progress
        
        do {
            try database.update(table: HY_MOIVE_DOWN_TABLE_NAME, on: HYUkDownListModel.Properties.progress, with: msgEntity, where: HYUkDownListModel.Properties.primary_Id == primaryId)
        } catch  {
            print("updateDownProgress error: \(error)")
        }
        
    }
    
    func updateDownStatus(primaryId: String) {
        guard let database = HYVideoDataBaseTool.default.base else {
            return
        }

        
        let msgEntity = HYUkDownListModel()
        msgEntity.status = 1
        
        do {
            try database.update(table: HY_MOIVE_DOWN_TABLE_NAME, on: HYUkDownListModel.Properties.status, with: msgEntity, where: HYUkDownListModel.Properties.primary_Id == primaryId)
        } catch  {
            print("updateDownStatus error: \(error)")
        }
    }
}
