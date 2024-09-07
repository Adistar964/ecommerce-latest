
import { MyContext } from "./configuration/context_config";

import { useState } from "react";
import { createBrowserRouter, RouterProvider } from "react-router-dom";

// importing components
import Home from './Home.jsx'
import SignIn from './authScreens/SignIn/SignIn.jsx'
import SignUp from './authScreens/SignUp/SignUp.jsx'
import Profile from './authScreens/Profile/Profile.jsx'
import './index.css'

// we will import react-router-dom
import { createBrowserRouter, RouterProvider } from "react-router-dom";

const ecommerce_router = createBrowserRouter(
  [
    {path:"",element: <Home />},
    {path:"/login",element: <SignIn />},
    {path:"/register",element: <SignUp />},
    {path:"/profile",element: <Profile />},
  ]
);



export default function App(){
    // this user-variable will help us access the current user
    const [user,setUser] = useState(null);

    useEffect(()=>{
        // initially, we will set user variable to the current status,
        // Then we will channge its value depending on change of state of user's login status
      setUser(auth.currentUser)
      // we will add a event listener that keeps track of user login status
      // The event listener returns a unsub function which we will store in the variable
        const unsub = auth.onAuthStateChanged(usr => {
          console.log("user state changed!")
          setUser(usr);
        })
        return unsub(); // then when the compoenent unmounts, we will unsub()
    },[]) // will only run after the component initially mounts

    // we will wrap everything in myContext,
    // so that the child components can use variable "user","cart","navigate",etc.
    return(
        <MyContext.Provider>
            <RouterProvider router={ecommerce_router} />
        </MyContext.Provider>
    );
}