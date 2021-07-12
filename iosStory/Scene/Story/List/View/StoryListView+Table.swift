//
//  BCStoryList+Table.swift
//  iosClubRadio
//
//  Created by cschoi724 on 2020/07/01.
//  Copyright © 2020 Inforex. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension StoryListView : UITableViewDelegate{

    var cellName : String { return "StoryCell" }
    
    func setTableView(){
        
        tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension

        tableView.rx.setDelegate(self).disposed(by: bag)
        setDatasource()
    }
    
    func setDatasource(){
        viewModel.storys
            .bind(to: tableView.rx.items(cellIdentifier: cellName, cellType: StoryCell.self)){
                index,item,cell in
                cell.story = item
                cell.initalize()
        }.disposed(by: bag)
    }

}
