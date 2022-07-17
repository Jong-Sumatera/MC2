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
    
    var pdfView: PDFView!
    var isHiddenSideView: Bool = true
    
    var highLightsIsOpen: [Bool] = []
    var highlights: [HighlightViewModel] = []
    var highlightsTranslations: [String] = []
    
    var defaultColor: UIColor = UIColor.yellow
    
    @IBOutlet weak var contentPdfView: UIView!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var hLTableView: UITableView!
    
    var highlightListVM = HighlightsListViewModel()
    var translationVM = AddTranslationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideView.applyShadow(cornerRadius: 0)
        self.setupPdfView()
        self.setupTableViewCell()
        do {
            highlightListVM.delegate = self
            highlightListVM.getHighLightsfromFile(fileVM: file)
            self.highlights = highlightListVM.highlights
            self.highLightsIsOpen = Array(repeating: false, count: highlights.count)
            self.highlightsTranslations = Array(repeating: "", count: highlights.count)
        } catch {
            print(error.localizedDescription)
        }
        addHighlightOnPage()
        
        NotificationCenter.default.addObserver(forName: .PDFViewAnnotationHit, object: nil, queue: nil) { [self] (notification) in
            if let annotation = notification.userInfo?["PDFAnnotationHit"] as? PDFAnnotation {
                let selectedHighlightIndex: Int
                for (index, highlight) in highlights.enumerated() {
                    if highlight.highlightId?.uuidString == annotation.fieldName {
                        selectedHighlightIndex = index
                        print(selectedHighlightIndex)
                        self.highLightsIsOpen[selectedHighlightIndex] = true
                        self.hLTableView.reloadRows(at: [IndexPath(row: selectedHighlightIndex, section: 0)], with: .none)
                        self.hLTableView.selectRow(at: IndexPath(row: selectedHighlightIndex, section: 0), animated: true, scrollPosition: .top)
                        break;
                    }
                }
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
        self.toggleSideBar(isHide: false)
        
        //simpan posisi highlight dan selection line di core data
        var highlight = addHighlightToCoreData(selections: selections)
                highLightsIsOpen.insert(true, at: 0)
        
        
        //get translated text
        
        //        self.getTranslation(q: (selections?.string)!)
    }
    
    func getTranslation(q: String) -> String {
        var res = "loading"
        GTranslation.shared.translateText(q: q, targetLanguage: "id", callback: { text in
            res = text
            //            self.highlightsTranslations.insert(text, at: 0)
            //            DispatchQueue.main.async {
            //                self.hLTableView.reloadData()
            //            }
        })
        return res
    }
    
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
        
        
        translationVM.text = text
        translationVM.translationText = getTranslation(q: text)
        let translation = translationVM.addTranslation()
        
        let highlightVM = AddHighlightViewModel()
        highlightVM.text = text
        highlightVM.color = self.defaultColor
        let res = highlightVM.addHighlight(id: id, fileVM: file, selectionsVM: sLines, translation: translation)
        return res
    }
    
    func addHighlightOnPage() {
        for highlight in self.highlights {
            for selection in highlight.selections {
                print(selection.page)
                highlightSelection(fieldName: selection.selectionId, bounds: selection.bounds, pdfPage: (pdfView.document?.page(at: selection.page))!, color: highlight.color)
            }
        }
    }
    
    func highlightSelection(fieldName: String, bounds: CGRect, pdfPage: PDFPage, color: UIColor) {
        
        let highlight = PDFAnnotation(bounds: bounds, forType: .highlight, withProperties: nil)
        highlight.color = color
        highlight.fieldName = fieldName
        pdfPage.addAnnotation(highlight)
        
    }
    
    func toggleSideBar(isHide: Bool) {
        self.isHiddenSideView = isHide
        
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

extension DocumentViewController: HighlightsListViewModelDelegate {
    func didChangeContent(_ highlights: [HighlightViewModel]) {
        self.highlights = highlights
        DispatchQueue.main.async {
            self.hLTableView.reloadData()
        }
    }
}

extension DocumentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("table~!!!!")
        return self.highlights.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hello")
        self.highLightsIsOpen[indexPath.row].toggle()
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighlightTableViewCell", for: indexPath) as! HighlightTableViewCell
        cell.hLDetailStackView.isHidden = !self.highLightsIsOpen[indexPath.row]
        cell.hLText.text = highlights[indexPath.row].text
        //        cell.translationText.text = highlightsTranslations[indexPath.row] ?? ""
        //        cell.hlDetailView.alpha = self.highLights[indexPath.row] ? 0 : 1
        //        cell.hlDetailView.isHidden = true
        //        cell.contentView.frame.width = cell.contentView.frame.width - 50
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
}
