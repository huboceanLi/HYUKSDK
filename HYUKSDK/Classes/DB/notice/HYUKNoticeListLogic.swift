//
//  HYUKNoticeListLogic.swift
//  AFNetworking
//
//  Created by Ocean 李 on 2023/7/1.
//

import Foundation
import YYModel

@objcMembers public class HYUKNoticeListLogic: NSObject {
    
    static public let share = HYUKNoticeListLogic()
    

    public func insertNoticeList(list: [HYUKResponseNoticeItemModel]) {
        
        var l : [HYUKNoticeListModel] = []
        
        for item in list {
            
            let jsonStr = item.yy_modelToJSONString()
            if let m = HYUKNoticeListModel.yy_model(withJSON: jsonStr ?? "") {
                l.append(m)
            }
        }
        
        HYUKNoticeListDao.default.insertNoticeList(list: l)
        
    }
    
    public func getUnReadCount() -> Int {
        return HYUKNoticeListDao.default.getUnReadCount()
    }
    
    public func queryNoticeList() -> [HYUKResponseNoticeItemModel] {
        let q =  HYUKNoticeListDao.default.queryNoticeList()
        var l : [HYUKResponseNoticeItemModel] = []
        for item in q {
            let jsonStr = item.yy_modelToJSONString()
            if let m = HYUKResponseNoticeItemModel.yy_model(withJSON: jsonStr ?? "") {
                l.append(m)
            }
        }
        return l
    }
    
    public func markIsRead(ID: Int, complete:() -> Void) {
        HYUKNoticeListDao.default.markIsRead(ID: ID, complete: complete)
    }
    
    public func markAllIsRead(complete:() -> Void) {
        HYUKNoticeListDao.default.markAllIsRead(complete: complete)
    }
}
