//
//  CountViewController.swift
//  UnlimitedCounts
//
//  Created by EUGENE on 2/7/19.
//  Copyright © 2019 Eugene Zloba. All rights reserved.
//

import UIKit
import CoreData

class CountViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var addBtnOutlet: UIView!
    @IBOutlet weak var addPickerViewBtnOutlet: UIButton!
    @IBOutlet weak var whitePickerViewOutlet: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var blackViewOutlet: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var whitePickerViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var addBtnConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var backBtnConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var leftArrowOutlet: UIImageView!
    
    @IBOutlet weak var addNewCountPageOutlet: UIView!
    
    @IBOutlet weak var backLabelTextOutlet: UILabel!
    
    @IBOutlet weak var makeNewNumbeLabelOutlet: UILabel!
    
    @IBOutlet weak var greenView: UIView!
    
    var countFromPicker: Int = 1
    var idMainTitle: String = ""
       var countDB = [Count]()
    
    var countDBwithIdMainTitle = [Count]()

    var numbers: [Int] = [Int]()
    
    @IBOutlet weak var titleTextOutlet: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCornerLayers()
        self.blackViewOutlet.alpha = 0
        pickerView.delegate = self
        pickerView.dataSource = self
        //pickerView.reloadAllComponents()
        leftArrowOutlet.alpha = 0
        for i in 1...999 {
            numbers.append(i)
        }
        pickerView.reloadAllComponents()
        self.localize()
        self.titleTextOutlet.text = self.idMainTitle
    }
    
    func localize(){
        self.backLabelTextOutlet.text = NSLocalizedString("back_text", comment: "")
        self.makeNewNumbeLabelOutlet.text = NSLocalizedString("make_new_number_text", comment: "")
        self.addPickerViewBtnOutlet.setTitle(NSLocalizedString("add_text", comment: ""), for: .normal)
    }
    
    
    func reloadTableView(){
        let fetchRequest: NSFetchRequest<Count> = Count.fetchRequest()
        let predicate = NSPredicate(format: "idTitle = %@", argumentArray: [self.idMainTitle])
        fetchRequest.predicate = predicate
        do {
            let countTitle = try PersistenceService.context.fetch(fetchRequest)
            self.countDB = countTitle
            self.countDB.reverse()
            self.animateTable()
        } catch {}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.backBtnConstraints.constant += self.view.bounds.width
            self.whitePickerViewConstraint.constant -= self.whitePickerViewOutlet.bounds.height + 150
        self.addNewCountPageOutlet.alpha = 0
        self.addBtnOutlet.alpha = 0
        self.titleTextOutlet.alpha = 0
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.backBtnConstraints.constant -= self.view.bounds.width + 20
            self.view.layoutIfNeeded()
        }){ (succes:Bool) in
            if succes {
                UIView.animate(withDuration: 0.3, animations: {
                    self.backBtnConstraints.constant += 20
                    self.view.layoutIfNeeded()
                }){ (succes2:Bool) in
                    if succes2 {
                        UIView.animate(withDuration: 1, animations: {
                            self.leftArrowOutlet.alpha = 1
                            self.titleTextOutlet.alpha = 1
                        })
                    }
                }
            }
        }
        
        self.reloadTableView()
        UIView.animate(withDuration: 1, animations: {
            self.addBtnOutlet.alpha = 1
        })
    }
    
    @IBAction func backOrCloseCountBtnAction(_ sender: Any) {
        
       // self.dismiss(animated: true, completion: nil)
//        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "idMainVC") as? ViewController else {return}
//
//        self.navigationController?.popToViewController(vc, animated: true)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CountTableViewCell
//        UIView.animate(withDuration: 0.5, animations: {
//           cell.whiteViewOutlet.layer.shadowOpacity = 0.8
//        })
        //cell.contentView.backgroundColor = UIColor.white
        //cell.whiteViewOutlet.backgroundColor = UIColor.white
       // cell.whiteViewOutlet.backgroundColor = UIColor.red
    //cell.selectedBackgroundView?.backgroundColor = UIColor.red
    }

    
    

//    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
//
//    }
    func animateTable(){
        if self.countDB.count == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.addNewCountPageOutlet.alpha = 1
            })
        }else{
            self.addNewCountPageOutlet.alpha = 0
        }
        self.tableView.reloadData()
        let cells = tableView.visibleCells
        let tableViewHeight = tableView.bounds.height
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        var delayCounter = 0
        for cell in cells{
            
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
            
        }
        
    }
    
    func setupCornerLayers(){
        self.addBtnOutlet.layer.shadowColor = UIColor.black.cgColor
        self.addBtnOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.addBtnOutlet.layer.shadowOpacity = 0.4
        self.addBtnOutlet.layer.shadowRadius = 6.0
        self.addBtnOutlet.layer.cornerRadius = 32
        self.addPickerViewBtnOutlet.layer.cornerRadius = 5
        whitePickerViewOutlet.layer.cornerRadius = 8
        
        self.greenView.layer.shadowColor = UIColor.black.cgColor
        self.greenView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.greenView.layer.shadowOpacity = 0.3
        self.greenView.layer.shadowRadius = 4.0
        self.greenView.layer.cornerRadius = 8
        
    }

    
    @IBAction func addBtnAction(_ sender: Any) {
        showPickerView()
    }
    
    @IBAction func closeBtnPickerView(_ sender: Any) {
        dismissPickerView()
    }
    
    @IBAction func addNewCountBtnAction(_ sender: Any) {
        self.showPickerView()
    }
    
    
    func showPickerView(){
    
        if (self.addNewCountPageOutlet.alpha == 1){
            UIView.animate(withDuration: 0.3, animations: {
                self.addNewCountPageOutlet.alpha = 0
            })
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.addBtnConstraints.constant -= self.addBtnOutlet.bounds.height + 150
            self.view.layoutIfNeeded()
        }){ (succes:Bool) in
            if succes {
                UIView.animate(withDuration: 0.5, animations: {
                    self.whitePickerViewConstraint.constant += self.whitePickerViewOutlet.bounds.height + 150
                    self.blackViewOutlet.alpha = 1
                    self.view.layoutIfNeeded()
                })
            }
        }
        pickerView.selectRow(0, inComponent: 0, animated: false)
        countFromPicker = 1
    }
    
    func dismissPickerView(){
        UIView.animate(withDuration: 0.5, animations: {
            self.whitePickerViewConstraint.constant -= self.whitePickerViewOutlet.bounds.height + 150
            self.blackViewOutlet.alpha = 0
            self.view.layoutIfNeeded()
        }){ (succes:Bool) in
            if succes {
                UIView.animate(withDuration: 0.5, animations: {
                    self.addBtnConstraints.constant += self.addBtnOutlet.bounds.height + 150
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    
    
    @IBAction func saveCountInCoredata(_ sender: Any) {
        
        let timestamp: NSNumber = (Date().timeIntervalSince1970) as NSNumber
        print("TIMESTAMP")
        print(Double(timestamp))
        
        let count = Count(context: PersistenceService.context)
        count.date = Double(timestamp)
        count.count = Int16(countFromPicker)
        count.idTitle = idMainTitle
        PersistenceService.saveContext()
        self.countDB.append(count)
        self.reloadTableView()
        
        dismissPickerView()
        
    }
    

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> Int {
//        return numbers[row]
//    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(numbers[row])
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numbers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countFromPicker = numbers[row]
        print(countFromPicker)
    }

    
    
    

}

extension CountViewController:UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countDB.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdForCount", for: indexPath) as! CountTableViewCell
        
        let customColorView = UIView()
        customColorView.backgroundColor = UIColor.white
        cell.selectedBackgroundView =  customColorView;
        
        cell.countLabelOutlet.text = String(countDB[indexPath.row].count)
        
        let timestampDate = NSDate(timeIntervalSince1970: countDB[indexPath.row].date)
            let dateFormatter = DateFormatter()
            //dateFormatter.dateFormat = "MM/dd/yy' 'hh:mm a"
        dateFormatter.dateFormat = "MMMM d, h:mm a"
        
            cell.dateLabelOutlet.text = dateFormatter.string(from: timestampDate as Date)
        
        cell.whiteViewOutlet.backgroundColor = UIColor.white
        cell.whiteViewOutlet.layer.shadowColor = UIColor.black.cgColor
        cell.whiteViewOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        cell.whiteViewOutlet.layer.shadowOpacity = 0.3
        cell.whiteViewOutlet.layer.shadowRadius = 4.0
        cell.whiteViewOutlet.layer.cornerRadius = 6
        
        
        
        //cell.selectedBackgroundView?.backgroundColor = UIColor.red
        //
        //
        //        cell.viewOutlet.layer.shadowColor = UIColor.black.cgColor
        //        cell.viewOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        //        cell.viewOutlet.layer.shadowOpacity = 0.8
        //        cell.viewOutlet.layer.shadowRadius = 5.0
        //        cell.viewOutlet.layer.cornerRadius = 12
        //
        //        let borderView = UIView()
        //        borderView.frame = cell.viewOutlet.bounds
        //        borderView.layer.cornerRadius = 10
        //        borderView.layer.masksToBounds = true
        //        cell.viewOutlet.addSubview(borderView)
        
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //objects.remove(at: indexPath.row)
            
            let contex = PersistenceService.context
            contex.delete(self.countDB[indexPath.row])
            do {
                try contex.save()
            } catch {
                
            }
//            let fetchRequest: NSFetchRequest<Count> = Count.fetchRequest()
//            let object: NSObject = self.countDB[indexPath.row]
//            if let result = try? PersistenceService.context.fetch(fetchRequest) {
//                for obj in result {
//                    context.delete(self.countDB[indexPath.row])
//                }
//            }
            
            self.reloadTableView()
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
    
}
