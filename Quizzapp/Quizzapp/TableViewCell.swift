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
        
        titleLabel = UILabel(frame: CGRectMake(20, 10, self.frame.size.width - 20, 60))
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.backgroundColor = UIColor.whiteColor()
        titleLabel.textColor = UIColor.blackColor()
        self.addSubview(titleLabel)
        
        cardCountLabel = UILabel(frame: CGRectMake(20, 80, self.frame.size.width - 20, 50))
        cardCountLabel.backgroundColor = UIColor.whiteColor()
        cardCountLabel.textAlignment = NSTextAlignment.Center
        cardCountLabel.textColor = UIColor.blackColor()
        self.addSubview(cardCountLabel)
        
        scoreLabel = UILabel(frame: CGRectMake(20, 140, self.frame.size.width - 20, 50))
        scoreLabel.textAlignment = NSTextAlignment.Center
        scoreLabel.backgroundColor = UIColor.whiteColor()
        scoreLabel.textColor = UIColor.blackColor()
        self.addSubview(scoreLabel)
        
        scoreLabelContainer = UIView(frame: CGRectMake(20, 200, self.frame.size.width - 20, 50))
        scoreLabelContainer.backgroundColor = UIColor.lightGrayColor()
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
