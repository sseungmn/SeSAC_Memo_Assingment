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
    @IBAction func addMemoButtonClicked(_ sender: UIButton) {
        tableView.reloadData()
    }
    
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
        
    }

    func setUI() {
        tableView.separatorInset = .zero
        
        // searchBar
        let searchBar = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchBar
        
        let memoCount: Int = fixedMemoList.count + memoList.count
        navigationItem.title = "\(memoCount.toFormattedNumber())개의 메모"
        navigationController?.navigationBar.backgroundColor = .navigationBackground
        
        // LargeTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        if #available(iOS 14.0, *) {
            navigationController?.navigationBar.sizeToFit()
        } else {
            navigationItem.largeTitleDisplayMode = .always
        }
        
    }
    
}

// MARK: - tableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        
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
    
    // MARK: Cell
    func registerXib() {
        let nibName = UINib(nibName: MemoTableViewCell.identifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: MemoTableViewCell.identifier)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as? MemoTableViewCell else {
            fatalError("FAIL : dequeueReusableCell")
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
        cell.writeDateLabel.text = row.writeDate.toFormattedString()
        
        return cell
        
    }
    
    // MARK: Header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        
        if #available(iOS 14.0, *) {
        } else {
            headerView.textLabel?.textColor = .customBlack
            headerView.textLabel?.font = .headerTitle
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView : UITableViewHeaderFooterView {
            var text: String {
                switch section {
                case 0:
                    return "고정된 메모"
                case 1:
                    return "메모"
                default:
                    fatalError("FAIL : Invalid Section")
                }
            }
            
            let tmp = UITableViewHeaderFooterView()
            
            if #available(iOS 14.0, *) {
                var content = UIListContentConfiguration.groupedHeader()
                content.textProperties.font = .headerTitle
                content.textProperties.color = .customBlack
                content.text = text
                tmp.contentConfiguration = content
            } else {
                // 13 이하에서는 indent를 대응하기 어려울 것 같다.
                tmp.textLabel?.text = text
            }
            return tmp
        }
        return headerView

    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 && fixedMemoList.count == 0 {
            return 0
        }
        if section == 1 && memoList.count == 0 {
            return 0
        }
        return 55
    }
    
    // MARK: Footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

// MARK: - Swipe
extension MainViewController {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func getTargetMemo(indexPath: IndexPath) -> Memo {
        switch indexPath.section {
        case 0:
            return fixedMemoList[indexPath.row]
        case 1:
            return memoList[indexPath.row]
        default:
            fatalError("FAIL : Invalid Section")
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var trailingSwipeAction: UISwipeActionsConfiguration {
            let delete = UIContextualAction(style: .normal, title: nil, handler: { action, view, completion in
                self.alert(title: "정말로 지우시겠습니까?",
                           message: nil,
                           okTitle: "확인",
                           okHandler: { _ in
                                let memo = self.getTargetMemo(indexPath: indexPath)
                                self.delete(memo: memo)
                                self.tableView.reloadData()},
                           cancelTitle: "취소",
                           cancelHandler: nil,
                           completion: nil)
                print("Trailing Swipe Action")
            })
            delete.backgroundColor = .red
            delete.image = UIImage(systemName: "trash.fill")
            
            let action = UISwipeActionsConfiguration(actions: [delete])
            action.performsFirstActionWithFullSwipe = false
            return action
            
        }
        return trailingSwipeAction
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        var leadingSwipeAction: UISwipeActionsConfiguration {
            let fix = UIContextualAction(style: .normal, title: nil, handler: { action, view, completionin in
                print("Leading Swipe Action")
                let memo = self.getTargetMemo(indexPath: indexPath)
                if indexPath.section == 0 {
                    self.unfix(memo: memo)
                } else if indexPath.section == 1 {
                    if self.fixedMemoList.count == 5 {
                        self.alert(title: "고정된 메모가 최대치는 5개 입니다.\n 더 추가하실 수 없습니다.")
                    } else {
                        self.fix(memo: memo)
                    }
                                   
                }
                self.tableView.reloadData()
            })
            fix.backgroundColor = .orange
            fix.image = UIImage(systemName: "pin.fill")
            
            let action = UISwipeActionsConfiguration(actions: [fix])
            action.performsFirstActionWithFullSwipe = false
            
            return action
            
        }
        return leadingSwipeAction
        
    }
    
}
