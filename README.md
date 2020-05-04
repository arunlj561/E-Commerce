# E-Commerce
E-Commerce Sample app with using storage as Core-Data, MVC Architecture with help of NSFetchResultsController. It has Category and then Products related to respective category. You can add product to cart and then remove from cart. Add product to wishlist. There is also Product details screen.


# NSFetchResultsController
https://developer.apple.com/documentation/coredata/nsfetchedresultscontroller
Using NSFetchResultsController makes look table view or collection view rendering from CoreData easy. It is Bind with CoreData, as there is any change in coredata it callbacks delegate and we get notify and can perfrom respective actions. 

No need of creating Array of CoreData entity, just create a variable with NSFetchresultsController, with predicate to filter out the query. Work when have only single Entity Object related to TableView or CollectionView.
For more details checkout - https://www.hackingwithswift.com/read/38/10/optimizing-core-data-performance-using-nsfetchedresultscontroller
 
