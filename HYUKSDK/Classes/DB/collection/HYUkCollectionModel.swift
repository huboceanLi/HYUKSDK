//
//  HYUkCollectionModel.swift
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/6.
//

import Foundation
import WCDBSwift
import YYKit

@objcMembers public class HYUkCollectionModel: NSObject, TableCodable {

    public var video_id: Int = 0
    public var type_id_1: Int = 0
    public var vod_name: String = ""
    public var vod_pic: String = ""
    public var vod_year: String = ""
    public var vod_area: String = ""
    public var vod_class: String = ""
    public var vod_remarks: String = ""
    public var create_Time: Int = 0


    
    public enum CodingKeys: String, CodingTableKey {
        public typealias Root = HYUkCollectionModel
        public static let objectRelationalMapping = TableBinding(CodingKeys.self)
       
        case video_id
        case type_id_1
        case vod_name
        case vod_pic
        case vod_year
        case vod_area
        case vod_class
        case vod_remarks
        case create_Time


        public static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                video_id: ColumnConstraintBinding(isPrimary: true),
                type_id_1: ColumnConstraintBinding(defaultTo: 0),
                vod_name: ColumnConstraintBinding(defaultTo: ""),
                vod_pic: ColumnConstraintBinding(defaultTo: ""),
                vod_year: ColumnConstraintBinding(defaultTo: ""),
                vod_area: ColumnConstraintBinding(defaultTo: ""),
                vod_class: ColumnConstraintBinding(defaultTo: ""),
                vod_remarks: ColumnConstraintBinding(defaultTo: ""),
                create_Time: ColumnConstraintBinding(defaultTo: 0),
            ]
        }
    }
    
    public required override init() {}
}
