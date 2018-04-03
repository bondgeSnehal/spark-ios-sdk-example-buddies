// Copyright 2016-2017 Cisco Systems Inc
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import SparkSDK

let peopleTableCellHeight = 80
let membershipTableCellHeight = 60
let mentionTableCellHeight = 50

class PeopleListTableCell: UITableViewCell {

    // MARK: - UI variables
    var contactModel: Contact?
    var membershipModel: Membership?
    var avatarImageView: UIImageView?
    var nameLabel: UILabel?
    var emailLabel: UILabel?
    var backView: UIView?
    var seletionImageView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - People Search Table Implementation
    init(contactModel: Contact){
        super.init(style: .default, reuseIdentifier: "PeopleListTableCell")
        self.contactModel = contactModel
        self.setUpPeopelTableSubViews()
    }
    
    func setUpPeopelTableSubViews(){
        if(self.backView != nil){
            self.backView?.removeFromSuperview()
        }
        let viewWidth = Constants.Size.screenWidth
        let viewHeight = peopleTableCellHeight
        self.backView = UIView(frame: CGRect(0, 0, Int(viewWidth),viewHeight))
        self.backView?.backgroundColor = Constants.Color.Theme.Background
        self.addSubview(self.backView!)
        
        let avatorImageView = UIImageView(frame: CGRect(x: 15, y: 10, width: 60, height: 60))
        if let avatorUrl = contactModel?.avatorUrl{
            avatorImageView.sd_setImage(with: URL(string: avatorUrl), placeholderImage: contactModel?.placeholder)
        }else{
            avatorImageView.image = contactModel?.placeholder
        }

        avatorImageView.setCorner(30)
        avatorImageView.layer.borderColor = UIColor.white.cgColor
        avatorImageView.layer.borderWidth = 2.0
 
        self.backView?.addSubview(avatorImageView)
        
        let nameLabel = UILabel(frame: CGRect(x: 85, y: 20, width: viewWidth-50, height: 20))
        nameLabel.text = contactModel?.name
        nameLabel.textAlignment = .left
        nameLabel.textColor = Constants.Color.Theme.DarkControl
        nameLabel.font = Constants.Font.Home.Title
        self.backView?.addSubview(nameLabel)
        
        let emailLabel = UILabel(frame: CGRect(x: 85, y: 40, width: viewWidth-50, height: 20))
        emailLabel.text = contactModel?.email
        emailLabel.textAlignment = .left
        emailLabel.textColor = Constants.Color.Theme.MediumControl
        emailLabel.font = Constants.Font.Home.Comment
        self.backView?.addSubview(emailLabel)
        
        let line = CALayer()
        line.frame = CGRect(x: 15.0, y: Double(peopleTableCellHeight)-1.0, width: Double(viewWidth-30.0), height: 0.5)
        line.backgroundColor = Constants.Color.Theme.MediumControl.cgColor
        self.backView?.layer.addSublayer(line)
    }
    
    // MARK: - Room Creatation Table cell Implementation
    init(searchedContactModel: Contact){
        super.init(style: .default, reuseIdentifier: "PeopleListTableCell")
        self.contactModel = searchedContactModel
        self.selectionStyle = .none
        self.setUpRoomCreatePeopleTableSubViews()
    }
    
    func setUpRoomCreatePeopleTableSubViews(){
        if(self.backView != nil){
            self.backView?.removeFromSuperview()
        }
        let viewWidth = Constants.Size.screenWidth - 60
        let viewHeight = peopleTableCellHeight
        self.backView = UIView(frame: CGRect(0, 0, Int(viewWidth),viewHeight))
        self.backView?.backgroundColor = UIColor.white
        self.addSubview(self.backView!)
        
        let avatorImageView = UIImageView(frame: CGRect(x: 15, y: 10, width: 60, height: 60))
        if let avatorUrl = contactModel?.avatorUrl{
            avatorImageView.sd_setImage(with: URL(string: avatorUrl), placeholderImage: contactModel?.placeholder)
        }else{
            avatorImageView.image = contactModel?.placeholder
        }
        
        avatorImageView.setCorner(30)
        avatorImageView.layer.borderColor =  Constants.Color.Theme.Background.cgColor
        avatorImageView.layer.borderWidth = 2.0
        self.backView?.addSubview(avatorImageView)
        
        let nameLabel = UILabel(frame: CGRect(x: 85, y: 20, width: viewWidth-50, height: 20))
        nameLabel.text = contactModel?.name
        nameLabel.textAlignment = .left
        nameLabel.textColor = Constants.Color.Theme.DarkControl
        nameLabel.font = Constants.Font.Home.Title
        self.backView?.addSubview(nameLabel)
        
        let emailLabel = UILabel(frame: CGRect(x: 85, y: 40, width: viewWidth-50, height: 20))
        emailLabel.text = contactModel?.email
        emailLabel.textAlignment = .left
        emailLabel.textColor = Constants.Color.Theme.MediumControl
        emailLabel.font = Constants.Font.Home.Comment
        self.backView?.addSubview(emailLabel)
        
        let line = CALayer()
        line.frame = CGRect(x: 15.0, y: Double(peopleTableCellHeight)-1.0, width: Double(viewWidth-30.0), height: 0.5)
        line.backgroundColor = Constants.Color.Theme.MediumControl.cgColor
        self.backView?.layer.addSublayer(line)
        
        self.updateSelection()
    }
    
    func updateSelection(){
        if(self.contactModel?.isChoosed)!{
            if(self.seletionImageView == nil){
                self.seletionImageView = UIImageView(frame: CGRect(x:(self.backView?.frame.size.width)! - 40.0, y: ((self.backView?.frame.size.height)!/2)-15.0, width: 30.0, height: 30.0))
                self.seletionImageView?.image = UIImage(named: "icon_choosed_people")
            }
            self.backView?.addSubview(self.seletionImageView!)
        }else{
            self.seletionImageView?.removeFromSuperview()
        }
    }
    
    // MARK: - Room Membership Table Implementation
    init(membershipModel: Membership){
        super.init(style: .default, reuseIdentifier: "PeopleListTableCell")
        self.membershipModel = membershipModel
        self.setUpMemberShipCellViews()
    }
    
    func setUpMemberShipCellViews(){
        let viewWidth = Constants.Size.screenWidth
        let viewHeight = membershipTableCellHeight
        self.backView = UIView(frame: CGRect(0, 0, Int(viewWidth),viewHeight))
        self.backView?.backgroundColor = Constants.Color.Theme.Background
        self.addSubview(self.backView!)
        
        
        if(self.avatarImageView == nil){
            self.avatarImageView = UIImageView(frame: CGRect(x: 15, y: 3, width: membershipTableCellHeight-6, height: membershipTableCellHeight-6))
            self.avatarImageView?.image = UIImage(text: (membershipModel?.personEmail?.toString()[0])!.uppercased(),
                                            font: UIFont.safeFont("AvenirNext-Bold", size: 70)!,
                                            color: UIColor.white,
                                            backgroundColor: UIColor.MKColor.BlueGrey.P800,
                                            size: CGSize(90, 90)) ?? UIImage.fontAwesomeIcon(name: .userCircleO, textColor: UIColor.white, size: CGSize(width: 90, height: 90))
            self.backView?.addSubview(self.avatarImageView!)
        }
      

        if(self.nameLabel == nil){
            self.nameLabel = UILabel(frame: CGRect(x: 85, y: 10, width: viewWidth-15, height: 20))
            self.nameLabel?.text = membershipModel?.personEmail?.toString()
            self.nameLabel?.textAlignment = .left
            self.nameLabel?.font = Constants.Font.NavigationBar.Title
            self.nameLabel?.textColor =  Constants.Color.Theme.DarkControl
            self.nameLabel?.font = Constants.Font.Home.Comment
            self.backView?.addSubview(self.nameLabel!)
        }else{
           self.nameLabel?.text = membershipModel?.personEmail?.toString()
        }

        if(self.emailLabel == nil){
            self.emailLabel = UILabel(frame: CGRect(x: 85, y: 30, width: viewWidth-15, height: 20))
            self.emailLabel?.text = membershipModel?.personEmail?.toString()
            self.emailLabel?.textAlignment = .left
            self.emailLabel?.font = Constants.Font.Home.Title
            self.emailLabel?.textColor = Constants.Color.Theme.MediumControl
            self.emailLabel?.font = Constants.Font.Home.Comment
            self.backView?.addSubview(self.emailLabel!)
            
            let line = CALayer()
            line.frame = CGRect(x: 15.0, y: Double(membershipTableCellHeight)-1.0, width: Double(viewWidth-30.0), height: 0.5)
            line.backgroundColor = Constants.Color.Theme.MediumControl.cgColor
            self.backView?.layer.addSublayer(line)
        }else{
            self.emailLabel?.text = membershipModel?.personEmail?.toString()
        }

        DispatchQueue.global().async {
            SparkSDK?.people.get(personId: (self.membershipModel?.personId)!, completionHandler: { (response: ServiceResponse<Person>) in
                if let person = response.result.data {
                    DispatchQueue.main.async {
                        self.nameLabel?.text = person.displayName
                        if let avatorUrl = person.avatar{
                            self.avatarImageView?.sd_setImage(with: URL(string: avatorUrl))
                        }
                    }
                }else if let error = response.result.error {
                    print(error.localizedDescription)
                    return
                }
               
            })
        }
    }
    func updateMembershipCell(newMemberShipModel: Membership){
      
        if(self.membershipModel?.personId == newMemberShipModel.personId){
            return;
        }
        self.nameLabel?.text = membershipModel?.personEmail?.toString()
        self.emailLabel?.text = membershipModel?.personEmail?.toString()

        DispatchQueue.global().async {
            SparkSDK?.people.get(personId: (self.membershipModel?.personId)!, completionHandler: { (response: ServiceResponse<Person>) in
                if let person = response.result.data {
                    DispatchQueue.main.async {
                        self.nameLabel?.text = person.displayName
                        if let avatorUrl = person.avatar{
                            self.avatarImageView?.sd_setImage(with: URL(string: avatorUrl))
                        }
                    }
                }else if let error = response.result.error {
                    print(error.localizedDescription)
                    return
                }
                
            })
        }
    }
    
    // MARK: - Mention Table cell Implementation
    init(mentionContact: Contact){
        super.init(style: .default, reuseIdentifier: "PeopleListTableCell")
        self.contactModel = mentionContact
        self.setUpMentionPeopleCellSubViews()
    }
    
    func setUpMentionPeopleCellSubViews(){
        if(self.backView != nil){
            self.backView?.removeFromSuperview()
        }
        let viewWidth = Constants.Size.screenWidth - 30
        let viewHeight = mentionTableCellHeight
        self.backView = UIView(frame: CGRect(0, 0, Int(viewWidth),viewHeight))
        self.backView?.backgroundColor = UIColor.white
        self.addSubview(self.backView!)
        
        let avatorImageView = UIImageView(frame: CGRect(x: 10, y: 5, width: 40, height: 40))
        if let avatorUrl = contactModel?.avatorUrl{
            avatorImageView.sd_setImage(with: URL(string: avatorUrl), placeholderImage: contactModel?.placeholder)
        }else{
            avatorImageView.image = contactModel?.placeholder
        }
        
        avatorImageView.setCorner(20)
        avatorImageView.layer.borderColor =  Constants.Color.Theme.Background.cgColor
        avatorImageView.layer.borderWidth = 1.0
        self.backView?.addSubview(avatorImageView)
        
        let nameLabel = UILabel(frame: CGRect(x: 85, y: 10, width: viewWidth-50, height: 30))
        nameLabel.text = contactModel?.name
        nameLabel.textAlignment = .left
        nameLabel.textColor = Constants.Color.Theme.DarkControl
        nameLabel.font = Constants.Font.Home.Title
        self.backView?.addSubview(nameLabel)
        
        let line = CALayer()
        line.frame = CGRect(x: 15.0, y: Double(mentionTableCellHeight)-0.5, width: Double(viewWidth-15), height: 0.5)
        line.backgroundColor = Constants.Color.Theme.MediumControl.cgColor
        self.backView?.layer.addSublayer(line)
                
        self.updateSelection()
    }
    
    // MARK: - other functions
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
