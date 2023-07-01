//
//  HYVideoDataBaseTool.swift
//  VideoDBFramework
//
//  Created by oceanMAC on 2023/4/19.
//

import Foundation
import WCDBSwift

let TM_USER_DATABASE_FLODER_NAME = "Database"

class HYVideoDataBaseTool : NSObject {
    
    static var `default` = HYVideoDataBaseTool()
    
    private static let QUERY_LIMIT = 900
    
    var base: Database?
    
    func getDB() -> Database? {
        return base
    }
    
    func initDB(userID: String) {
        
        guard let dbBase = self.getDatabase(userId: userID) else {
            return
        }
        self.base = dbBase
        HYUkCollectionDao.default.createTable(database: dbBase)
        HYUkSearchKeyDao.default.createTable(database: dbBase)
        HYUkHistoryRecordDao.default.createTable(database: dbBase)
        HYUkDownListDao.default.createTable(database: dbBase)
        HYUKNoticeListDao.default.createTable(database: dbBase)
    }
    
    // MARK: -
    /// Get the storage path of  TM database folder
    private func getDatabasePath() -> String? {
        
        let path = HYLocalPathManager.funVideoRootPath("DB")
        let createDbPath = HYLocalPathManager.createPath(path)
        
        if createDbPath {
            print("Database Folder Path: \(path)")
            return path
        }
        return nil
//        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
//        guard let path = documentPath else {
//            return ""
//        }
//
//        let dirPath = path + "/" + TM_USER_DATABASE_FLODER_NAME
//        print("Database Folder Path: \(dirPath)")
//        return dirPath
    }
    
    /// Get a database with userID,  one user one database
    func getDatabase(userId: String) -> Database? {
        if let dbPath = self.getDatabasePath() {
            let userDBPath = dbPath + "/" + userId + ".db"
            let database = Database(withPath: userDBPath)
            return database
        }
        return nil
    }
    
}
