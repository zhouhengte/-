//
//  NewsViewController.swift
//  仿写网易新闻
//
//  Created by 维斯顿 on 16/11/5.
//  Copyright © 2016年 维斯顿. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    var channelScrollView :UIScrollView!
    var channels :ChannelBox = ChannelBox()
    var maxChannelsCount :Int = 20
    var channelCount :Int!
    let labelMargin: CGFloat = 25
    var labelArray: [UILabel] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false

        self.navigationController?.navigationBar.barTintColor = UIColor(red: 212 / 255.0, green: 25 / 255.0, blue: 38 / 255.0, alpha: 1.0)

        //标题
        let titleView = UIView.init(frame: CGRectMake(0, 0, 50, 20))
        let titleImageView = UIImageView.init(image: UIImage.init(named: "title"))
        titleImageView.frame = CGRectMake(0, 0, 50, 20)
        titleView .addSubview(titleImageView)
        self.navigationController?.navigationBar.topItem?.titleView = titleView;
        
        //24小时
        let leftButton = UIBarButtonItem.init(image: UIImage.init(named: "top_navi_bell_normal"), style: UIBarButtonItemStyle.Done, target: self, action: #selector(leftButtonClick))
        self.navigationItem.leftBarButtonItem = leftButton
        
        channelScrollView = UIScrollView.init(frame: CGRectMake(0, 60, self.view.frame.size.width, 30))
        channelScrollView.backgroundColor = UIColor.greenColor()
        self.view.addSubview(channelScrollView)
        
        setupChannelScrollView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupChannelScrollView()
    {
        channelScrollView.showsHorizontalScrollIndicator = false
        channelCount = channels.channels.count > maxChannelsCount ? maxChannelsCount : channels.channels.count
        let labelX :([UILabel]) -> CGFloat = {
            (labels:[UILabel]) -> CGFloat in
            let lastObj = labels.last
            guard let label = lastObj else {
                return self.labelMargin
            }
            return CGRectGetMaxX(label.frame) + self.labelMargin
        }
        
        for i in 0..<channelCount {
            let label = UILabel()
            label.text = self.channels[i].channelName
            label.textColor = UIColor.blackColor()
            label.font = UIFont.systemFontOfSize(14)
            label.sizeToFit()
            label.frame.origin.x = labelX(self.labelArray)
            label.frame.origin.y = (self.channelScrollView.bounds.height -  label.bounds.height) * 0.5
            //添加点击事件
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(channelLabelClick)))
            label.userInteractionEnabled = true
            label.tag = i
            self.labelArray.append(label)
            self.channelScrollView.addSubview(label)
        }
        self.channelScrollView.contentSize = CGSizeMake(labelX(self.labelArray), 0)
        
        
    }

    func leftButtonClick(){
        NSLog("click leftButton")
    }
    
    func channelLabelClick()
    {
        NSLog("click channel")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
