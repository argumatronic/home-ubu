data Price = Price Integer deriving (Eq, Show)
-- Price has one argument; needs Integer in scope to construct these values

data Manufacturer = Mini 
                   | Mazda
                   | Tata 
                   deriving (Eq, Show)

data Airline = DogeAir
               | CatapultsRUs
               | TakeYourChancesUnited
               deriving (Eq, Show)
-- sum types with no arguments

data Vehicle =
      Car Manufacturer Price
    | Plane Airline
    deriving (Eq, Show)
-- sum type where the data constructors have arguments
-- as with Price Integer, all these types have to be in scope to construct a value
-- how do we construct values of these types?







myCar = Car Mini (Price 14000)
urCar = Car Mazda (Price 20000)
clownCar = Car Tata (Price 7000)
doge = Plane DogeAir
-- what is the type of myCar?


vehicles = [myCar, urCar, clownCar, doge]
-- Prelude> areCars vehicles
-- Prelude> areCars (take 3 vehicles)


isCar :: Vehicle -> Bool
isCar = undefined

isPlane :: Vehicle -> Bool
isPlane = undefined

areCars :: [Vehicle] -> [Bool]
areCars = undefined

getManu :: Vehicle -> Manufacturer
getManu = undefined




isCar :: Vehicle -> Bool
isCar (Car _ _) = True
isCar _ = False

isPlane :: Vehicle -> Bool
isPlane (Plane _) = True
isPlane _ = False

areCars :: [Vehicle] -> Bool
areCars = all isCar

getManu :: Vehicle -> Manufacturer
getManu (Car manu _) = manu
-- will it work on Plane data?




