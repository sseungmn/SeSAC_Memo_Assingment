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
            fixedMemoTableView.reloadData()
        }
    }
    var memoList: Results<Memo>! {
        didSet {
            memoTableView.reloadData()
        }
    }
    
    @IBOutlet weak var memoCountLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var fixedMemoTableView: UITableView!
    @IBOutlet weak var memoTableView: UITableView!
    @IBOutlet weak var addMemoButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        registerXib()
        setData()
        
    }
    
    func setData() {
        
        self.fixedMemoList = localRealm.objects(Memo.self)
            .filter("fixed == true")
            .sorted(byKeyPath: "writeDate", ascending: true)
        self.memoList = localRealm.objects(Memo.self)
            .filter("fixed == false")
            .sorted(byKeyPath: "writeDate", ascending: true)
        
        print("Realm is located in \(localRealm.configuration.fileURL!)")
//        print(fixedMemoList!)
//        print(memoList!)
        
    }

    func setUI() {
        
        view.backgroundColor = .black
        
        searchBar.barTintColor = .lightBackground
        searchBar.setIconColor(.contentGray)
        searchBar.setPlaceholderColor(.contentGray)
        searchBar.backgroundColor = .clear
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func registerXib() {
        let nibName = UINib(nibName: MemoTableViewCell.identifier, bundle: nil)
        memoTableView.register(nibName, forCellReuseIdentifier: MemoTableViewCell.identifier)
        fixedMemoTableView.register(nibName, forCellReuseIdentifier: MemoTableViewCell.identifier)
    }
    
    func setDelegate() {
        
        memoTableView.delegate = self
        memoTableView.dataSource = self
        fixedMemoTableView.delegate = self
        fixedMemoTableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case memoTableView:
            return memoList.count
        case fixedMemoTableView:
            return fixedMemoList.count
        default:
            fatalError("FAIL : Invalid Table")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as? MemoTableViewCell else {
            print("FAIL : dequeueReusableCell")
            return UITableViewCell()
        }
        
        let row: Memo
        switch tableView {
        case memoTableView:
            row = memoList[indexPath.row]
        case fixedMemoTableView:
            row = fixedMemoList[indexPath.row]
        default:
            fatalError("FAIL : Invalid Table")
        }
        
        cell.titleLabel.text = row.title
        cell.contentLabel.text = row.content
        cell.writeDateLabel.text = row.writeDate.toString()
        
        return cell
        
    }
    
}
