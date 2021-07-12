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
                          thumbnailUrl: "")
        self.model.viewer.accept(viewer)
        downloadStorys(viewer)
    }
    
    func downloadStorys(_ viewer: User){
        let page = self.model.page
        let path = "http://pida83.gabia.io/api/story/page/\(page)?bj_id=\(viewer.id)"
        RESTManager.sharedInstance.request(path){ [weak self] reponse in
            guard let self = self else{ return }
            guard let res = reponse else{ return }
            let json = JSON(res)
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
            self.model.storys.accept(list)
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
}
