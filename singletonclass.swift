
import UIKit

class singletonclass: NSObject {

    
    var apicalldict = NSArray()
    
    //for url image sign
    // for goals set in select list
    var indexgoalscall = Int()
    var indexforsessiiondetails = Int()
    var indexfordateformate = Int()
    
    var urlstring = NSString()
    var indexpath_selectGoal = Int()
    
    
    var objeccalss_studentdetails = Studnet_assignments()
    
    static let shared = singletonclass()
    
    
    var imageBase_URL = ""
    
    var objappDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    func singleton (singleton : singletonclass) -> singletonclass {
        return singleton
    }

    
    
    func getDatefromTimeStamp (str_date : String , strdateFormat: String) -> String
    {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone!
        
        let date = dateFormatter.date(from: str_date)
        
        dateFormatter.dateFormat = strdateFormat
        let datestr = dateFormatter.string(from: date!)

        return datestr
    }
    
    func convertDateformate_24_to12_andReverse (str_date : String , strdateFormat: String, inputFormat: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone!
        
        let date = dateFormatter.date(from: str_date)
        
        dateFormatter.dateFormat = strdateFormat
        let datestr = dateFormatter.string(from: date!)
                
        return datestr
    }

    
    
}
