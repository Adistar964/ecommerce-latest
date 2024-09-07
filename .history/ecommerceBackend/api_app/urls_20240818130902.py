
from django.urls import path
from . import views # remember this import-statement!

# this will have all our api_app's urls

urlpatterns = [
    # also, while requesting from frontend,
    #  make sure to put that trailing slash in the url and the capital letters
    path("addUserDoc/",views.addUserDoc),
    path("updateUserDoc/",views.updateUserDoc),
    path("getCart/",views.getCart),
    path("getFavourites/",views.getFavourites),
    path("getproducts/",views.getProducts),
    path("getSingleProduct/",views.getSingleProduct),
    # below will fetch search results based on what user searched(search_text)
    #  and will also sort accordingly with pageNumbers for pagination
    # also page numbers start from 0
    path("getSearchResults/<str:search_text>/<str:sort_by>/<int:page_number>/",views.getSearchResults), 
    # basically for cookie/discount/2:
    # it would mean we want search results for "cookie" and it should be sorted by "discount" and that we r on page-number 2
    path("getFilterOptions/<str:search_text>/", views.getFilterValues), # this one returns the data needed to show in filter-options-screen
    path("getHomePageContent/",views.getHomePage2),
   
    ### and then comes miscellaneous urls that retrieves list of all brands, categories,etc...
    path("fetchAllProductCategories/", views.fetchAllProductCategories),
    path("fetchAllProductTypes/", views.fetchAllProductTypes), # fetches all the product-types corresponding to a category
    path("fetchAllProductBrands/", views.fetchAllProductBrands), # fetches all the brands corresponding to a category

    ### then comes payment-related urls
    path("makePayment/",views.makePayment),
    path("addOrder/",views.addOrder),
    path("getOrdersFromDB/<str:user_id>/",views.getOrdersFromDB), # will fetch orders for that specific user
    path("getSingleOrder/",views.getSpecificOrder), # will fetch that "one" order
    path("getSlots/", views.getSlots), # gets all the slots with their availibilty , so that the user can choose one from the frontend
    path("addOrderToSlot/", views.addOrderToSlot), # after an order is created, that order's id is added to its specified slot in the db
    
    #### then comes urls that will be used when we add mock data to our ecommerce
    path("makeChangesAfterAddingMock/",views.makeChangesAfterAddingMock),
    path("test/",views.test),
]