//
//  BCStorySend+Text.swift
//  iosClubRadio
//
//  Created by cschoi724 on 2020/06/30.
//  Copyright © 2020 Inforex. All rights reserved.
//

import UIKit

extension StorySendView : UITextViewDelegate{
    
    func setTextview(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.conts_textView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        self.conts_textView.delegate    = self
        self.placeholder_label.isHidden = false
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        viewModel.editing(true)
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.frame.origin.y == 0{
                self.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        viewModel.editing(false)
        if self.frame.origin.y != 0 {
            self.frame.origin.y = 0
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        visiblePlaceholder(textView)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        visiblePlaceholder(textView)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        visiblePlaceholder(textView)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        let trim = text == "\n" ? 1 : 0
        let trimCount = textView.text.components(separatedBy: "\n").count - 1 + trim
        
        if numberOfChars + (trimCount * weight) - trimCount <= maxTextCount {
            return true
        }else{
            Toast.show("300자 이상 입력할 수 없습니다.")
            return false
        }
    }
    
    func visiblePlaceholder(_ textView : UITextView){
        if textView.text.isEmpty {
            placeholder_label.isHidden = false
        }else{
            placeholder_label.isHidden = true
        }
    }
}
