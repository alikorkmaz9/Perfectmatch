//
//  WelcomeViewController.swift
//  Perfectmatch
//
//  Created by Ali Korkmaz on 25.02.2021.
//

import UIKit

class WelcomeViewController: UIViewController {
    let titles = ["Welcome","Solve","Match", "Date"]
    
    @IBOutlet var holderView: UIView!
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configure()
    }
    
    private func configure() {
        // set up scrollview
        
        scrollView.frame = holderView.bounds
        holderView.addSubview(scrollView)
        
        
        for x in 0..<titles.count {
            let pageView = UIView(frame: CGRect(x: CGFloat(x) * (holderView.frame.size.width), y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            scrollView.addSubview(pageView)
            
            // Title, image, button
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: pageView.frame.size.width-20, height: 120))
            let imageView = UIImageView(frame: CGRect(x: 10, y: 10+110, width: pageView.frame.size.width - 20, height: pageView.frame.size.height - 60 - 130 - 40))
            let symbolOne = UIImageView(frame: CGRect(x: pageView.bounds.midX - 45, y: pageView.frame.size.height - 170, width: pageView.frame.size.width-400, height: pageView.frame.size.height - 485))
            let symbolTwo = UIImageView(frame: CGRect(x: pageView.bounds.midX - 15, y: pageView.frame.size.height - 170, width: pageView.frame.size.width-400, height: pageView.frame.size.height - 485))
            let symbolThree = UIImageView(frame: CGRect(x: pageView.bounds.midX + 15, y: pageView.frame.size.height - 170, width: pageView.frame.size.width-400, height: pageView.frame.size.height - 485))
            let symbolFour = UIImageView(frame: CGRect(x: pageView.bounds.midX + 45, y: pageView.frame.size.height - 170, width: pageView.frame.size.width-400, height: pageView.frame.size.height - 485))
            let button = UIButton(frame: CGRect(x: 10, y: pageView.frame.size.height-60, width: pageView.frame.size.width-20, height: 50))
            
            label.textAlignment = .center
            label.font = UIFont(name: "Helvetica-Bold", size: 32)
            pageView.addSubview(label)
            label.text = titles[x]
            
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "welcome_\(x+1)")
            pageView.addSubview(imageView)
            
            symbolOne.contentMode = .scaleAspectFit
            symbolTwo.contentMode = .scaleAspectFit
            symbolThree.contentMode = .scaleAspectFit
            symbolFour.contentMode = .scaleAspectFit
            let smallConfiguration = UIImage.SymbolConfiguration(scale: .small)
            symbolOne.image = UIImage(systemName: "1.circle.fill", withConfiguration: smallConfiguration)
            symbolTwo.image = UIImage(systemName: "2.circle", withConfiguration: smallConfiguration)
            symbolThree.image = UIImage(systemName: "3.circle", withConfiguration: smallConfiguration)
            symbolFour.image = UIImage(systemName: "4.circle", withConfiguration: smallConfiguration)
            switch x {
            case 1:
                symbolTwo.image = UIImage(systemName: "2.circle.fill", withConfiguration: smallConfiguration)
                symbolThree.image = UIImage(systemName: "3.circle", withConfiguration: smallConfiguration)
                symbolFour.image = UIImage(systemName: "4.circle", withConfiguration: smallConfiguration)
            case 2:
                symbolTwo.image = UIImage(systemName: "2.circle.fill", withConfiguration: smallConfiguration)
                symbolThree.image = UIImage(systemName: "3.circle.fill", withConfiguration: smallConfiguration)
                symbolFour.image = UIImage(systemName: "4.circle", withConfiguration: smallConfiguration)
            case 3:
                symbolTwo.image = UIImage(systemName: "2.circle.fill", withConfiguration: smallConfiguration)
                symbolThree.image = UIImage(systemName: "3.circle.fill", withConfiguration: smallConfiguration)
                symbolFour.image = UIImage(systemName: "4.circle.fill", withConfiguration: smallConfiguration)
            default:
                print("Done")
            }
            symbolOne.tintColor = .black
            symbolTwo.tintColor = .black
            symbolThree.tintColor = .black
            symbolFour.tintColor = .black
            pageView.addSubview(symbolOne)
            pageView.addSubview(symbolTwo)
            pageView.addSubview(symbolThree)
            pageView.addSubview(symbolFour)
            
            
            
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .black
            button.setTitle("Continue", for: .normal)
            if x == 3 {
                button.setTitle("Go", for: .normal)
            }
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            button.tag = x+1
            pageView.addSubview(button)
        }
        scrollView.contentSize = CGSize(width: holderView.frame.size.width*4, height: 0)
        scrollView.isPagingEnabled = true
    }
    
    @objc func didTapButton(_ button: UIButton) {
        if button.tag < titles.count {
            //scroll to next page
            scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
        } else {
            //dismiss
            performSegue(withIdentifier: "toQuestionVC", sender: nil )
        }
    }
}
