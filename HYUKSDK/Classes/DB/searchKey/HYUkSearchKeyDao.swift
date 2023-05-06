//
//  HYUkSearchKeyDao.swift
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/6.
//

import Foundation
import WCDBSwift

private let HY_MOIVE_SEARCHKEY_TABLE_NAME = "HY_MOIVE_SEARCHKEY_TABLE_NAME"

struct HYUkSearchKeyDao {
    
    static var `default` = HYUkSearchKeyDao()
    
    func createTable(database: Database) {
        try? database.create(table: HY_MOIVE_SEARCHKEY_TABLE_NAME, of: HYUkSearchKeyModel.self)
    }
    
    func insertMovieList(model: HYUkSearchKeyModel) {
        
        guard let database = HYVideoDataBaseTool.default.base else {
            return
        }

        do {
            try database.insertOrReplace(objects: [model], intoTable: HY_MOIVE_SEARCHKEY_TABLE_NAME)
        } catch  {
            print("HYUkSearchKeyModel error: \(error)")
        }
    }

    func clearData() {
        guard let database = HYVideoDataBaseTool.default.base else {
            return
        }
        
        do {
            try database.delete(fromTable: HY_MOIVE_SEARCHKEY_TABLE_NAME)
        } catch  {
            print("HYUkSearchKeyModel error: \(error)")
        }
    }
}
