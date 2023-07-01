//
//  HYUKNoticeListModel.swift
//  AFNetworking
//
//  Created by Ocean 李 on 2023/7/1.
//

import Foundation
import WCDBSwift
import YYModel


@objcMembers public class HYUKNoticeListModel: NSObject, TableCodable {

    public var ID: Int?
    public var top_switch: Int = 0
    public var title: String = ""
    public var remark: String = ""
    public var created_time_text: String = ""
    public var created_time: Int = 0
    public var isRead: Int = 0

    
    public enum CodingKeys: String, CodingTableKey {
        public typealias Root = HYUKNoticeListModel
        public static let objectRelationalMapping = TableBinding(CodingKeys.self)
       
        case ID
        case top_switch
        case title
        case remark
        case created_time_text
        case created_time
        case isRead


        public static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                ID: ColumnConstraintBinding(isPrimary: true),
                top_switch: ColumnConstraintBinding(defaultTo: 0),
                title: ColumnConstraintBinding(defaultTo: ""),
                remark: ColumnConstraintBinding(defaultTo: ""),
                created_time_text: ColumnConstraintBinding(defaultTo: ""),
                created_time: ColumnConstraintBinding(defaultTo: 0),
                isRead: ColumnConstraintBinding(defaultTo: 0),
            ]
        }
    }
    
    public required override init() {}
}
