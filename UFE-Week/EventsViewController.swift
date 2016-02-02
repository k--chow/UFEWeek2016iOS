//
//  EventsViewController.swift
//  UFE-Week
//
//  Created by Kevin Chow on 1/26/16.
//  Copyright © 2016 Kevin Chow. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var events = [Event]()
    //var events2 = [Event]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadDataFromNetwork()
        
       // let event1 = Event(name: "hi", date: "yes", location: "ye", desc: "ds", photoLink: "asd", society: "asd", director: "asd")
        //events2.append(event1!);
        tableView.dataSource = self
        tableView.delegate = self
        getEvents()
        //print("hi")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if movies not nil
        return events.count;
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "EventsViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EventsViewCell
        
        let event = events[indexPath.row]
        //let title = event.name
        //let dateAndTime = event.date
        //let location = event.location
       // let imageURL = NSURL(string: event.photoLink)
        //let imageRequest = NSURLRequest(URL: imageURL!);
        /*cell.eventImageView.setImageWithURLRequest(
                imageRequest, placeholderImage: nil, success:
                { (imageRequest, imageResponse, image) -> Void in
                    
                    if imageResponse != nil {
                        print("Image was NOT cached, fade in image")
                        cell.eventImageView.alpha = 0.0
                        cell.eventImageView.image = image
                        UIView.animateWithDuration(1.3, animations: { () -> Void in
                            cell.eventImageView.alpha = 1.0
                        })
                    } else {
                        print("Image was cached so just update the image")
                        cell.eventImageView.image = image
                    }
                },
                failure: { (imageRequest, imageResponse, error) -> Void in
                    
            })*/
        
        cell.eventTitle.text = event.name
        //cell.eventDateAndTime.text = dateAndTime
        //cell.eventLocation.text = location
        return cell
    }
    
    func loadDataFromNetwork() {
        
        // Display HUD right before next request is made
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        //API Call
        let url = NSURL(string: "https://eweek2016.herokuapp.com/api/events")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    print("1")
                    
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSArray {
                                print("2")
                                print(responseDictionary.count)
                            
                            for(var i=0; i<responseDictionary.count; i++)
                            {
                                if let a = responseDictionary[i] as? NSDictionary {
                                    let name = a["name"] as? String
                                    let date = a["date"] as? String
                                    let location = a["location"] as? String
                                    let desc = a["description"] as? String
                                    let photoLink = a["image"] as? String
                                    let society = a["society"] as? String
                                    let director = a["director"] as? String
                                    let event1 = Event(name: name!, date: date!, location: location!, desc: desc!, photoLink: photoLink!, society: society!, director: director!)!
                                 self.events.append(event1)
                                    
                                }
                                
                            }
                            
                          
                            
                            

                    
                            
                            
                        
                    }
                    
                }
                
                
                
                // Hide HUD once network request comes back (must be done on main UI thread)
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                
                // ...
                print("after")
                //self.tableView.reloadData()
        });
        
        
        task.resume()
        
       
        
    }
    
    func getEvents() {
        let postEndpoint: String = "https://eweek2016.herokuapp.com/api/events"
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: postEndpoint)!
        
        // Make the POST call and handle it in a completion handler
        session.dataTaskWithURL(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            
            // Read the JSON
            do {
                
                let json: NSArray = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                print(json.count)
                for(var i=0; i<json.count; i++)
                {
                    if let a = json[i] as? NSDictionary {
                        let name = a["name"] as? String
                        let date = a["date"] as? String
                        let location = a["location"] as? String
                        let desc = a["description"] as? String
                        let photoLink = a["image"] as? String
                        let society = a["society"] as? String
                        let director = a["director"] as? String
                        let event1 = Event(name: name!, date: date!, location: location!, desc: desc!, photoLink: photoLink!, society: society!, director: director!)!

                        //print(event1.location)
                        self.events.append(event1)
                        print(self.events[i].name)
                        dispatch_async(dispatch_get_main_queue(), {
                            self.tableView.reloadData()
                        })
                        
                    }
                    else
                    {
                        print(i)
                    }
                }
                
                
                
                
                
                
                
            } catch {
                print("bad things happened")
            }
        }).resume()
        self.tableView.reloadData()
        
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
