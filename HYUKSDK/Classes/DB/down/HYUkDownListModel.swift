//
//  HYUkDownListModel.swift
//  AFNetworking
//
//  Created by Ocean 李 on 2023/5/14.
//

import Foundation
import WCDBSwift
import YYKit

@objcMembers public class HYUkDownListModel: NSObject, TableCodable {

    public var video_id: Int = 0
    public var type_id_1: Int = 0
    public var vod_name: String = ""
    public var vod_pic: String = ""
    public var status: Int = 0
    public var vod_year: String = ""
    public var vod_area: String = ""
    public var create_Time: Int = 0


    
    public enum CodingKeys: String, CodingTableKey {
        public typealias Root = HYUkDownListModel
        public static let objectRelationalMapping = TableBinding(CodingKeys.self)
       
        case video_id
        case type_id_1
        case vod_name
        case vod_pic
        case vod_year
        case vod_area
        case status
        case create_Time


        public static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                video_id: ColumnConstraintBinding(isPrimary: true),
                type_id_1: ColumnConstraintBinding(defaultTo: 0),
                vod_name: ColumnConstraintBinding(defaultTo: ""),
                vod_pic: ColumnConstraintBinding(defaultTo: ""),
                vod_year: ColumnConstraintBinding(defaultTo: ""),
                vod_area: ColumnConstraintBinding(defaultTo: ""),
                status: ColumnConstraintBinding(defaultTo: 0),
                create_Time: ColumnConstraintBinding(defaultTo: 0),
            ]
        }
    }
    
    public required override init() {}
}
