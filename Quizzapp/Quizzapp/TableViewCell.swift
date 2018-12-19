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
    var gradeImageFrame = CGRect()
    
    //subviews of subviews
    
    var graphImageView = UIView()
    var gradeImage = UIImageView() //confusing name choice, change
    
    var rightCountView = UIView()
    var wrongCountView = UIView()
    
    var bgImageRight = UIImageView()
    var bgImageWrong = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        switch screenWidth {
        case 414:
            gradeImageFrame = CGRect(x: 210, y: 0, width: 50, height: 50)
            break
        
        case 375:
            gradeImageFrame = CGRect(x: 180, y: 0, width: 50, height: 50)
            break
        
        case 320:
            gradeImageFrame = CGRect(x: 125, y: 0, width: 50, height: 50)
        
            break
        default:
            gradeImageFrame = CGRect(x: 180, y: 0, width: 50, height: 50)
            break
        }
        
        self.layer.masksToBounds = true
        
        self.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardCountLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        graphView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont(name: cFont, size: 18)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.white
        bringSubview(toFront: titleLabel)
        
        cardCountLabel.font = UIFont(name: cFont, size: 16)
        cardCountLabel.backgroundColor = UIColor.clear
        cardCountLabel.textAlignment = NSTextAlignment.center
        cardCountLabel.textColor = UIColor.white
        bringSubview(toFront: cardCountLabel)
        
        scoreLabel.font = UIFont(name: cFont, size: 16)
        scoreLabel.textAlignment = NSTextAlignment.center
        scoreLabel.backgroundColor = UIColor.clear
        scoreLabel.textColor = UIColor.white
        bringSubview(toFront: scoreLabel)
        
        if (scheme() != nil) {
            if scheme() == space {
                standardBackground()
            } else if scheme() == nature {
                customBackground()
            } else {
                standardBackground()
            }
        } else {
            standardBackground()
        }

        graphView.layer.masksToBounds = true
        graphView.layer.cornerRadius = 10
        bringSubview(toFront: graphView)
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(cardCountLabel)
        self.contentView.addSubview(scoreLabel)
        self.contentView.addSubview(graphView)

        self.contentView.insertSubview(backgroundImageView, at: 0)
        
        setUpConstraints()

        graphView.backgroundColor = UIColor(patternImage: UIImage(named:"graphBackground")!)
    }
    
    func scheme() -> String? {
        return UserDefaults.standard.object(forKey: schemeKey) as? String
    }
    
    func standardBackground() {
        backgroundImageView.layer.masksToBounds = true
        backgroundImageView.image = UIImage(named: "quizCellBackground")
        sendSubview(toBack: backgroundImageView)
    }
    
    func customBackground() {
        backgroundImageView.layer.masksToBounds = true
        backgroundImageView.image = UIImage(named: "WoodCell")
        sendSubview(toBack: backgroundImageView)
    }
    
    func setRightAndWrongCount(_ right: Int, wrong: Int) {
        //set up graph view subviews
        let rightBarLength = CGFloat(right * 10)
        let rightViewFrame = CGRect(x: 20, y: 10, width: rightBarLength, height: 10)
        
        rightCountView = UIView(frame: rightViewFrame)
        rightCountView.layer.cornerRadius = 3
        rightCountView.layer.masksToBounds = true
        
        bgImageRight = UIImageView(frame: rightCountView.bounds)
        bgImageRight.layer.masksToBounds = true
        bgImageRight.image = UIImage(named: "rightCountBackground")
        rightCountView.addSubview(bgImageRight)
        
        graphView.addSubview(rightCountView)
        
        let wrongBarLength = CGFloat(wrong * 10)
        let wrongViewFrame = CGRect(x: 20, y: 30, width: wrongBarLength, height: 10)
        
        wrongCountView = UIView(frame: wrongViewFrame)
        wrongCountView.layer.cornerRadius = 3
        wrongCountView.layer.masksToBounds = true
        
        bgImageWrong = UIImageView(frame: wrongCountView.bounds)
        bgImageWrong.layer.masksToBounds = true
        bgImageWrong.image = UIImage(named: "wrongCountBackground")
        wrongCountView.addSubview(bgImageWrong)
        
        graphView.addSubview(wrongCountView)
    }
    
    func setGradePicture(_ right: Int, wrong: Int) {
        //grade pic
        graphImageView = UIView(frame: gradeImageFrame)
        graphImageView.layer.masksToBounds = true
        gradeImage = UIImageView(frame: graphImageView.bounds)
        gradeImage.layer.masksToBounds = true
        
        if right == 0 && wrong == 0 {
            //set question mark image
            gradeImage.image = UIImage(named: "NoGrade")
        } else if right > wrong {
            //set doing well image
            gradeImage.image = UIImage(named: "GoodGrade")
        } else {
            //set not doing so well image
            gradeImage.image = UIImage(named: "BadGrade")
        }
        graphImageView.addSubview(gradeImage)
        //add it to graph
        graphView.addSubview(graphImageView)
    }
    
    func setUpConstraints() {
        let viewsDict : [String : AnyObject] = ["count": cardCountLabel,"title": titleLabel, "score": scoreLabel, "graph": graphView, "image": backgroundImageView]
        let titleHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[title]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        let titleVConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[title(50)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        let cardHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[count]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        let cardVConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[count(50)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        let scoreHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[score]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        let scoreVConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-140-[score(50)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        let graphHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[graph]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        let graphVConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-200-[graph(50)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        let bgImageHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[image]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        let bgImageVConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[image]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
        
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
