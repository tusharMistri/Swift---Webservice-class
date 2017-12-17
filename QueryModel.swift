
import UIKit

// API parameters
let parameterCondition = "conditions"
let parameterContains = "contain"
let parameterFields = "fields"
let parameterGet = "get"
let parameterOrder = "order"
let parameterPage = "page"
let parameterLimit = "limit"
let parameterOffset = "offset"
let APIStatusParam = "code"
let successCode:Int = 200
let APIMessageParam  = "message"

class QueryModel: NSObject {
    
    var strClassname: String = ""
    var dicUpdateFields = [AnyHashable: Any]()
    var dicMain = [AnyHashable: Any]()
    var dicUpdate = [AnyHashable: Any]()
    var completionnil = [AnyHashable: Any]()
    var completionnilstring = String()
    
    // call to init
    override init()
    {
        super.init()
    }

    // CALL FOR PASS CLASSNAME INIT
    init(initWithClassName classname: String)
    {
        super.init()
        strClassname = classname
        dicMain = [AnyHashable: Any]()
        //dicUpdate = [NSMutableDictionary dictionary]
        dicMain[parameterGet] = "all"
    }
    
    // Mark 
    func loginwithCredentials(_ dicCondition: [AnyHashable: Any], withCompletion completion: @escaping (_ responsedic: [AnyHashable: Any]) -> Void)
    {
        WebServiceClass.shared.jsonCallwithData(dicData: dicCondition, ClassUrl: "\(strClassname)/login.json", completionHandler: {(Dictionaryt:NSMutableDictionary?, error: Error?) -> Void in
            if (Dictionaryt != nil)
            {
                if  (Dictionaryt?.value(forKey: APIStatusParam) ) as! Int == successCode {
                    
                    completion(Dictionaryt![self.strClassname] as! [AnyHashable : Any] )
                    CommonMethodsModel.saveAuthKeywithEmail(strEmail: Dictionaryt?.value(forKeyPath: self.strClassname.appending(".email")) as! String, apiKey: Dictionaryt?.value(forKeyPath:self.strClassname.appending(".api_plain_key")) as! String)
                }
                else{
                    
                    completion(self.completionnil)
                    CommonMethodsModel.showAlertwithTitle(strTitle: nil, message: APIMessageParam)
                }
                
            }else{
                completion(self.completionnil)
                CommonMethodsModel.showAlertwithTitle(strTitle: nil, message: (error?.localizedDescription)!)
                
            }
            
        })
        
    }

    // MARK: --- Insert Object
    func insertObject(dicDataed: [AnyHashable: Any], withCompletion completion: @escaping (_ responsedic: Any) -> Void) {
        
        WebServiceClass.shared.jsonCallwithData(dicData:dicDataed, ClassUrl: "\(strClassname)/add.json",completionHandler: {(Dictionaryt:NSMutableDictionary?, error: Error?) -> Void in
            if (Dictionaryt != nil){
                if  (Dictionaryt?.value(forKey: APIStatusParam) ) as! Int == successCode {
                    
                    completion(Dictionaryt![self.strClassname] as! NSMutableDictionary)
                }
                else{
                    completion(self.completionnil)
                    CommonMethodsModel.showAlertwithTitle(strTitle: nil, message: Dictionaryt?.value(forKeyPath: APIMessageParam) as! String)
                    
                }
            }
        })
    }
    
    
    //MARK: --- Uploading Image
    
    func uploadImage(_ imageDataed: Data, forField strFieldNamed: String, withCompletion completion: @escaping (_ imagename: String) -> Void)
    {
        
        WebServiceClass.shared.jsonCallWithImage(imageData: imageDataed, strfieldName: strFieldNamed, urlClass: "\(strClassname)/uploadImage.json", completionHandler: {(Dictionaryt:NSMutableDictionary?, error: Error?) -> Void in
            if (Dictionaryt != nil)
            {
                print("Dictionaryt \(Dictionaryt as Any)")
                
                if  (Dictionaryt?.value(forKey: APIStatusParam) ) as! Int == successCode {
                    
//                    completion(Dictionaryt?.value(forKeyPath: self.strClassname.appending(strFieldNamed)) as! String)
                    print("values : \(Dictionaryt?.value(forKey: "your-key-name") as! NSDictionary)")
                    
                    completion((Dictionaryt?.value(forKey: "your-key-name") as! NSDictionary).value(forKey: strFieldNamed) as! String)
                }
                else{
                    
                    completion(self.completionnilstring)
                    CommonMethodsModel.showAlertwithTitle(strTitle: nil, message: Dictionaryt?.value(forKeyPath: APIMessageParam) as! String)
                }
                
            }
        })
    }
    
    
  // MARK: ---  Update Object
    
    func setUpdatedFieldsAndValues(_ dicFields: [AnyHashable: Any]) {
        dicUpdate = dicFields
    }
    
    
    //MARK: ---  Set all update fields
    func updateObjectFields(_ dicfields: [AnyHashable: Any], withCompletion completion: @escaping (_ isUpdate: Bool) -> Void)
    {
        WebServiceClass.shared.jsonCallwithData(dicData:dicfields, ClassUrl: "\(strClassname)/edit.json",completionHandler: {(Dictionaryt:NSMutableDictionary?, error: Error?) -> Void in
            if (Dictionaryt != nil){
                if  (Dictionaryt?.value(forKey: APIStatusParam) ) as! Int == successCode {
                    
                    completion(true)
                }
                else{
                    completion(false)
                    CommonMethodsModel.showAlertwithTitle(strTitle: nil, message: Dictionaryt?.value(forKeyPath: APIMessageParam) as! String)
                    
                }
            }
        })

//        var dicAPI = [AnyHashable: Any]()
//        if (dicMain[parameterCondition] != nil) {
//            dicAPI[parameterCondition] = dicMain[parameterCondition]
//        }
//        dicAPI[parameterFields] = dicfields
//        
//        WebServiceClass.shared.jsonCallwithData(dicData:dicAPI , ClassUrl: "\(strClassname)/edit.json", completionHandler: {(Dictionaryt:NSMutableDictionary?, error: Error?) -> Void in
//            
//            if (Dictionaryt != nil)
//            {
//                if  (Dictionaryt?.value(forKey: APIStatusParam) ) as! Int == successCode {
//                    
//                    completion(true)
//                }
//                else{
//                    
//                    completion(false)
//                    CommonMethodsModel.showAlertwithTitle(strTitle: nil, message: Dictionaryt?.value(forKeyPath: APIMessageParam) as! String)
//                }
//            }
//        })
    }
    
    // MARK: ---  Where conditions
    func whereKey(_ field: String, equalto object: Any) {
        var dicCondition: [AnyHashable: Any]
        if (dicMain[parameterCondition] != nil) {
            
            
            dicCondition = ((dicMain[parameterCondition] as? [AnyHashable: Any]))!
        }
        else {
            dicCondition = [AnyHashable: Any]()
        }
        dicCondition[field] = object
        dicMain[parameterCondition] = dicCondition
        
    }
    
    // MARK: --- Contains Clause
    func containsObject(_ strObject: String) {
        var arrayContains: [Any]
        if (dicMain[parameterContains] != nil) {
            arrayContains = ((dicMain[parameterContains] as? [Any]))!
        }
        else {
            arrayContains = [Any]()
        }
        arrayContains.append(strObject)
        dicMain[parameterContains] = arrayContains
    }
    // MARK: --- ORDER Clause ASC
    
    func sortinAscendingwithfield(_ strFieldName: String) {
        var dicOrder: [AnyHashable: Any]
        if (dicMain[parameterOrder] != nil) {
            dicOrder = ((dicMain[parameterOrder] as? [AnyHashable: Any]))!
        }
        else {
            dicOrder = [AnyHashable: Any]()
        }
        dicOrder[strFieldName] = "ASC"
        
    }
   // MARK: --- ORDER Clause DESC
    
    func sortinDescendingwithfiled(_ strFieldName: String) {
        var dicOrder: [AnyHashable: Any]
        if (dicMain[parameterOrder] != nil) {
            dicOrder = ((dicMain[parameterOrder] as? [AnyHashable: Any]))!
        }
        else {
            dicOrder = [AnyHashable: Any]()
        }
        dicOrder[strFieldName] = "DESC"
    }
    
    // MARK: --- Get Objects
    
    func getRecordsQuerywithCompletion(_ completion: @escaping (_ Response: Any) -> Void) {
        WebServiceClass.shared.jsonCallwithData(dicData: dicMain, ClassUrl: "\(strClassname).json", completionHandler: {(Dictionaryt:NSMutableDictionary?, error: Error?) -> Void in
            if (Dictionaryt != nil)
            {
                
                if  (Dictionaryt?.value(forKey: APIStatusParam)) as! Int == successCode {
                    
                    completion(Dictionaryt?[self.strClassname] as! NSArray)
                    
                }
                else{
                    
                    completion(self.completionnil)
                    CommonMethodsModel.showAlertwithTitle(strTitle: nil, message: Dictionaryt?.value(forKeyPath: APIMessageParam) as! String)
                }
            }
            
        })
    }
    
}
