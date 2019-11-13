# CSLExample

Simple example of why you should use Clean Swift Lite, in particular with a ViewModel implementation.

There's 3 branches:

csl: Default branch, has the implementation the way it should be\
no_viewmodel: Has a CSL implementation, but lacking ViewModels\
no_csl: Has the 'standard' Apple MVC implementation. Also, no ViewModels

# Why CSL?
Because ideally, you'd want some so called 'Separation of concern'
A View(Controller) should be doing just what it implies. It's a view, so it should just show things. 
Any user interaction with the view should not be handled by the view, but it should just let 'something' else know what happened.
Within CSL, that something is called the Presenter.

The presenter has all the necessary business logic and also is responsible for fetching any necessary data to fill the View.
The real separation is done by working with protocols like BusinessLogic & DisplayLogic. By using protocols instead of direct references between view & presenter, the code becomes extremely testable.
Why? Because protocols can really easibly be mocked during a test.
This way, all your business logic inside your presenter could be easily covered by unit tests if you desire to do so.

Another great benefit of the separation is the ability to easily replace your view with a different one.
For example:
App with both iPhone & iPad support. In this case you may opt for 2 view controllers. One for the iPhone and one for the iPad. But since you've separated your view from all your business logic, you can simply connect both views to the same presenter.
As long as they adhere to the correct protocols, everything just works!

# Why ViewModel
See for yourself. The csl branch does not crash when you press the 'Redraw' button after pressing the 'Delete from DB' button.
Both other branches do.
Probably the best way to explain it is:
You don't want your view to have a direct reference to your data object, because the view can never know what will happen with the data object in other places.
In our example, the view has a direct reference to a Realm backed data object. Some other piece of code may delete that object from the database. If you then try to access the object from your view again, you'll get a crash, because the object does not exist anymore.

By using a ViewModel, you're solving this problem. The ViewModel only contains the necessary info to fill the View. The presenter constructs your ViewModel, based on your data object.
But since all data is being copied to the ViewModel, you can then change/delete you data object, or send it on a trip to outer space...it simply does not matter, your ViewModel already has the data it needs and does not rely on the data object anymore.

Another bonus while using a ViewModel:
Your view only knows about the data it actually needs, and not about the data that may also be available.
For example, our demo project has a list of breweries. That particular view only needs to know about 2 things: the breweries ID and Name. ID because it needs to know which brewery was clicked in the list, and the name to show in the cell.
Other data from the brewery, such as type, address, website, phone is not necessary in the list. Such things may be useful for a detail view, but not for the list.
