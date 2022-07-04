//
//  DocumentViewController.swift
//  MC2
//
//  Created by Widya Limarto on 29/06/22.
//

import UIKit
import PDFKit

class DocumentViewController: UIViewController {
    var fileName: String?
    var filePath: URL?
    var pdfView: PDFView!
    var isHiddenSideView: Bool = true
    var highLights: [Bool] = [true, false, false]
    
    @IBOutlet weak var contentPdfView: UIView!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var hLTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideView.applyShadow(cornerRadius: 0)
        self.setupPdfView()
        self.setupTableViewCell()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.parent!.navigationItem.title = fileName ?? ""
        self.parent!.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func setupTableViewCell() {
        let nib = UINib(nibName: "HighlightTableViewCell", bundle: nil)
        self.hLTableView.register(nib, forCellReuseIdentifier: "HighlightTableViewCell")
        self.hLTableView.dataSource = self
        self.hLTableView.delegate = self
        self.hLTableView.estimatedRowHeight = 50
        self.hLTableView.rowHeight = UITableView.automaticDimension
        
    }
    
    func setupPdfView() {
        let menuItem = UIMenuItem(title: "Add Highlight", action: #selector(addHighlight))
        UIMenuController.shared.menuItems = [menuItem]
        let _ = filePath!.startAccessingSecurityScopedResource()
        
        pdfView = PDFView(frame: self.contentPdfView.bounds)
        self.contentPdfView.addSubview(pdfView)
        pdfView!.document = PDFDocument(url: filePath!)
        
        filePath!.stopAccessingSecurityScopedResource()
        
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @objc func addHighlight() {
        //munculin sidebar kanan
        self.toggleSideBar()
        //highlight di page dikasih warna default
        highlightSelection()
        
        //highlight text simpan di core data
        //simpan posisi highlight dan selection line di core data
    }
    
    func highlightSelection() {
        let selections = pdfView!.currentSelection
        //        print(selections?.string)
        //        let lines = selections?.selectionsByLine()
        //        print(lines?.count)
        
        let lines = selections?.selectionsByLine()
        print(lines?.count ?? selections as Any)
        
        for selection in lines! {
            print (selection.pages)
            let highlight = PDFAnnotation(bounds: selection.bounds(for: selection.pages[0]), forType: .highlight, withProperties: nil)
            
            highlight.color = UIColor.yellow
            selection.pages[0].addAnnotation(highlight)
        }
        
    }
    
    func toggleSideBar() {
        self.isHiddenSideView = !self.isHiddenSideView
        
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 1,
            options: [],
            animations: {
                self.sideView.isHidden = self.isHiddenSideView
                self.sideView.alpha = self.isHiddenSideView ? 0 : 1
            },
            completion: nil
        )
    }
    
}

extension DocumentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.highLights.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hello")
        let setIsHidden = !highLights[indexPath.row]
        self.highLights[indexPath.row] = setIsHidden
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighlightTableViewCell", for: indexPath) as! HighlightTableViewCell
        cell.hLDetailStackView.isHidden = self.highLights[indexPath.row]
//        cell.hlDetailView.alpha = self.highLights[indexPath.row] ? 0 : 1
//        cell.hlDetailView.isHidden = true
//        cell.contentView.frame.width = cell.contentView.frame.width - 50
        return cell
            
            
        }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {

        return 50
    }
        
}
