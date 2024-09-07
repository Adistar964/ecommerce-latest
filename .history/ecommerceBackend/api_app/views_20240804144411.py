from rest_framework.response import Response
from rest_framework.decorators import api_view

# mongodb import
from .models import (user_doc_collection, products_collection,
                    homeContent_collection, orders_collection,
                    slots_collection)
from bson.objectid import ObjectId # to work with _id fields, as they arent string

# others
import random
import math
import requests
from datetime import datetime
from django.core.exceptions import BadRequest  # for raising errors    
# some constants
currency="qar"


@api_view(["POST"])
def addUserDoc(request):
    try:
        data = request.data
        no_of_doc_user_has = user_doc_collection.count_documents({"uid":data["uid"]})
        # we have to check if  that user already has a cart-doc in db
        # in that case we dont want to add a new cart-doc for that user
        # note:each user must have only 1 cart doc in mongodb
        # therefore, we will only create that user's doc if that user doesnt have any
        if type(data) == dict and no_of_doc_user_has == 0:
            inserted_doc = user_doc_collection.insert_one(data)
            return Response({"msg":"user's Cart document added!"})
        return Response({"msg":"couldnt add the user-cart!"})
    except Exception as e:
        print(e)
        return Response({"msg":"couldnt add the user-cart!"})

@api_view(["POST"])
def getCart(request):
    try:
        data = request.data
        uid = data["uid"]
        user_doc = user_doc_collection.find_one({"uid":uid})
        cart_items = user_doc["cart_items"]
        return Response({"cart_items":cart_items})
    except Exception as e:
        print(e)
        return Response({"msg":"notdone"})

@api_view(["POST"])
def getFavourites(request):
    try:
        data = request.data
        uid = data["uid"]
        user_doc = user_doc_collection.find_one({"uid":uid})
        user_favourites = user_doc["user_favourites"]
        return Response({"user_favourites":user_favourites})
    except Exception as e:
        print(e)
        return Response({"msg":"notdone"})

@api_view(["POST"])
def updateUserDoc(request):
    try:
        data = request.data
        uid = data["uid"]
        # items = data["items"]
        update_query = data["update_query"]
        user_doc_collection.update_one({"uid":uid},update_query)
        print("user_doc_collection updated")
        return Response({"msg":"chnaged cart!"}) # we wont basically use this response in frontend as it is useless
    except Exception as e:
        print(e)
        return Response({"msg":"notdone"})


# It is a post req, not a GET req, so that we can get querying/no-querying for products
@api_view(["POST"])
def getProducts(request):
    query = request.data
    productsFromMongo = products_collection.find(query) 
    # above will give us products, but we need them in list-format to return to frontend
    products = []
    for i in productsFromMongo:
        products.append(i)
    for i in products:
        i["_id"] = str(i["_id"]) # for json to understand, otherwise itll give error
    return Response(products)

# It is a post req, not a GET req, so that we can get querying/no-querying for products
@api_view(["POST"])
def getSingleProduct(request):
    productsFromMongo = products_collection.find({"_id":ObjectId(request.data["_id"])}) 
    # above will give us products, but we need them in list-format to return to frontend
    products = []
    for i in productsFromMongo:
        products.append(i)
    for i in products:
        i["_id"] = str(i["_id"]) # for json to understand, otherwise itll give error
    return Response(products)

# for searching:
@api_view(["POST"])
def getSearchResults(request,search_text,sort_by,page_number):
    try:
        # first enable Atlas search for your collection for doing text search from mongodb!
        # like this:
        # products_collection.create_index({
        #     "title":"text"
        # })
        searchResultsFromMongo = []
        filters = request.data["filters"] # if user sets any filter like minimum price,max price,etc...
        items_in_1_page = 18 # can be changed
        if sort_by=="relevance": # normal one(no sorting)
            searchResultsFromMongo = products_collection.find( {"$text":{"$search":search_text}, **filters} ).skip(page_number*items_in_1_page).limit(items_in_1_page)
            # .skip and .limit for pagination!
            # ** operator is basically a spread operator for dictionaries
        elif sort_by=="priceHighest": # price highest to lowest
            searchResultsFromMongo = products_collection.find( {"$text":{"$search":search_text}, **filters} ).sort({"price":-1}).skip(page_number*items_in_1_page).limit(items_in_1_page)
        elif sort_by=="priceLowest": # price lowest to highest
            searchResultsFromMongo = products_collection.find( {"$text":{"$search":search_text}, **filters} ).sort({"price":1}).skip(page_number*items_in_1_page).limit(items_in_1_page)
        elif sort_by=="discount": # sort by discount (highest discountPrice comes first)
            searchResultsFromMongo = products_collection.find( {"$text":{"$search":search_text}, **filters} ).sort({"discountPrice":-1}).skip(page_number*items_in_1_page).limit(items_in_1_page)
        elif sort_by=="alphabetical": # sort alphabetically (A-Z)
            searchResultsFromMongo = products_collection.find( {"$text":{"$search":search_text}, **filters} ).sort({"title":1}).skip(page_number*items_in_1_page).limit(items_in_1_page)
        elif sort_by=="antiAlphabetical": # sort anti-alphabetically (Z-A)
            searchResultsFromMongo = products_collection.find( {"$text":{"$search":search_text}, **filters} ).sort({"title":-1}).skip(page_number*items_in_1_page).limit(items_in_1_page)
        
        # searchResultFromMongo will give us products, but we need them in list-format to return to frontend
        searchResults = []
        for i in searchResultsFromMongo:
            searchResults.append(i)

        for product in searchResults:
            product["_id"] = str(product["_id"]) # for json to understand, otherwise itll give error

        # to find total number of pages
        number_of_items = products_collection.count_documents( filter={"$text":{"$search":search_text},**filters} )
        number_of_pages = math.ceil(number_of_items/items_in_1_page)
        # ceil => takes it to next number
        # ex: ceil(6.2) => o/p : 7

        return Response({"searchResults":searchResults,"numberOfPages":number_of_pages})

    except Exception as e:
        print(e)
        return BadRequest("Error") # if anything goes wrong!

@api_view(["GET"])
def getHomePage(request):
    homePageDocuments = homeContent_collection.find()
    homePageContent = []
    for i in homePageDocuments:
        homePageContent.append(i)
    for i in homePageContent:
        i["_id"] = str(i["_id"]) # for json to understand, otherwise itll give error
    return Response(homePageContent[0])


# there will be a wrokaround for homePage content in the future
# below is the purified version of the above function: (but make sure to do the changes in the react application)
@api_view(["GET"])
def getHomePage2(request):
    homePageDocument = dict(homeContent_collection.find_one()) # theere are many home-page-contents, but we want the latest one only
    all_products = list(products_collection.find().limit(100)) # collection of all products in our db

        
    # now also a small adjustment
    # the products array in "images and products" array contains only product_ids
    # but we want to have actual products in it
    # so we will do this:
    newHomePageDoc = dict(homePageDocument)
    newHomePageDoc["_id"] = str(newHomePageDoc["_id"]) # for json to understand, otherwise itll give error

    image_and_prodsNew = []

    for main_idx,image_and_products in enumerate(homePageDocument["images and products"]):
        image_and_prodsNew.append({"image":image_and_products["image"],"products":[]})
        for product in all_products:
            for product_id in homePageDocument["images and products"][main_idx]["products"]:
                if str(product["_id"]) == product_id:
                    image_and_prodsNew[main_idx]["products"].append(product) # appending that product into the new products array of newHomePageDoc

    newHomePageDoc["images and products"] = image_and_prodsNew
    # now for that products array in "images and products" array, we will convert the product's_id to string to pass it to json
    for image_and_products in newHomePageDoc["images and products"]:
        for product in image_and_products["products"]:
            product["_id"] = str(product["_id"]) # so that json can read it while sending it to frontend
    return Response(newHomePageDoc)


################## stripe-payments-related: #######################
import stripe
# make sure to hide below in production(secret key)
stripe.api_key = "sk_test_51J9qlHK0ixBKvwxDgAOdoIbeLOgPVpA0kCnfSqVrkCx40bpjyF9HY7qjoRqqsFnki2RvP4BP8DyrdhiRoi4Hpgyw00tnqKWTFB"

# payment handling function
@api_view(["POST"])
def makePayment(request):
    data = request.data

    # Now, this page could be used for different types of payments
    # for now, this page can be used for paying cart
    # but in future, we can have different things for which user can pay
    # That is why, we have "operation"
    if data["operation"] == "cart_purchase":

        # We will show user's cart products in checkout screen
        user_docs = user_doc_collection.find_one({"uid":data["uid"]})
        cart_array = user_docs["cart_items"] # we will get cart_items array from that user's document
        # but we will have to format that array in stripe's format as below:
        formatted_cart = []
        for product in cart_array:
            formatted_cart.append({
                "price_data":{
                    "currency":currency,
                    "product_data":{
                        "name":product["product_name"],
                        "images":[product["thumbnail"]]
                    },
                    "unit_amount":(product["price"]-product["discountPrice"])*100
                    # basically the price is: actual price minus any discount on it
                    # plus we r multiplying it by 100 as stripe expects the amount in pennies 
                    # ex: $14 should be given as: 14x100 as 1400
                },
                "quantity":product["quantity"]
            })

        # Sessions are basically checkout pages from stripe 
        # and we r giving some info on how the payment will be
        session = stripe.checkout.Session.create(
            payment_method_types=["card"], # basically paying thru credit card,
            mode="payment", # it is 'payment' if it is one-time, or it is 'subsciption' if it is monthly payment,etc...
            # return_url="http://localhost:5173/SuccessPayment/", # after payment finishes
            # cancel_url="http://localhost:5173/CancelPayment/", # incase the payment doesnt happen
            redirect_on_completion='never', # this means we want to stay in same page after payment completion, and react will handle everything once the payment is complete
            line_items=formatted_cart, # basically telling stripe what we r buying. => this will be displayed in that checkout page
            ui_mode="embedded", # means we will have that stripe page embeddded in our react app
            shipping_address_collection={"allowed_countries":["QA"]},
        )
        # now we will respond with that created session's client_id 
        # so frontend can use this client_secret to show the checkout form for the payment to happen
        return Response({"client_secret":session.client_secret,"session_id":session.id})
    else:
        # Any errors, then we will throw error!
        raise BadRequest("Error!")



# after payment completes, frontend then does a post request to this endpoint
# this is for adding a new order in the order's collection
# first see frontend to see what this function does
@api_view(["POST"])
def addOrder(request):
    data = request.data
    try:
        session = stripe.checkout.Session.retrieve(data["session_id"]) 
        newOrder = data["orderToBeInserted"] # this is to be inserted
        # now some modifications: (adding shipping_adress and totalAmount field fetched from the session)
        newOrder["shippingDetails"] = session["shipping_details"]
        newOrder["totalAmount"] = int(session["amount_total"])/100 # divide by 100 as it is in pennies
        # totalAmount => totalAmount of the whole purchase
        
        insertedOrder = orders_collection.insert_one(newOrder)
        # We will respond with the "_id" of the order-document we just inserted
        return Response({
            "order_id": str(insertedOrder.inserted_id)
            })
    except Exception as e:
        print(e)
        # Any errors, then we will throw error!
        raise BadRequest("Error!")

# this is for fetching orders
@api_view(["GET"])
def getOrdersFromDB(request, user_id):
    try:
        pending_orders = list(orders_collection.find({"uid":user_id,"status":"pending"})) # getting all "pending" orders of that specified user with this user_id
        for i in pending_orders: # then we will convert the _id field to string so that we can send it to backend in valid JSON
            i["_id"] = str(i["_id"])

        arriving_orders = list(orders_collection.find({"uid":user_id,"status":"arriving"})) # getting all "cancelled" orders of that specified user with this user_id
        for i in arriving_orders: # then we will convert the _id field to string so that we can send it to frontend in valid JSON
            i["_id"] = str(i["_id"])

        delivered_orders = list(orders_collection.find({"uid":user_id,"status":"delivered"})) # getting all "delivered" orders of that specified user with this user_id
        for i in delivered_orders: # then we will convert the _id field to string so that we can send it to backend in valid JSON
            i["_id"] = str(i["_id"])

        cancelled_orders = list(orders_collection.find({"uid":user_id,"status":"cancelled"})) # getting all "cancelled" orders of that specified user with this user_id
        for i in cancelled_orders: # then we will convert the _id field to string so that we can send it to frontend in valid JSON
            i["_id"] = str(i["_id"])
        return Response({"pending_orders":pending_orders,
                         "arriving_orders":arriving_orders,
                         "delivered_orders":delivered_orders,
                         "cancelled_orders":cancelled_orders,})
    except:
        raise BadRequest("Error!") # we will just raise error incase anything goes wrong

# this is for fetching a specific order corresponding to provided orer_id
@api_view(["POST"])
def getSpecificOrder(request):
    try:
        user_id = request.data["user_id"]
        order_id = request.data["order_id"]
        order_id = ObjectId(order_id) # converting to ObjectId type so mongodb can do the query
        order = orders_collection.find_one({"uid":user_id,"_id":order_id}) # getting that order
        # then we will convert the _id field to string so that we can send it to frontend in valid JSON
        order["_id"] = str(order["_id"])
        return Response({"order":order})
    except:
        raise BadRequest("Error!") # we will just raise error incase anything goes wrong

############## functions for delviery slots ###############3

# this will get all the available slots for a specific date passed
@api_view(["POST"])
def getSlots(request):
    date = request.data["date"] # checking slots for this date

    # this is what slot-info looks like in the db (for now we have it here, not in the db)
    slot_settings = {
        "nonWorkingDay":["Friday"], # in this day, the delivery will not be done
        "slots":[ # will have all the slots in which deivery can be done
            {"startTime":8,"endTime":10}, # 8 am to 10 am delivery slot
            {"startTime":15,"endTime":17}, # basically 3 pm to 5pm delivery slot
            {"startTime":20,"endTime":22}, # basically 8pm to 10m delivery slot
        ]
    }

    slots = [ *slot_settings["slots"] ] # this will be returned with another option => "available:True/False"

    # logic:
    # the slot becomes unavailable if:
    # there are 15 orders attached to it
    # if it booked just hour prior to its starting-time (example: if starting time is 8am, we cant book after 7am)
    # if the current time exceeds the slot-start-time (example: I cant book a slot for 8am if its already 9am)

    for slot in slots:
        slot["date"] = date # first add this property to each slot
        
        selected_date = datetime.fromisoformat(date) # our selected_date from the frontend
        selected_date_is_today = selected_date.date() == datetime.today().date() # compare them and check if user selected today's date
        time_less_than_1_hour = slot["startTime"] > (selected_date.hour) and slot["startTime"] - (selected_date.hour) == 1
        slot_time_passed = (selected_date.hour) > slot["startTime"]
        if selected_date_is_today and (slot_time_passed or time_less_than_1_hour): # the slot will be closed if the user books in time less than 1 hour before the slot begins or if user tries to book a slot after the slot-time began
            slot["available"] = False
        else:
            no_of_docs = slots_collection.count_documents({"date":date,"startTime":slot["startTime"],"endTime":slot["endTime"]})
            if no_of_docs == 0: # if this slot is not present in the db for this date
                slot["available"] = True
            elif no_of_docs != 0: # if this slot is created in the db for this date
                #  Now since we know it exists in the db, we will fetch it
                slotDocument = slots_collection.find_one({"date":date,"startTime":slot["startTime"],"endTime":slot["endTime"]})
                # In that doc, the property "orders" holds the orderID of all the orders which is supposed to be delivered in this slot
                if len(slotDocument["orders"]) < 2: # the number of those orders must not exceed 15 => basically 15 orders per slot
                    slot["available"] = True
                else:
                    slot["available"] = False

    return Response(slots) # returning the available and unavailable slots :)

# This function will add the order_id to the slot
# This function runs after creating an order
# then this newly created order's ID is added to the "orders" property of the slot in the Database
@api_view(["POST"])
def addOrderToSlot(request): # basically connects the order to a chosen slot
    data = request.data
    order_id = data["order_id"]
    slot = data["slotDetails"]
    startTime = slot["startTime"] # delivery slot's start-time
    endTime = slot["endTime"] # delivery slot's end-time
    slotDate = slot["date"] # delivert slot's date
    filter_query = {"startTime":startTime,"endTime":endTime, "date":slotDate}
    slot_present_in_DB = False if slots_collection.count_documents(filter_query) == 0 else True
    # the above statement will return true if there is a document corresponding to that slot, otherwise false  
    
    if slot_present_in_DB: # if the specified slot was already present in the DB, then we will only need to add this order's id to pre-existing list of order's ids
        update_query = { "$push":{ "orders":order_id } } # we r appending this order's id to the "orders" list of this slot in the DB
        slots_collection.update_one(filter_query,update_query)
    else: # if the specified slot was not found in the db, then we create one with this order's id in the "orders" list in this slot in the db
        newSlotDocument = {
            "startTime":startTime,"endTime":endTime,
            "date":slotDate,
            "orders":[order_id]
        }
        slots_collection.insert_one(newSlotDocument)
    
    # then atlast return a repsonse
    return Response([]) # we dont have anything to return lol, so we will return this empty list


# as the products are generated by mockaroo, we dont have any real images
# This function will give real-like images to our products from unsplash api
@api_view(["GET"])
def makeChangesAfterAddingMock(request):
    # putting generated images for our products!
    
    # collect all products that still dont have a real_image_url, i.e, their thumbnail contains dummyimage.com
    all_docs_mongo = products_collection.find({"thumbnail":{"$regex":"dummyimage.com"}})
    # all_docs_mongo = products_collection.find({})
    all_docs = [*all_docs_mongo]
    for doc in all_docs:
        images_access_urls = [
                # "https://placehold.co/710x721/yellow/FFFFFF.png",
                # "https://placehold.co/710x721/red/FFFFFF.png",
                # "https://placehold.co/710x721/green/FFFFFF.png",
                # "https://placehold.co/710x721/blue/FFFFFF.png", # not this!
                f"https://source.unsplash.com/710x720/?{doc["title"].split(" ")[0]}",
                f"https://source.unsplash.com/711x720/?{doc["title"].split(" ")[0]}",
                f"https://source.unsplash.com/710x721/?{doc["title"].split(" ")[0]}",
                f"https://source.unsplash.com/710x722/?{doc["title"].split(" ")[0]}",
            ]
        image_real_urls = []
        try:
            for url in images_access_urls:
                img_req = requests.get(url)
                image_real_urls.append(img_req.url)
            thumbnail_access_url = f"https://source.unsplash.com/220x220/?{doc["title"].split(" ")[0]}"
            thmbnl_req = requests.get(thumbnail_access_url)
            thumbnail_real_url = thmbnl_req.url
            products_collection.update_one({"_id":doc["_id"]},
                                    {
                                            "$set":{"thumbnail":thumbnail_real_url}
                                    })
            products_collection.update_one({"_id":doc["_id"]}, {
                "$set":{"images":image_real_urls}
            })
        except Exception as e:
            print(e)

    # also, we dont want discountPrice in all the documents
    # so we will remove discountPrice from some randomly selected docs
    first_150_docs = products_collection.find({})
    for idx,doc in enumerate(first_150_docs):
        # basically there is discount for first 200 prods 
        # and then no discount for next prods
        if(idx<200):
            products_collection.update_one({"_id":doc["_id"]},{
                "$set":{
                    "discountPrice":random.randint(5,100),
                    "description":doc["description"][0:300] # we r also shortening the desc
                    }
            })
            
        else:
            products_collection.update_one({"_id":doc["_id"]},{
                "$set":{"discountPrice":0}
            })

    return Response([]);


# for testing only
@api_view(["GET"])
def test(request):
    products_collection.create_index({
        "title":"text"
    })
    return Response([]);