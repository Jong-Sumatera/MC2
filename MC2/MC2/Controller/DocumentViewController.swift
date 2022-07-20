//
//  DocumentViewController.swift
//  MC2
//
//  Created by Widya Limarto on 29/06/22.
//

import UIKit
import PDFKit
import CoreData

class DocumentViewController: UIViewController {
    var file: FileViewModel!
    var highlightListVM : HighlightsListViewModel!
    var openSideBar: (()->())? = nil
    var setSelectedId: ((_ id: UUID?)->())? = nil
    var pdfView: PDFView!
    var isHiddenSideView: Bool = true
    
    var highlights: [HighlightViewModel] = []
    var highlightsTranslations: [String] = []
    
    var defaultColor: UIColor = UIColor.yellow
    
    @IBOutlet weak var contentPdfView: UIView!
//    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var contentStackView: UIStackView!
//    @IBOutlet weak var hLTableView: UITableView!
    

    var translationVM = AddTranslationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.sideView.applyShadow(cornerRadius: 0)
        self.setupPdfView()
        
        
        do {
            highlightListVM.delegate = self
            highlightListVM.getHighLightsfromFile(fileVM: file)
            self.highlights = highlightListVM.highlights
            print("view did load", highlights.count)
            
            self.highlightsTranslations = Array(repeating: "", count: highlights.count)
        } catch {
            print(error.localizedDescription)
        }
        addHighlightOnPage()
        
        NotificationCenter.default.addObserver(forName: .PDFViewAnnotationHit, object: nil, queue: nil) { [self] (notification) in
            
            if let annotation = notification.userInfo?["PDFAnnotationHit"] as? PDFAnnotation {
                print(annotation.fieldName)
                highlightListVM.selectedHighlightId = annotation.fieldName
                self.openSideBar!()
                
                
                
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.parent!.navigationItem.title = file?.fileTitle ?? ""
        self.parent!.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func setupPdfView() {
        let menuItem = UIMenuItem(title: "Add Highlight", action: #selector(addHighlight))
        UIMenuController.shared.menuItems = [menuItem]
        let _ = file?.fileUrl!.startAccessingSecurityScopedResource()
        
        pdfView = PDFView(frame: self.contentPdfView.bounds)
        self.contentPdfView.addSubview(pdfView)
        pdfView!.document = PDFDocument(url: file.fileUrl!)
        
        file.fileUrl!.stopAccessingSecurityScopedResource()
        
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @objc func addHighlight() {
        
        let selections = pdfView!.currentSelection
        //munculin sidebar kanan
        self.openSideBar!()
        //simpan posisi highlight dan selection line di core data
        var highlight = addHighlightToCoreData(selections: selections)
        
        setSelectedId!(highlight?.highlightId)
    }
    
//    func getTranslation(q: String) -> String {
//        var res = "loading"
//        GTranslation.shared.translateText(q: q, targetLanguage: "id", callback: { text in
//            res = text
//            //cara supaya block ini di execute dulu sebelum return gmn
//
//
//        })
//
//        return res
//    }
    
    func addHighlightToCoreData(selections: PDFSelection?) -> HighlightViewModel? {
        
        guard let lines = selections?.selectionsByLine() else {
            return nil
        }
        
        let id: UUID = UUID()
        let text: String = selections?.string ?? ""
        
        var sLines : [SelectionLineViewModel] = [SelectionLineViewModel]()
        for selection in lines {
            let bounds = selection.bounds(for: selection.pages[0])
            let selectionVM = SelectionLineViewModel(id: id, bounds: bounds, page: Int((pdfView.document?.index(for: selection.pages[0]))!))
            sLines.append(selectionVM)
            highlightSelection(fieldName: selectionVM.selectionId, bounds: bounds, pdfPage: selection.pages[0], color: self.defaultColor)
        }
        
        
//        translationVM.text = text
//        translationVM.translationText = getTranslation(q: text)
//        let translation = translationVM.addTranslation()
        
        let highlightVM = AddHighlightViewModel()
        highlightVM.text = text
        highlightVM.color = self.defaultColor
        let res = highlightVM.addHighlight(id: id, fileVM: file, selectionsVM: sLines, translation: nil)
        return res
    }
    
    func removeAllAnnotations() {
        guard let document = pdfView.document else { return }

        for i in 0..<document.pageCount {
            if let page = document.page(at: i) {
                let annotations = page.annotations
                for annotation in annotations {
                    page.removeAnnotation(annotation)
                }
            }
        }
    }
    
    func addHighlightOnPage() {
        for highlight in self.highlights {
            for selection in highlight.selections {
                highlightSelection(fieldName: selection.selectionId, bounds: selection.bounds, pdfPage: (pdfView.document?.page(at: selection.page))!, color: highlight.color)
            }
        }
    }
    
    func highlightSelection(fieldName: String, bounds: CGRect, pdfPage: PDFPage, color: UIColor) {
        
        let highlight = PDFAnnotation(bounds: bounds, forType: .highlight, withProperties: nil)
        print("color", color)
        highlight.color = color
        highlight.fieldName = fieldName
        pdfPage.addAnnotation(highlight)
        
    }
}

extension DocumentViewController: HighlightsListViewModelDelegate {
    func didChangeContent(_ highlights: [HighlightViewModel]) {
        print("did change", highlights.count)
        self.highlights = highlights
        removeAllAnnotations()
        addHighlightOnPage()
        DispatchQueue.main.async {
//            self.hLTableView.reloadData()
        }
    }
}
