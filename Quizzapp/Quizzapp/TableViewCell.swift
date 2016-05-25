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
    var backgroundImageView = UIImageView()
    
    //
    var gradeImageView = UIImageView()
    
    var rightCountView : UIView!
    var wrongCountView : UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.layer.masksToBounds = true
        
        self.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardCountLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        graphView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        titleLabel.font = UIFont(name: cFont, size: 18)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = UIColor.whiteColor()
        bringSubviewToFront(titleLabel)
        

        cardCountLabel.font = UIFont(name: cFont, size: 16)
        cardCountLabel.backgroundColor = UIColor.clearColor()
        cardCountLabel.textAlignment = NSTextAlignment.Center
        cardCountLabel.textColor = UIColor.whiteColor()
        bringSubviewToFront(cardCountLabel)
        

        scoreLabel.font = UIFont(name: cFont, size: 16)
        scoreLabel.textAlignment = NSTextAlignment.Center
        scoreLabel.backgroundColor = UIColor.clearColor()
        scoreLabel.textColor = UIColor.whiteColor()
        bringSubviewToFront(scoreLabel)
        
        backgroundImageView.layer.masksToBounds = true
        backgroundImageView.image = UIImage(named: "quizCellBackground")
        sendSubviewToBack(backgroundImageView)
        
        graphView.layer.masksToBounds = true
        graphView.layer.cornerRadius = 10
        bringSubviewToFront(graphView)
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(cardCountLabel)
        self.contentView.addSubview(scoreLabel)
        self.contentView.addSubview(graphView)

        self.contentView.insertSubview(backgroundImageView, atIndex: 0)
        
        setUpConstraints()

        graphView.backgroundColor = UIColor(patternImage: UIImage(named:"graphBackground")!)
        
        
    }
    
    func setRightAndWrongCount(right: Int, wrong: Int) {
        
        //set up graph view subviews
        
        let rightBarLength = CGFloat(right * 10)
        let rightViewFrame = CGRectMake(20, 10, rightBarLength, 10)
        
        rightCountView = UIView(frame: rightViewFrame)
        rightCountView.layer.cornerRadius = 3
        rightCountView.layer.masksToBounds = true
        
        let bgImageRight = UIImageView(frame: rightCountView.bounds)
        bgImageRight.layer.masksToBounds = true
        bgImageRight.image = UIImage(named: "rightCountBackground")
        rightCountView.addSubview(bgImageRight)
        
        graphView.addSubview(rightCountView)
        
        //
        
        let wrongBarLength = CGFloat(wrong * 10)
        let wrongViewFrame = CGRectMake(20, 30, wrongBarLength, 10)
        
        wrongCountView = UIView(frame: wrongViewFrame)
        wrongCountView.layer.cornerRadius = 3
        wrongCountView.layer.masksToBounds = true
        
        let bgImageWrong = UIImageView(frame: wrongCountView.bounds)
        bgImageWrong.layer.masksToBounds = true
        bgImageWrong.image = UIImage(named: "wrongCountBackground")
        wrongCountView.addSubview(bgImageWrong)
        
        graphView.addSubview(wrongCountView)
    }
    
    func setUpConstraints() {
        
        let viewsDict : [String : AnyObject] = ["count": cardCountLabel,"title": titleLabel, "score": scoreLabel, "graph": graphView, "image": backgroundImageView]
        
        let titleHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[title]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        let titleVConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[title(50)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        
        let cardHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[count]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        let cardVConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-70-[count(50)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        
        let scoreHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[score]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        let scoreVConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-140-[score(50)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        
        let graphHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[graph]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        let graphVConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-200-[graph(50)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        
        let bgImageHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[image]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        let bgImageVConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[image]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        
        self.contentView.addConstraints(titleHConstraints)
        self.contentView.addConstraints(titleVConstraints)
        self.contentView.addConstraints(cardHConstraints)
        self.contentView.addConstraints(cardVConstraints)
        self.contentView.addConstraints(scoreHConstraints)
        self.contentView.addConstraints(scoreVConstraints)
        self.contentView.addConstraints(graphHConstraints)
        self.contentView.addConstraints(graphVConstraints)
        self.contentView.addConstraints(bgImageHConstraints)
        self.contentView.addConstraints(bgImageVConstraints)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
