//
//  testpageViewController.swift
//  SPI_Language
//
//  Created by 長澤　賢汰 on 2020/07/28.
//  Copyright © 2020 ritsuya. All rights reserved.
//

import UIKit
import Firebase

class ListPageViewController: UIViewController {
    
    //※表示内容※
    //collection名
    var contentName:String!
    //表示データを保持
    var questionArray = [questionModel](){
        didSet{
            initPageViewController()
        }
    }

    private var pageViewController: UIPageViewController!
    private var controllers: [ UIViewController ] = []

    // ① UIPageControlクラスを定義
    private var pageControl: UIPageControl!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // UIPageControlの初期化メソッドを作成
        self.setPageControl()
        loadData()
        self.initPageViewController()
    }
    
    //Firebaseから、データを取得
    func loadData(){
        questionModel.getOne(contentName) { (questions) in
            if let questions = questions{
                self.questionArray.append(contentsOf: questions)
            }else{
                //仮置している（エラー処理を作りたい)
                print("error")
            }
        }
    }

    private func initPageViewController() {
        if questionArray.count == 0 {
            return
        }else{
            //viewControllerの数を指定
            for i in 0 ... questionArray.count - 1 {
                let myViewController: UIViewController = UIViewController()
                myViewController.view.backgroundColor = .red
                myViewController.view.frame = self.view.frame
                let numberLabel = UILabel()
                numberLabel.frame = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.size.width, height: 100)
                numberLabel.textColor = UIColor.black
                DispatchQueue.main.async {
                    numberLabel.text = self.questionArray[i].questionNumber?.description
                }
                myViewController.view.addSubview(numberLabel)
                self.controllers.append(myViewController)
            }
            self.pageViewController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
            self.pageViewController.setViewControllers([self.controllers[0]], direction: .forward, animated: true, completion: nil)
            self.pageViewController.dataSource = self
            self.addChild(self.pageViewController)
            self.view.addSubview(self.pageViewController.view!)
        }
    }

    private func setPageControl() {
        // PageControlの配置場所
        self.pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 190, width: UIScreen.main.bounds.width,height: 50))
        // 全ページ数
        self.pageControl.numberOfPages = self.controllers.count
        // 表示ページ
        self.pageControl.currentPage = 0
        // インジケータの色
        self.pageControl.pageIndicatorTintColor = .gray
        // 現在ページのインジケータの色
        self.pageControl.currentPageIndicatorTintColor = .red
        self.view.addSubview(self.pageControl)
    }
}

extension ListPageViewController: UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.controllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = self.controllers.firstIndex(of: viewController),
                index < self.controllers.count - 1 {
                return self.controllers[index + 1]
            } else {
                return nil
            }
        }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = self.controllers.firstIndex(of: viewController),
            index > 0 {
            return self.controllers[index - 1]
        } else {
            return nil
        }
    }
}
