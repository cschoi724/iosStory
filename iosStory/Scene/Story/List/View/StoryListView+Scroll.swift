//
//  StoryListView+Scroll.swift
//  iosStory
//
//  Created by cschoi724 on 2021/07/13.
//

import UIKit

extension StoryListView : UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y + tableView.frame.height*0.8
        let contentSize = tableView.contentSize.height
        let paginationY = contentSize * 0.2
        if contentOffsetY > contentSize - paginationY {
            viewModel.pageUp()
        }
    }
    
}
