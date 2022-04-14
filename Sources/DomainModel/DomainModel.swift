struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money {
    var amount: Int
    var currency: String
    
    init(amount amt: Int, currency curr: String) {
        self.amount = amt
        self.currency = curr
    }
    
    func convert(_ name: String) -> Money {
        var currAmount = self.amount
        
        // Convert to USD first
        if (self.currency == "GBP") {
            currAmount *= 2
        } else if (self.currency == "EUR") {
            currAmount *= 2
            currAmount /= 3
        } else if (self.currency == "CAN") {
            currAmount *= 4
            currAmount /= 5
        }
        
        // Convert to directed currency
        if (name == "GBP") {
            currAmount /= 2
        } else if (name == "EUR") {
            currAmount /= 2
            currAmount *= 3
        } else if (name == "CAN") {
            currAmount /= 4
            currAmount *= 5
        }
        
        return Money(amount:currAmount, currency:name)
       
    }
    
    func add(_ money: Money) -> Money{
        let converted = money.convert(self.currency).amount
        
        return Money(amount:converted + self.amount, currency: self.currency)
    }
    
    func subtract(_ money: Money) -> Money{
        let converted = money.convert(self.currency).amount
        
        return Money(amount:self.amount - converted, currency: self.currency)
    }
}

////////////////////////////////////
// Job
//
public class Job {
    var title: String
    var type: JobType
    
    init(title:String, type: JobType) {
        self.title = title
        self.type = type
    }
    
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    
    func calculateIncome() -> Int {
        var amount = self.type
        type.self
        if (amount is Double) {
            
        }
    }
}

////////////////////////////////////
// Person
//
public class Person {
}

////////////////////////////////////
// Family
//
public class Family {
}
