
import { MyContext } from "./configuration/context_config.js";
import { auth } from "./configuration/firebase_config.js";

import { useState, useEffect, useRef } from "react";


// we will import react-router-dom
import { createBrowserRouter, RouterProvider } from "react-router-dom";


// importing bootstrap
// but first do "npm install react-bootstrap"
import { Modal } from "react-bootstrap";

// importing react-toastify
// but first do "npm install react-toastify"
import "react-toastify/dist/ReactToastify.css";
import { ToastContainer } from "react-toastify"

// importing components
import Home from './otherScreens/Home/Home.jsx'
import SignIn from './authScreens/SignIn/SignIn.jsx'
import SignUp from './authScreens/SignUp/SignUp.jsx'
import Profile from './authScreens/Profile/Profile.jsx'
import SearchPage from "./otherScreens/SearchPage/SearchPage.jsx";
import {MainScreenLoading}  from "./components/Loading.jsx";
import CartScreen from "./ProductScreens/CartScreen/CartScreen.jsx";
import ErrorPage from "./otherScreens/Error/Error.jsx";
import ProductDisplay from "./ProductScreens/productDisplay/productDisplay.jsx";
import WishList from "./ProductScreens/WishListScreen/WishList.jsx";
import SuccessPayment from "./otherScreens/PaymentScreens/Success.jsx";
import CancelPayment from "./otherScreens/PaymentScreens/Cancel.jsx";
import MakePayment from "./otherScreens/PaymentScreens/MakePayment.jsx";
import OrderList from "./otherScreens/OrderDisplayScreens/OrderList.jsx"
import ViewSingleOrder from "./otherScreens/OrderDisplayScreens/ViewSingleOrder.jsx";
import './index.css'


const ecommerce_router = createBrowserRouter(
  [
    {path:"",element: <Home />, errorElement: <ErrorPage />},
    {path:"/login",element: <SignIn />},
    {path:"/register",element: <SignUp />},
    {path:"/profile",element: <Profile />},
    {path:"/search/:search_text",element: <SearchPage />},
    {path:"/cart",element: <CartScreen />},
    {path:"/product/:pid",element: <ProductDisplay />},
    {path:"/wishlist/",element: <WishList />},
    {path:"/makePayment/:operation",element: <MakePayment />}, // operation shows the purpose of payment, ex: cart
    {path:"/SuccessPayment/:order_id",element: <SuccessPayment />},
    {path:"/CancelPayment/",element: <CancelPayment />},
    {path:"/OrderList/",element: <OrderList />}, // for viewing all orders
    {path:"/orders/:order_id",element: <ViewSingleOrder />}, // for viewing a specific order
  ]
);

// some constants
export const backend_link = "http://localhost:8000/api" // this will be used by all of our componenets
export const currency = "QAR"

export default function App(props){
    // this user-variable will help us access the current user
    const [user,setUser] = useState(null);
    // This will help us access products
    const [products,setProducts] = useState([]);
    // This will help us access cart
    const [cart,setCart] = useState([]);
    // This will help us access user-wishlist//favourites
    const [favourites,setFavourites] = useState([]);

    // we will also fetch the list of all categories to display it in the header
    const [categories, setCategories] = useState([]) // we will store catgries here
    

    // this will help us set the loading screen
    const [ loading, setLoading ] = useState(false);

    // this will help us in showing that bootstrap-alert-modal
    const [showAlert,setShowAlert] = useState(false)
    const [alertTitle,setAlertTitle] = useState("Alert!")
    const [alertBody,setAlertBody] = useState("please try again later!")
    const [alertBtnText,setAlertBtnText] = useState("Understood!")
    const alertBtnAction = useRef(()=>{}) // it is useRef as we dont want any unneccessary re-rendering


    // this will fetch all our products!
    async function getProducts(){
      const request_parameters = {
        method:"POST",
        headers:{"Content-Type":"application/json"},
        body:JSON.stringify({})  // JSON.stringify() is "must"
        // body is basically the querying, but we dont need any querying now
      }
      const response = await fetch(`${backend_link}/getproducts/`,request_parameters) // dont forget the trailing slash!
      const data = await response.json()
      setProducts(data)
    }

    // for accessing the user's cart (see after useEffect)
    async function getCart(usr){
        const request_parameters = {
          method:"POST",
          headers:{"Content-Type":"application/json"},
          body:JSON.stringify({uid:usr.uid})  // JSON.stringify() is "must"
          // body is basically the querying, but we dont need any querying now
        }
        const response = await fetch(`${backend_link}/getCart/`,request_parameters) // dont forget the trailing slash!
        const json_response = await response.json()
        const cart_items = json_response["cart_items"]
        setCart(cart => cart_items)
    }

    // for accessing the user's favourites/wishlist (see after useEffect)
    async function getFavourites(usr){
        const request_parameters = {
          method:"POST",
          headers:{"Content-Type":"application/json"},
          body:JSON.stringify({uid:usr.uid})  // JSON.stringify() is "must"
          // body is basically the querying, but we dont need any querying now
        }
        const response = await fetch(`${backend_link}/getFavourites/`,request_parameters) // dont forget the trailing slash!
        const json_response = await response.json()
        const user_favourites = json_response["user_favourites"]
        setFavourites(() => user_favourites)
    }


    // we will also fetch the list of all categories to display it in the header
    function getAllCategories(){
      fetch(backend_link + "/fetchAllProductCategories/").then(res => res.json())
      .then(cats => setCategories(cats))
    }

    // useEffect
    useEffect(()=>{
      // we will add a event listener that keeps track of user login status
      // The event listener returns a unsub function which we will store in the variable
        const unsub = auth.onAuthStateChanged(usr => {
          setLoading(true)
          setUser(usr);
          if (usr!==null){
            // we will access that user's cart and favourites/wish-list right away
            getCart(usr)
            getFavourites(usr)
          }else{
            setCart([])
            setFavourites([])
          }
          // and then finally:
          getAllCategories() // we will also fetch the list of all categories to display it in the header
          setLoading(false) // after everything is done
        })
        return ()=>unsub(); // then when the component unmounts, we will unsub()
        // note: dont do "return unsub()"
        // otherwise it will run the unsub function, and you wont get real-time update 
      },[]) // will only run after the component initially mounts

      useEffect(() => {getProducts()},[])

    // we will wrap everything in myContext,
    // so that the child components can use variable "user","cart","products",etc.
    return(
        <MyContext.Provider value={{
          // for mongodb data-realted and firebase user
          user:user,products:products,
          // user'cart
          cart:cart,setCart:setCart,
          // user'favourites
          favourites:favourites,setFavourites:setFavourites,
          // the list of all categories to display it in the header
          categories: categories,
          // for alert-modal related
          showAlert:showAlert,setShowAlert:setShowAlert,
          alertTitle:alertTitle,setAlertTitle:setAlertTitle,
          alertBody:alertBody,setAlertBody:setAlertBody,
          alertBtnText:alertBtnText,setAlertBtnText:setAlertBtnText,
          alertBtnAction:alertBtnAction,
          // loading variables:
          loading:loading
          }}>
            { loading ? 
            <MainScreenLoading /> 
              :
              <>
                <RouterProvider router={ecommerce_router} />
                {/* we will also have a globally accessible modal */}
                <Modal show={showAlert} onHide={()=>{setShowAlert(false)}}>
                  <Modal.Header>
                    {/* we will have a title and also a close button */}
                    <Modal.Title>
                      {alertTitle}
                    </Modal.Title>
                    <button onClick={()=>{setShowAlert(false)}} 
                    className="btn-close"></button>  
                  </Modal.Header>
                  <Modal.Body style={{whiteSpace:"pre-line"}}> {/* whiteSpace:pre-line allows the use of \n */}
                    <p>
                      {alertBody}
                    </p>
                  </Modal.Body>
                  <Modal.Footer style={{display:"flex",justifyContent:"center"}}>
                    <button onClick={()=>{setShowAlert(false);alertBtnAction.current()}} 
                    className="btn btn-secondary">
                      {alertBtnText}
                    </button>
                  </Modal.Footer>
                </Modal>
                {/* for toast (will be used by all toasts)*/}
                <ToastContainer />
              </>
            }
        </MyContext.Provider>
    );
}


// we will create a function so that we dont have to repeat the below code everytime!
export function displayModal(context,title,body,btnText,btnAction=()=>{}){
  context.setAlertTitle(title)
  context.setAlertBody(body)
  context.setAlertBtnText(btnText)
  context.alertBtnAction.current = btnAction // we did .current as it is useRef
  //  By default it BtnAction will be an empty function
  context.setShowAlert(true)
}

// we will also make a function to ask the user to log-in
export const checkLoggedIn = (context,callback) => {
  if (context.user !==null){
      callback() // run the function if user is logged in!
  }else{
      displayModal(context,"Please Login!","You will need to login to continue",
    "Login",()=>{window.location.replace("http://localhost:5173/login/")})
  }

}