//
//  StoryListViewModel+.swift
//  iosStory
//
//  Created by cschoi724 on 2021/07/10.
//

import Foundation
import SwiftyJSON

extension StoryListViewModel {
    
    func setUp(_ initData: JSON){
        let viewer = User(name: "석찬",
                          no: 4781,
                          id: "cschoi724",
                          gender: "m",
                          thumbnailUrl: "https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2Fportrait%2F202105%2F20210514170055590.jpg")
        self.model.viewer.accept(viewer)
        let page = self.model.page
        downloadStorys(page)
    }
    
    func downloadStorys(_ page : Int){
        guard model.requestGuard else {
            return
        }
        model.requestGuard = false
        guard let viewer = self.model.viewer.value else{
            return
        }
        
        var storys = self.model.storys.value        
        guard model.page <= model.totalPage else{
            return
        }
        
        let path = "http://pida83.gabia.io/api/story/page/\(page)?bj_id=\(viewer.id)"
        RESTManager.sharedInstance.request(path){ [weak self] reponse in
            guard let self = self else{ return }
            self.model.requestGuard = true
            guard let res = reponse else{ return }
            let json = JSON(res)
            let totalPage = json["total_page"].intValue
            self.model.totalPage = totalPage
            let list: [StoryModel] = json["list"].arrayValue.map{
                let regNo = $0["reg_no"].intValue
                let date = $0["ins_date"].stringValue
                let read = $0["read_yn"].stringValue == "y"
                let contents = $0["story_conts"].stringValue
                
                let fromSex = $0["send_mem_gender"].stringValue
                let fromNo = $0["send_mem_no"].intValue
                let fromId = $0["bj_id"].stringValue
                let fromName = $0["send_chat_name"].stringValue
                let fromPhoto = $0["send_mem_photo"].stringValue
                let from = User(name: fromName,
                                no: fromNo,
                                id: fromId,
                                gender: fromSex,
                                thumbnailUrl: fromPhoto)
                let story = StoryModel(from: from,
                                       regNo: regNo,
                                       read: read,
                                       contents: contents,
                                       date: date,
                                       moreAction: self.openMore)
                return story
            }
            
            guard !list.isEmpty else{
                return
            }
            
            self.model.page += 1
            storys.append(contentsOf: list)
            self.model.storys.accept(storys)
        }
    }
    
    func delete(_ model: StoryModel){
        var storys = self.model.storys.value
        storys = storys.filter{ $0.regNo != model.regNo}
        self.model.storys.accept(storys)
    }
    
    func openMore(_ model : StoryModel){
        let deleteAction = UIAlertAction(title: "삭제하기", style: .default) { _ in
            self.delete(model)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let alertController = UIAlertController(title: nil, message: "더보기", preferredStyle: .actionSheet)
        alertController.addAction(deleteAction)
        alertController.addAction(cancel)
        if let vc = App.visibleViewController(){
            vc.present(alertController, animated: false)
        }
    }
    
    func pageUp(){
        downloadStorys(model.page)
    }
}
