//
//  HYAPIString.m
//  HYReadBook
//
//  Created by oceanMAC on 2023/2/24.
//

#import "HYAPIString.h"

@implementation HYAPIString

//NSString * const API_Movie_List = @"https://pcw-api.iqiyi.com/search/recommend/list?channel_id=1&data_type=1&mode=11&page_id=1&ret_num=48&session=ee4d98ebb4e8e44c8d4b14fa90615fb7";
NSString * const API_Movie_List = @"https://pcw-api.iqiyi.com/search/recommend/list";

//douban
NSString * const API_Fillter_List = @"https://m.douban.com/rexxar/api/v2/movie/recommend/filter_tags";

NSString * const API_DouBan_Movie_List = @"https://m.douban.com/rexxar/api/v2/movie/recommend";

NSString * const API_DouBan_Movie_Detail = @"https://m.douban.com/rexxar/api/v2/movie/";

NSString * const API_DouBan_Search_List = @"https://search.douban.com/movie/subject_search";

@end
