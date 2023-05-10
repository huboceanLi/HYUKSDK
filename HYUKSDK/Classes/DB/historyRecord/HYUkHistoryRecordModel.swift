//
//  HYUkhistoryRecordModel.swift
//  HYUKSDK
//
//  Created by oceanMAC on 2023/5/6.
//

import Foundation
import WCDBSwift
import YYKit

@objcMembers public class HYUkHistoryRecordModel: NSObject, TableCodable {

    public var tvId: Int = 0
    public var name: String = ""
//    var des: String = ""
    public var playUrl: String = ""
    public var imageUrl: String = ""
    public var duration: Int = 0 //总时间
//    var videoCount: Int = 0
//    var score: Double = 0.0
//    var people: String = ""
//    var categories: String = ""
//    var period: String = ""
    public var playDuration: Int = 0 //100秒
    public var playName: String = "" //第三集
    public var create_Time: Int = 0

    
    public enum CodingKeys: String, CodingTableKey {
        public typealias Root = HYUkHistoryRecordModel
        public static let objectRelationalMapping = TableBinding(CodingKeys.self)
       
        case tvId
        case name
//        case des
        case playUrl
        case imageUrl
        case duration
//        case videoCount
//        case score
//        case people
//        case categories
//        case period
        case playDuration
        case playName
        case create_Time

        public static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                tvId: ColumnConstraintBinding(isPrimary: true),
                name: ColumnConstraintBinding(defaultTo: ""),
//                des: ColumnConstraintBinding(defaultTo: ""),
                playUrl: ColumnConstraintBinding(defaultTo: ""),
                imageUrl: ColumnConstraintBinding(defaultTo: ""),
                duration: ColumnConstraintBinding(defaultTo: 0),
//                people: ColumnConstraintBinding(defaultTo: ""),
//                categories: ColumnConstraintBinding(defaultTo: ""),
//                period: ColumnConstraintBinding(defaultTo: ""),
//                videoCount: ColumnConstraintBinding(defaultTo: 0),
//                score: ColumnConstraintBinding(defaultTo: 0),
                playDuration: ColumnConstraintBinding(defaultTo: 0),
                playName: ColumnConstraintBinding(defaultTo: ""),
                create_Time: ColumnConstraintBinding(defaultTo: 0),

            ]
        }
    }
    
    public required override init() {}
}
