//
//  ViewController.swift
//  UnlimitedCounts
//
//  Created by EUGENE on 2/6/19.
//  Copyright © 2019 Eugene Zloba. All rights reserved.
//

import UIKit
import CoreData
import StoreKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   // let uuid = UUID().uuidString
    @IBOutlet weak var btnCreateOutlet: UIView!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var btnCreateButton: UILabel!
    @IBOutlet weak var createNewCountView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var createBtnConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var whiteViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnCreateBtnOutlet: UIButton!
    
    @IBOutlet weak var createNewPageOutlet: UIView!
    
    @IBOutlet weak var createFirstCounterLabelOutlet: UILabel!
    
    
    @IBOutlet weak var exView1Outlet: UIView!
    
    @IBOutlet weak var exView2Outlet: UIView!
    
    @IBOutlet weak var exView3Outlet: UIView!
    
    @IBOutlet weak var exView4Outlet: UIView!
    
    @IBOutlet weak var exView5Outlet: UIView!
    
    @IBOutlet weak var exView6Outlet: UIView!
    
    
    @IBOutlet weak var ex1TotalOutlet: UILabel!
    
    @IBOutlet weak var ex2DaysOutlet: UILabel!
    
    @IBOutlet weak var ex2TotalOutlet: UILabel!
    
    @IBOutlet weak var ex1DaysOutlet: UILabel!
    
    @IBOutlet weak var ex3TotalOutlet: UILabel!
    
    @IBOutlet weak var ex3DaysOutlet: UILabel!
    
    @IBOutlet weak var ex4DaysOutlet: UILabel!
    
    @IBOutlet weak var ex4TotalOutlet: UILabel!
    
    @IBOutlet weak var ex5DaysOutlet: UILabel!
    
    @IBOutlet weak var ex5TotalOutlet: UILabel!
    
    @IBOutlet weak var ex6DaysOutlet: UILabel!
    
    @IBOutlet weak var ex6TotalOutlet: UILabel!
    
    @IBOutlet weak var logoImageOutlet: UIImageView!
    
    
    
    
    var mainTitle = [Main]()
    var countDB = [Count]()
    var idMainTitle: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        self.setupCornerLayers()
        self.navigationController?.isNavigationBarHidden = true
        //animationForView()
        self.localize()
        
//        guard SubscriptionService.shared.currentSessionId != nil,
//            SubscriptionService.shared.hasReceiptData else {
//                showRestoreAlert()
//                return
//        }
        
        
    }

    
    
//    func loadSubscriptionOptions() {
//
//        let productIDPrefix = Bundle.main.bundleIdentifier! + ".sub."
//
//        let allAccess = productIDPrefix + "allaccess"
//        let oneAWeek  = productIDPrefix + "oneaweek"
//
//        let allAccessMonthly = productIDPrefix + "allaccess.monthly"
//        let oneAWeekMonthly  = productIDPrefix + "oneaweek.monthly"
//
//        let productIDs = Set([allAccess, oneAWeek, allAccessMonthly, oneAWeekMonthly])
//
//        let request = SKProductsRequest(productIdentifiers: productIDs)
//        request.delegate = self
//        request.start()
//    }
    
    func observeReloads(){
       
            self.idMainTitle = "Push-Ups"
            self.reloadTotals()
            self.ex1TotalOutlet.text = String(self.totalFromCountFetch)
            self.ex1DaysOutlet.text = String(self.totalFor7Days)
        
            self.idMainTitle = "Squats"
        self.reloadTotals()
        self.ex2TotalOutlet.text = String(self.totalFromCountFetch)
        self.ex2DaysOutlet.text = String(self.totalFor7Days)
        
        
            self.idMainTitle = "Dumbbells"
        self.reloadTotals()
        self.ex3TotalOutlet.text = String(self.totalFromCountFetch)
        self.ex3DaysOutlet.text = String(self.totalFor7Days)
        
            self.idMainTitle = "Press"
        self.reloadTotals()
        self.ex4TotalOutlet.text = String(self.totalFromCountFetch)
        self.ex4DaysOutlet.text = String(self.totalFor7Days)
        
            self.idMainTitle = "Pull-Ups"
        self.reloadTotals()
        self.ex5TotalOutlet.text = String(self.totalFromCountFetch)
        self.ex5DaysOutlet.text = String(self.totalFor7Days)
        
            self.idMainTitle = "ABS"
        self.reloadTotals()
        self.ex6TotalOutlet.text = String(self.totalFromCountFetch)
        self.ex6DaysOutlet.text = String(self.totalFor7Days)
        
        
    }
    var totalFor7Days : Int = 0
    func reloadTotals(){
        let fetchRequest: NSFetchRequest<Count> = Count.fetchRequest()
        let predicate = NSPredicate(format: "idTitle = %@", argumentArray: [self.idMainTitle])
        fetchRequest.predicate = predicate
        totalFor7Days = 0
        totalFromCountFetch = 0
        let currentTimeStampDouble = (Date().timeIntervalSince1970) as Double
        var currentTimeStampInt:Int = Int(currentTimeStampDouble)
        currentTimeStampInt -= 604800
        do {
            let countTitle = try PersistenceService.context.fetch(fetchRequest)
            self.countDB = countTitle
            //let i = 0
            for (index, countDB) in self.countDB.enumerated() {
                let obj = self.countDB[index].count
                totalFromCountFetch += Int(obj)
                let countTimestumpDouble = self.countDB[index].date
                let countTimeStumpInt: Int = Int(countTimestumpDouble)
                
                if (countTimeStumpInt>currentTimeStampInt) {
                    let obj2 = self.countDB[index].count
                    totalFor7Days += Int(obj2)
                }
                
            }
            
 
        } catch {}
        
//        var pointTimeStampPlus24Hours = pointtimeStamp!.intValue + 86400
//        var currentTimeStampDouble = (Date().timeIntervalSince1970) as Double
//
//        let currentTimeStampInt:Int = Int(currentTimeStampDouble)
//        if (currentTimeStampInt < pointTimeStampPlus24Hours) {
//
//        }
        
    }
    
    
    
    
    var mainNameTitle: String = ""
    
    func openNewVC(){
        
        //let mainTitle =
        
        //let idTitle = mainTitle.idTitle
        //print(idTitle)
        
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "idCountVC") as? CountViewController else {
            print("View controller could not be instantiated")
            return
        }
        //let vc = CountViewController()
//        guard let newTitle = idTitle else {
//            print("NO TITLE")
//            return
//        }
        
        vc.self.idMainTitle = self.mainNameTitle
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func ex1BtnAction(_ sender: Any) {
        self.mainNameTitle = "Push-Ups"
        self.openNewVC()
    }
    
    
    @IBAction func ex2BtnAction(_ sender: Any) {
        self.mainNameTitle = "Squats"
        self.openNewVC()
    }
    
    @IBAction func ex3BtnAction(_ sender: Any) {
        self.mainNameTitle = "Dumbbells"
        self.openNewVC()
    }
    
    @IBAction func ex4BtnAction(_ sender: Any) {
        self.mainNameTitle = "Press"
        self.openNewVC()
    }
    
    @IBAction func ex5BtnAction(_ sender: Any) {
        self.mainNameTitle = "Pull-Ups"
        self.openNewVC()
    }
    
    @IBAction func ex6BtnAction(_ sender: Any) {
        self.mainNameTitle = "ABS"
        self.openNewVC()
    }
    
    
    
    
    
    
    
    
    
    func localize(){
        self.btnCreateButton.text = NSLocalizedString("create_text", comment: "")
        self.btnDone.setTitle(NSLocalizedString("done_text", comment: ""), for: .normal)
        self.createFirstCounterLabelOutlet.text = NSLocalizedString("create_first_counter_text", comment: "")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        self.logoImageOutlet.alpha = 0
        self.exView1Outlet.alpha = 0
        self.exView2Outlet.alpha = 0
        self.exView3Outlet.alpha = 0
        self.exView4Outlet.alpha = 0
        self.exView5Outlet.alpha = 0
        self.exView6Outlet.alpha = 0
    }

    override func viewDidAppear(_ animated: Bool) {
        self.view.layoutIfNeeded()
        self.viewDidLayoutSubviews()
        super.viewDidAppear(animated)
        self.animateViews()
        self.observeReloads()
        //UPDATE COUNTS
    }
    
    func animateViews(){
        self.logoImageOutlet.alpha = 0
        self.exView1Outlet.alpha = 0
        self.exView2Outlet.alpha = 0
        self.exView3Outlet.alpha = 0
        self.exView4Outlet.alpha = 0
        self.exView5Outlet.alpha = 0
        self.exView6Outlet.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.logoImageOutlet.alpha = 1
        }){ (succes:Bool) in
            if succes {
                UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
                    self.exView1Outlet.alpha = 1
                }, completion: nil)
                UIView.animate(withDuration: 0.4, delay: 0.2, options: .curveEaseInOut, animations: {
                    self.exView2Outlet.alpha = 1
                }, completion: nil)
                UIView.animate(withDuration: 0.4, delay: 0.4, options: .curveEaseInOut, animations: {
                    self.exView3Outlet.alpha = 1
                }, completion: nil)
                UIView.animate(withDuration: 0.4, delay: 0.6, options: .curveEaseInOut, animations: {
                    self.exView4Outlet.alpha = 1
                }, completion: nil)
                UIView.animate(withDuration: 0.4, delay: 0.8, options: .curveEaseInOut, animations: {
                    self.exView6Outlet.alpha = 1
                }, completion: nil)
                UIView.animate(withDuration: 0.4, delay: 1, options: .curveEaseInOut, animations: {
                    self.exView5Outlet.alpha = 1
                }, completion: nil)
            }
        }
    }
    
    func animationForView(){
        self.reloadTableView()
        
        self.btnCreateOutlet.center.x  -= 50
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.createBtnConstraint.constant -= self.view.bounds.width+20
            self.view.layoutIfNeeded()
        }){ (succes:Bool) in
            if succes {
                UIView.animate(withDuration: 0.5, animations: {
                    self.createBtnConstraint.constant += 20
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    @IBAction func btnDoneAction(_ sender: Any) {

        self.dismissCreateNewView()
        
    }
    
    @IBAction func createNewFromPage(_ sender: Any) {
        self.showCreateNewView()
    }
    
    
    func showCreateNewView(){
        
        if (self.createNewPageOutlet.alpha == 1){
            UIView.animate(withDuration: 0.3, animations: {
                self.createNewPageOutlet.alpha = 0
            })
        }
        
        UIView.animate(withDuration: 0.2) {
            self.btnCreateOutlet.alpha = 0.4
        }
        
        //self.btnCreateButton.isEnabled = false
        
        UIView.animate(withDuration: 0.5) {
            self.whiteViewConstraint.constant -= self.view.bounds.height
            self.view.layoutIfNeeded()
        }
        titleTextField.layer.borderWidth = 0
        titleTextField.text = ""
        titleTextField.becomeFirstResponder()
        titleTextField.layer.cornerRadius = 5
        print("Hello World")
        
        self.btnCreateBtnOutlet.isEnabled = false
    }
    
    func dismissCreateNewView(){
        
        if (titleTextField.text != "") {
            self.createNew()
            UIView.animate(withDuration: 0.2, animations: {
                self.btnDone.alpha = 0.4
            }) { (Bool) in
                self.btnDone.alpha = 1
            }
            UIView.animate(withDuration: 0.5) {
                self.whiteViewConstraint.constant += self.view.bounds.height
                self.view.layoutIfNeeded()
            }
            UIView.animate(withDuration: 0.2) {
                self.btnCreateOutlet.alpha = 1
            }
            // self.btnCreateButton.isEnabled = true
            self.view.endEditing(true)
            
            
        } else {
            titleTextField.layer.borderColor = UIColor.red.cgColor
            titleTextField.layer.borderWidth = 1
        }
        
        self.btnCreateBtnOutlet.isEnabled = true
        
    }
    
    @IBAction func btnCreate(_ sender: Any) {

        self.showCreateNewView()
        
    }
    

    
    
    func createNew(){
        let uuid = UUID().uuidString
        print(uuid)
        let timestamp: NSNumber = (Date().timeIntervalSince1970) as NSNumber
        print(timestamp)
        print(titleTextField.text)

//                let count = alert.textFields!.first!.text!
//                let date = alert.textFields!.last!.text!
        
                let main = Main(context: PersistenceService.context)
                main.dateTitle = Double(timestamp)
                main.nameTitle = titleTextField.text!
                main.idTitle = String(uuid)
                PersistenceService.saveContext()
                self.mainTitle.append(main)
                self.reloadTableView()
        
        
    }
    
    
    
    func setupCornerLayers(){
        //self.createNewCountView.alpha = 0
        
        self.btnDone.layer.shadowColor = UIColor.black.cgColor
        self.btnDone.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.btnDone.layer.shadowOpacity = 0.3
        self.btnDone.layer.shadowRadius = 4.0
        self.btnDone.layer.cornerRadius = 5
        
        self.greenView.layer.shadowColor = UIColor.black.cgColor
        self.greenView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.greenView.layer.shadowOpacity = 0.3
        self.greenView.layer.shadowRadius = 4.0
        self.greenView.layer.cornerRadius = 8
        
        self.btnCreateOutlet.layer.cornerRadius = 4
        
        self.exView1Outlet.layer.shadowColor = UIColor.black.cgColor
        self.exView1Outlet.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.exView1Outlet.layer.shadowOpacity = 0.4
        self.exView1Outlet.layer.shadowRadius = 3.0
        self.exView1Outlet.layer.cornerRadius = 6
        
        self.exView2Outlet.layer.shadowColor = UIColor.black.cgColor
        self.exView2Outlet.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.exView2Outlet.layer.shadowOpacity = 0.4
        self.exView2Outlet.layer.shadowRadius = 3.0
        self.exView2Outlet.layer.cornerRadius = 6
        
        self.exView3Outlet.layer.shadowColor = UIColor.black.cgColor
        self.exView3Outlet.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.exView3Outlet.layer.shadowOpacity = 0.4
        self.exView3Outlet.layer.shadowRadius = 3.0
        self.exView3Outlet.layer.cornerRadius = 6
        
        self.exView4Outlet.layer.shadowColor = UIColor.black.cgColor
        self.exView4Outlet.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.exView4Outlet.layer.shadowOpacity = 0.4
        self.exView4Outlet.layer.shadowRadius = 3.0
        self.exView4Outlet.layer.cornerRadius = 6
        
        self.exView5Outlet.layer.shadowColor = UIColor.black.cgColor
        self.exView5Outlet.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.exView5Outlet.layer.shadowOpacity = 0.4
        self.exView5Outlet.layer.shadowRadius = 3.0
        self.exView5Outlet.layer.cornerRadius = 6
        
        self.exView6Outlet.layer.shadowColor = UIColor.black.cgColor
        self.exView6Outlet.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.exView6Outlet.layer.shadowOpacity = 0.4
        self.exView6Outlet.layer.shadowRadius = 3.0
        self.exView6Outlet.layer.cornerRadius = 6
    }

    func reloadTableView(){
        let fetchRequest: NSFetchRequest<Main> = Main.fetchRequest()
        
        do {
            let mainTitle2 = try PersistenceService.context.fetch(fetchRequest)
            self.mainTitle = mainTitle2
            self.mainTitle.reverse()
            self.animateTable()
        } catch {}
    }
    
    var totalFromCountFetch: Int = 0
    func reloadCount(){
        
        let fetchRequest: NSFetchRequest<Count> = Count.fetchRequest()
        let predicate = NSPredicate(format: "idTitle = %@", argumentArray: [self.idMainTitle])
        fetchRequest.predicate = predicate
        
        totalFromCountFetch = 0
        do {
            let countTitle = try PersistenceService.context.fetch(fetchRequest)
            self.countDB = countTitle
            //let i = 0
            for (index, countDB) in self.countDB.enumerated() {
                let obj = self.countDB[index].count
                totalFromCountFetch += Int(obj)
            }
            
            //цикл чтоб считал количество
//            for i in self.countDB {
//
//            }
            //totalFromCountFetch = self.countDB.count
        } catch {}
        

        
    }
    
    
    func animateTable(){
        if self.mainTitle.count == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.createNewPageOutlet.alpha = 1
            })
        }else{
            self.createNewPageOutlet.alpha = 0
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
    
    
    
    
    
    
    
    
    
    

}



extension ViewController:UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainTitle.count
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //objects.remove(at: indexPath.row)
            
            let contex = PersistenceService.context
            print(self.mainTitle[indexPath.row])
            print("DELETED")
            contex.delete(self.mainTitle[indexPath.row])
            do {
                try contex.save()
            } catch {
                
            }
            //self.animateTable()
            //self.tableView.reloadData()
            self.reloadTableView()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

                let mainTitle = self.mainTitle[indexPath.row]
        
                let idTitle = mainTitle.idTitle
                print(idTitle)
        
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "idCountVC") as? CountViewController else {
            print("View controller could not be instantiated")
            return
        }
        //let vc = CountViewController()
        guard let newTitle = idTitle else {
            print("NO TITLE")
            return
        }

        vc.self.idMainTitle = newTitle
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdForMain", for: indexPath) as! MainTableViewCell
        let customColorView = UIView()
        customColorView.backgroundColor = UIColor.white
        cell.selectedBackgroundView =  customColorView;
        
        cell.totalLabelOutlet.text = NSLocalizedString("total_text", comment: "")
        cell.showAllOutlet.text = NSLocalizedString("show_all_text", comment: "")
                cell.title.text = mainTitle[indexPath.row].nameTitle
                cell.total.text = "999"
                cell.whiteViewForTableView.layer.shadowColor = UIColor.black.cgColor
                cell.whiteViewForTableView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
                cell.whiteViewForTableView.layer.shadowOpacity = 0.3
                cell.whiteViewForTableView.layer.shadowRadius = 4.0
                cell.whiteViewForTableView.layer.cornerRadius = 6
        
//        self.idMainTitle = mainTitle[indexPath.row].idTitle!
//        reloadCount()
        //cell.total.text = String(totalFromCountFetch)
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
}

//extension SubscriptionService: SKProductsRequestDelegate {
//    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
//        options = response.products.map { Subscription(product: $0) }
//    }
//
//    func request(_ request: SKRequest, didFailWithError error: Error) {
//        if request is SKProductsRequest {
//            print("Subscription Options Failed Loading: \(error.localizedDescription)")
//        }
//    }
//}
