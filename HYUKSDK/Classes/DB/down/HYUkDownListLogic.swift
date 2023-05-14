//
//  HYUkDownListLogic.swift
//  AFNetworking
//
//  Created by Ocean 李 on 2023/5/14.
//

import Foundation

@objcMembers public class HYUkDownListLogic: NSObject {
    
    static public let share = HYUkDownListLogic()
    
    public func insertDownList(model: HYUkDownListModel) {
        HYUkDownListDao.default.insertDownList(list: [model])
    }

    public func queryDownList(createTime: Int, isComplete: Bool) -> [HYUkDownListModel] {
        var models: [HYUkDownListModel] = []
        
        if isComplete {
            models.append(contentsOf: HYUkDownListDao.default.queryDownCompleteList(createTime: createTime))
        }else {
            models.append(contentsOf: HYUkDownListDao.default.queryDownProgressList(createTime: createTime))
        }
        return models
    }
    
    public func queryAppointDown(primaryId: String) -> Bool {
        let models = HYUkDownListDao.default.queryAppointDown(primaryId: primaryId)
        if models.count > 0 {
            return true
        }
        return false
    }
}
