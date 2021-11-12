//
//  EditViewController.swift
//  MEMO
//
//  Created by OHSEUNGMIN on 2021/11/12.
//

import UIKit
import SwiftUI

class EditViewController: UIViewController, UITextViewDelegate {
    static let identification = "EditViewController"
    
    var memo: Memo?
    
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        textView.becomeFirstResponder()
        
        setText()
    }
    
    func setText() {
        let text = "\(memo?.title ?? "")\n\(memo?.content ?? "")"
        if text != "\n" {
            textView.text = text
        }
    }
    
    @objc
    func popView() {
        navigationController?.popViewController(animated: true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        setNavigationBar()
    }
    
    func setNavigationBar() {
        let save = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(popView))
        let share = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(share))
        navigationItem.rightBarButtonItems = [save, share]
        navigationController?.navigationBar.tintColor = .orange
    }
}

// MARK: Save
extension EditViewController {
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        save()
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        popView()
    }
    
    func save() {
        editMemo()
        if memo == nil { return }
        memo = nil
        print("메모가 저장되었습니다.")
    }
    
    func editMemo() {
        guard var tokens: [String] = textView.text?.components(separatedBy: ["\n"]) else { return }
        guard let title: String = tokens.removeFirst() as String? else { return }
        if title == "" { return }
        var content: String? = tokens.reduce(into: "") { content, token in
            content += "\(token)\n"
        }
        if content == "" { content = nil }
        if memo == nil {
            memo = Memo(title: title, content: content, writtenDate: Date())
            self.add(memo: memo!)
        } else {
            self.edit(memo: memo!, title: title, content: content)
        }
    }
    
}

// MARK: Share
extension EditViewController {
    @objc
    func share() {
        presentActivityViewController()
    }
    
    func presentActivityViewController() {
        guard let text = textView.text else { return }
        let file = [text]
        let vc = UIActivityViewController(activityItems: file, applicationActivities: nil)
        self.present(vc, animated: true, completion: nil)
    }
}
