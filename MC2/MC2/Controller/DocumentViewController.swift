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
    @IBOutlet weak var contentPdfView: UIView!
    var pdfView: PDFView!
    @IBOutlet weak var sideView: UIView!
    var isHiddenSideView: Bool = true 
    @IBOutlet weak var contentStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menuItem = UIMenuItem(title: "Add Highlight", action: #selector(addHighlight))
        UIMenuController.shared.menuItems = [menuItem]
        self.setPdfView()
    }
    
    func setPdfView() {
        let _ = filePath!.startAccessingSecurityScopedResource()
        
        pdfView = PDFView(frame: self.contentPdfView.bounds)
        self.contentPdfView.addSubview(pdfView)
        pdfView!.document = PDFDocument(url: filePath!)
        
        filePath!.stopAccessingSecurityScopedResource()
        
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        self.navigationController?.isNavigationBarHidden = true
        let height: CGFloat = 50 //whatever height you want to add to the existing height
        let bounds = self.navigationController!.navigationBar.bounds
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 20, width: bounds.width, height: bounds.height - height)
        
        self.parent!.navigationItem.title = fileName ?? ""
        self.parent!.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @objc func addHighlight() {
        //munculin sidebar kanan
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
    
    func toggleAnimated() {
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
        
//        UIView.animate(withDuration: 0.3, delay: 0) {
//            self.sideView.isHidden = self.isHiddenSideView
//            self.sideView.alpha = self.isHiddenSideView ? 0 : 1
//            print(self.isHiddenSideView)
//        }
        
    }
    
}

