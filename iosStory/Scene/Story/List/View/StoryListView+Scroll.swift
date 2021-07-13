//
//  StoryListView+Scroll.swift
//  iosStory
//
//  Created by cschoi724 on 2021/07/13.
//

import UIKit

extension StoryListView : UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y + tableView.frame.height
        let contentSize = tableView.contentSize.height
        let paginationY = contentSize * 0.2
        print("\(contentOffsetY) > \(contentSize) - \(paginationY)")
        if contentOffsetY > contentSize - paginationY {
            print("hi")
            viewModel.pageUp()
        }
    }
    
}
