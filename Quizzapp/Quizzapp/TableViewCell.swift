//
//  TableViewCell.swift
//  Quizzapp
//
//  Created by Ethan Hess on 1/31/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var titleLabel = UILabel()
    var scoreLabel = UILabel()
    var cardCountLabel = UILabel()
    var graphView = UIView()
    
    //count variables passed to cell from index path method 
    var rightCount = 0
    var wrongCount = 0
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(red: (45)/255, green: (88)/255, blue: (170)/255, alpha: 1)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardCountLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        graphView.translatesAutoresizingMaskIntoConstraints = false
        
//        titleLabel = UILabel(frame: CGRectMake(20, 10, self.frame.size.width - 40, 60))
//        titleLabel = UILabel()
        titleLabel.font = UIFont(name: "Chalkduster", size: 18)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = UIColor.whiteColor()
        
        
//        cardCountLabel = UILabel(frame: CGRectMake(20, 80, self.frame.size.width - 40, 50))
//        cardCountLabel = UILabel()
        cardCountLabel.font = UIFont(name: "Chalkduster", size: 16)
        cardCountLabel.backgroundColor = UIColor.clearColor()
        cardCountLabel.textAlignment = NSTextAlignment.Center
        cardCountLabel.textColor = UIColor.whiteColor()
        
        
//        scoreLabel = UILabel(frame: CGRectMake(20, 140, self.frame.size.width - 40, 50))
//        scoreLabel = UILabel()
        scoreLabel.font = UIFont(name: "Chalkduster", size: 16)
        scoreLabel.textAlignment = NSTextAlignment.Center
        scoreLabel.backgroundColor = UIColor.clearColor()
        scoreLabel.textColor = UIColor.whiteColor()
        
//        graphView = UIView()
        graphView.backgroundColor = UIColor.purpleColor()
        graphView.layer.cornerRadius = 10
        
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(cardCountLabel)
        self.contentView.addSubview(scoreLabel)
        self.contentView.addSubview(graphView)
        
        
        setUpConstraints()


        
    }
    
    func setUpConstraints() {
        
        let viewsDict : [String : AnyObject] = ["count": cardCountLabel,"title": titleLabel, "score": scoreLabel, "graph": graphView]
        
        let titleHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[title]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        let titleVConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[title(50)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        
        let cardHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[count]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        let cardVConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-70-[count(50)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        
        let scoreHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[score]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        let scoreVConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-140-[score(50)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        
        let graphHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[graph]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        let graphVConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-200-[graph(50)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        
        self.contentView.addConstraints(titleHConstraints)
        self.contentView.addConstraints(titleVConstraints)
        self.contentView.addConstraints(cardHConstraints)
        self.contentView.addConstraints(cardVConstraints)
        self.contentView.addConstraints(scoreHConstraints)
        self.contentView.addConstraints(scoreVConstraints)
        self.contentView.addConstraints(graphHConstraints)
        self.contentView.addConstraints(graphVConstraints)
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
