//
//  HomeListTableViewCell.swift
//  ChangePondTask
//
//  Created by Sasikumar Perumal on 20/02/22.
//

import UIKit

class HomeListTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var pointsLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    
    
    // MARK:- Value SetUp Using Didset
    var viewModelCell:HomeListCellViewModel? {
        
        didSet {
            
            createdDate.text = viewModelCell?.getCreatedDate
            titleLbl.text = viewModelCell?.getTitle
            authorLbl.text = viewModelCell?.getAuthor
            pointsLbl.text = "\(viewModelCell?.getPoints ?? 0)"
            scoreLbl.text = "\(viewModelCell?.getRelevencyScore ?? 0)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewBg.threeDSetupShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// MARK:- For CardView
@IBDesignable extension UIView {
    
    func threeDSetupShadow(shadowColor: UIColor = UIColor.init(red: 196.0/255, green: 196.255, blue: 196.0/255.0, alpha: 1), cornerRadius: Int = 15, showBorder: Bool = false) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowRadius = 30
        self.layer.shadowOpacity = 0.4
    }
}
