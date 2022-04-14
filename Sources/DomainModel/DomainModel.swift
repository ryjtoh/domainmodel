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
    
    func calculateIncome(_ hours: Int) -> Int {
        switch self.type {
        case .Hourly(let value) :
            return Int(value * Double(hours))
        case .Salary(let value) :
            return Int(value)
        }
    }
    
    func raise(byAmount: Double) {
        switch self.type {
        case .Hourly(let value):
            self.type = JobType.Hourly(value + byAmount)
        case .Salary(let value):
            self.type = JobType.Salary(UInt(Double(value) + byAmount))
        }
    }
    
    func raise(byPercent: Double) {
        let decimal = (byPercent / 100.0) + 1.0
        switch self.type {
        case .Hourly(let value):
            self.type = JobType.Hourly(value * decimal)
        case .Salary(let value):
            self.type = JobType.Salary(UInt(Double(value) * decimal))
        }
    }
}

////////////////////////////////////
// Person
//
public class Person {
    var firstName: String
    var lastName: String
    var age: Int
    var job: Job?
    var spouse: Person?
    var hasSpouse: Bool
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.hasSpouse = false
    }
    
    func toString() -> String {
        return "Person: firstName: \(self.firstName) lastName: \(self.lastName) age: \(self.age) job: \(String(describing: self.job)) spouse: \(String(describing: self.spouse?.firstName))"
    }
}

//
// Family
//
public class Family {
    var members: [Person] = []
    
    init(spouse1: Person, spouse2: Person) {
        if (spouse1.hasSpouse == false && spouse2.hasSpouse == false) {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            spouse1.hasSpouse = true
            spouse2.hasSpouse = true
            self.members.append(spouse1)
            self.members.append(spouse2)
        }
    }
    
    func haveChild(_ child: Person) -> Bool {
        if (self.members[0].age > 21 || self.members[1].age > 21) {
            self.members.append(child)
            return true
        }
        return false
    }
    
    func householdIncome() -> Int {
        var total = 0
        if (self.members[0].job != nil) {
            total += (self.members[0].job?.calculateIncome(2000))!
        }
        if (self.members[1].job != nil) {
            total += (self.members[1].job?.calculateIncome(2000))!
        }
        return total
    }
}
