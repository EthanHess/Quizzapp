//
//  TableViewCell.swift
//  Quizzapp
//
//  Created by Ethan Hess on 1/31/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var titleLabel : UILabel!
    var scoreLabel : UILabel!
    var cardCountLabel : UILabel!
    var scoreLabelContainer : UIView!
    var scoreImageArray : [ScoreView] = []
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(red: (45)/255, green: (88)/255, blue: (170)/255, alpha: 1)
        
        titleLabel = UILabel(frame: CGRectMake(20, 10, self.frame.size.width - 40, 60))
        titleLabel.font = UIFont(name: "Chalkduster", size: 18)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = UIColor.whiteColor()
        self.addSubview(titleLabel)
        
        cardCountLabel = UILabel(frame: CGRectMake(20, 80, self.frame.size.width - 40, 50))
        cardCountLabel.font = UIFont(name: "Chalkduster", size: 16)
        cardCountLabel.backgroundColor = UIColor.clearColor()
        cardCountLabel.textAlignment = NSTextAlignment.Center
        cardCountLabel.textColor = UIColor.whiteColor()
        self.addSubview(cardCountLabel)
        
        scoreLabel = UILabel(frame: CGRectMake(20, 140, self.frame.size.width - 40, 50))
        scoreLabel.font = UIFont(name: "Chalkduster", size: 16)
        scoreLabel.textAlignment = NSTextAlignment.Center
        scoreLabel.backgroundColor = UIColor.clearColor()
        scoreLabel.textColor = UIColor.whiteColor()
        self.addSubview(scoreLabel)
        
        scoreLabelContainer = UIView(frame: CGRectMake(20, 200, self.frame.size.width - 40, 50))
        scoreLabelContainer.backgroundColor = UIColor.lightGrayColor()
        scoreLabelContainer.layer.cornerRadius = 10
        self.addSubview(scoreLabelContainer)
        
        //eventually add scoreView subviews
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
