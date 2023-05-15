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

    var id: Int?
    public var primary_Id: String = ""
    public var video_id: Int = 0
    public var type_id_1: Int = 0
    public var vod_name: String = ""
    public var vod_pic: String = ""
    public var status: Int = 0  // 0等待下载，1下载完成
    public var vod_year: String = ""
    public var vod_area: String = ""
    public var create_Time: Int = 0
    public var progress: Int = 0
    public var playName: String = "" //第三集
    public var playUrl: String = "" //第三集的url

    public enum CodingKeys: String, CodingTableKey {
        public typealias Root = HYUkDownListModel
        public static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        case id
        case primary_Id
        case video_id
        case type_id_1
        case vod_name
        case vod_pic
        case vod_year
        case vod_area
        case status
        case progress
        case playName
        case playUrl
        case create_Time

        public static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                id: ColumnConstraintBinding(isAutoIncrement: true),
                primary_Id: ColumnConstraintBinding(isPrimary:true, defaultTo: ""),
//                primary_Id: ColumnConstraintBinding(defaultTo: ""),
                video_id: ColumnConstraintBinding(defaultTo: 0),
                type_id_1: ColumnConstraintBinding(defaultTo: 0),
                vod_name: ColumnConstraintBinding(defaultTo: ""),
                vod_pic: ColumnConstraintBinding(defaultTo: ""),
                vod_year: ColumnConstraintBinding(defaultTo: ""),
                vod_area: ColumnConstraintBinding(defaultTo: ""),
                playUrl: ColumnConstraintBinding(defaultTo: ""),
                playName: ColumnConstraintBinding(defaultTo: ""),
                status: ColumnConstraintBinding(defaultTo: 0),
                progress: ColumnConstraintBinding(defaultTo: 0),
                create_Time: ColumnConstraintBinding(defaultTo: 0),
            ]
        }
    }
    
    public required override init() {}
}
