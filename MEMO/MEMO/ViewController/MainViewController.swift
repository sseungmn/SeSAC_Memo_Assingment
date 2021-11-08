//
//  ViewController.swift
//  MEMO
//
//  Created by OHSEUNGMIN on 2021/11/08.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    let localRealm = try! Realm()
    
    var fixedMemoList: Results<Memo>! {
        didSet {
            tableView.reloadData()
        }
    }
    var memoList: Results<Memo>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var memoCountLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addMemoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        setUI()
        setDelegate()
        registerXib()
        
    }
    
    func setData() {
        fixedMemoList = localRealm.objects(Memo.self)
            .filter("fixed == true")
            .sorted(byKeyPath: "writeDate", ascending: true)
        memoList = localRealm.objects(Memo.self)
            .filter("fixed == false")
            .sorted(byKeyPath: "writeDate", ascending: true)
        
        print("Realm is located in \(localRealm.configuration.fileURL!)")
        print(fixedMemoList!)
        print(memoList!)
        
    }

    func setUI() {
        view.backgroundColor = .black
        
//        tableView.backgroundColor = .clear
        tableView.backgroundColor = .white
        tableView.separatorColor = .contentGray
        tableView.separatorInset = .zero
        
        searchBar.barTintColor = .darkBackground
        searchBar.setIconColor(.contentGray)
        searchBar.setPlaceholderColor(.contentGray)
        searchBar.backgroundColor = .clear
        
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func registerXib() {
        let nibName = UINib(nibName: MemoTableViewCell.identifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: MemoTableViewCell.identifier)
        
    }
    
    func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            if fixedMemoList.count == 0 { return nil }
            else { return "고정된 메모" }
        case 1:
            return "메모"
        default:
            fatalError("FAIL : Invalid Section")

        }

    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.contentView.backgroundColor = .green
        print(header.subviews)
        
        header.textLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        header.textLabel?.frame = CGRect(x: 0, y: 0, width: header.bounds.width, height: header.bounds.height)
        header.textLabel?.textAlignment = .left
        header.textLabel?.backgroundColor = .purple
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return fixedMemoList.count
        case 1:
            return memoList.count
        default:
            fatalError("FAIL : Invalid Section")
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as? MemoTableViewCell else {
            print("FAIL : dequeueReusableCell")
            return UITableViewCell()
        }
        
        let row: Memo
        switch indexPath.section {
        case 0:
            row = fixedMemoList[indexPath.row]
        case 1:
            row = memoList[indexPath.row]
        default:
            fatalError("FAIL : Invalid Section")
        }
        
        cell.titleLabel.text = row.title
        cell.contentLabel.text = row.content
        cell.writeDateLabel.text = row.writeDate.toString()
        
        return cell
        
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        var view: UIView {
//            let tmp = UIView(frame: CGRect(x: 0, y: 5, width: tableView.bounds.width, height: 20))
//            var title: UILabel {
//                let tmp = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 20))
//                tmp.font = .systemFont(ofSize: 20, weight: .bold)
//                tmp.textAlignment = .left
//
//                if section == 0 {
//                    tmp.text = "고정된 메모"
//                } else {
//                    tmp.text = "메모"
//                }
//                return tmp
//
//            }
//            tmp.addSubview(title)
//            tmp.backgroundColor = .brown
//            return tmp
//
//        }
//        return view
//
//    }
//
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 && fixedMemoList.count == 0 {
            return 0
        }
        if section == 1 && memoList.count == 0 {
            return 0
        }
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
        
    }
    
}
