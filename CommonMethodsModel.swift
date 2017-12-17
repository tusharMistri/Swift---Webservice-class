import UIKit
import MBProgressHUD


let SHARED_APPDELEGATE = UIApplication.shared.delegate as! AppDelegate

let APPNAME = "Appname"


class CommonMethodsModel: NSObject
{
   
    class var sharedInstance: CommonMethodsModel {
        struct Static {
            
            static var instance: CommonMethodsModel? = nil
        }
        Static.instance = CommonMethodsModel()
        return Static.instance!
    }
    
    class func showAlertwithTitle(strTitle: String?, message strMessage: String)
    {
        let alert = UIAlertController(title: strTitle, message: strMessage, preferredStyle: .alert)
        let alertOK = UIAlertAction(title: "OK", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
        })
        alert.addAction(alertOK)
        DispatchQueue.main.async(execute: {() -> Void in
            
         SHARED_APPDELEGATE.window?.rootViewController?.present(alert, animated: true, completion: { 
            })
            })
    }
    
    class func removeAuthKey()
    {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey:"userdefaultAuthHeader")
        defaults.synchronize()
    }
    
    class func getFieldName(selector: Selector) -> String
    {
        return NSStringFromSelector(selector)
    }

    class func checkEmailValidation(strEmail: String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: strEmail)
    }
    
    class func remmove_PrefixZeroFromString(strValues: String) -> String
    {
        var str_temp = strValues
        
        let range_temp = str_temp.range(of:"^0*", options:.regularExpression)
        
        str_temp = str_temp.replacingCharacters(in:range_temp!, with:"")
        
//        print("str_temp \(str_temp)")
        
        return str_temp
        
    }

    class func checkDateGraterorNot(strOutTime :String ) -> Bool
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
//        let date1 = dateFormatter.date(from: strInTime)!
        let date2 = dateFormatter.date(from: strOutTime)!
        
        let compareResult = date2.compare(Date())
        
        if compareResult == ComparisonResult.orderedAscending
        {
            // Current date is smaller than end date.
            print("date 1 smaller than date 2")
            return false
        }
        else if compareResult == ComparisonResult.orderedDescending
        {
            // Current date is greater than end date.
            print("date 1 grater than date 2")
            return true
            
        }
        else if compareResult == ComparisonResult.orderedSame
        {
            // Current date and end date are same.
            print("date 1 and date 2 are same")
            return false
        }
        
        return false
    }

    
    class func checkTimeGraterorNot(strInTime: String , strOutTime :String ) -> Bool
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let date1 = dateFormatter.date(from: strInTime)!
        let date2 = dateFormatter.date(from: strOutTime)!
        
        let compareResult = date2.compare(date1)
        
        if compareResult == ComparisonResult.orderedAscending
        {
            // Current date is smaller than end date.
            print("date 1 smaller than date 2")
            return false
        }
        else if compareResult == ComparisonResult.orderedDescending
        {
            // Current date is greater than end date.
            print("date 1 grater than date 2")
            return true

        }
        else if compareResult == ComparisonResult.orderedSame
        {
            // Current date and end date are same.
            print("date 1 and date 2 are same")
            return false
        }

        return false
    }
    
    class func getTotalMinutes_twoDates(strStartTime: String , strendTime :String ) -> NSString
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let date1 = dateFormatter.date(from: strStartTime)!
        let date2 = dateFormatter.date(from: strendTime)!
        
        let calendar = NSCalendar.current
        
        let components1 = calendar.dateComponents([.hour , .minute], from: date1, to: date2)
        
        print("components : \(components1)")

        let minutes = Int(components1.hour! * 60)  + Int(components1.minute!)
        
        return String(minutes) as NSString
        
    }

    class func getTimeFormatFromTotalMinutes(strTotalMinutes : String) -> String
    {
        var str_Time = String()
        
        let minutes = ((Int(strTotalMinutes)! * 60) / 60) % 60
        let hours = ((Int(strTotalMinutes)! * 60) / 3600)
        
        if hours != 0
        {
            if minutes != 0
            {
                str_Time = String(hours) + " Hour " + String(minutes) + " Minute"
            }
            else
            {
                str_Time = String(hours) + " Hour"
            }
        }
        else
        {
            str_Time = String(minutes) + " Minute"
        }
        
        return str_Time
    
    }
    
    class func getTotalTime_FromTotalHours(strtotal_hours : String) -> String
    {
        var str_Time = String()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let date1 = dateFormatter.date(from: strtotal_hours)!
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.hour , .minute], from: date1)
        
                if components.hour != 0
                {
                    if components.minute != 0
                    {
                        str_Time = String(Int(components.hour!)) + " Hour " + String(Int(components.minute!)) + " Minute"
                    }
                    else
                    {
                        str_Time = String(Int(components.hour!)) + " Hour"
                    }
                }
                else
                {
                    str_Time = String(Int(components.minute!)) + " Minute"
                }
        
                return str_Time
    }

    class func seprateTwoTimeFromstring_getDifferance(strTimeString : String , seprate_by : String) -> String
    {
        var strTime = String()
        
        let array_timeSeprator = strTimeString.components(separatedBy: seprate_by) as NSArray
        
        if array_timeSeprator.count == 2
        {
            let str_TotalMin = CommonMethodsModel.getTotalMinutes_twoDates(strStartTime: array_timeSeprator.object(at: 0) as! String, strendTime: array_timeSeprator.object(at: 1) as! String)
            strTime = CommonMethodsModel.getTimeFormatFromTotalMinutes(strTotalMinutes: str_TotalMin as String)
        }
        
        return strTime
    
    }
    
    class func saveAuthKeywithEmail(strEmail: String, apiKey key: String)
    {
        let authStr: String = "\(strEmail):\(key)"
        // @"username:password";
        let authData: Data? = authStr.data(using: String.Encoding.utf8)
        let authValue = "Basic \(authData!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)))"
        let AuthHeader = UserDefaults.standard
       AuthHeader.setValue(authValue, forKey: "userdefaultAuthHeader")
        AuthHeader.synchronize()
    }
    
    class func showProgrssHUD()
    {
        DispatchQueue.main.async {
            if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
                MBProgressHUD.showAdded(to: window, animated: true)
            }
        }
    }
    
    class func HidePrgressHUD()
    {
        DispatchQueue.main.async {
            if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
                MBProgressHUD.hide(for: window, animated: true)
            }
        }
    }
    
}
