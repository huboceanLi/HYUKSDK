//
//  HYMovieListDao.swift
//  VideoDBFramework
//
//  Created by oceanMAC on 2023/4/19.
//

import Foundation
import WCDBSwift

private let HY_MOIVE_LIST_TABLE_NAME = "HY_MOIVE_LIST_TABLE_NAME"

struct HYMovieListDao {
    
    static var `default` = HYMovieListDao()
    
    func createTable(database: Database) {
        try? database.create(table: HY_MOIVE_LIST_TABLE_NAME, of: HYMovieListModel.self)
    }
    
    func insertMovieList(list: [HYMovieListModel]) {
        
        guard let database = HYVideoDataBaseTool.default.base else {
            return
        }
        
        if list.count == 0 {
            return
        }
        do {
            try database.insert(objects: list, intoTable: HY_MOIVE_LIST_TABLE_NAME)
        } catch  {
            print("HYBookListModel insertBook error: \(error)")
        }
    }

}
