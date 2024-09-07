import React from 'react'
import ReactDOM from 'react-dom/client'
import Home from './Home.jsx'
import SignIn from './authScreens/SignIn/SignIn.jsx'
import SignUp from './authScreens/SignUp/SignUp.jsx'
import './index.css'

// we will import react-router-dom
import { createBrowserRouter, RouterProvider } from "react-router-dom";
import Profile from './authScreens/Profile/Profile.jsx'

const ecommerce_router = createBrowserRouter(
  [
    {path:"",element: <Home />},
    {path:"/login",element: <SignIn />},
    {path:"/register",element: <SignUp />},
    {path:"/profile",element: <Profile />},
  ]
);

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <RouterProvider router={ecommerce_router} />
  </React.StrictMode>,
)
