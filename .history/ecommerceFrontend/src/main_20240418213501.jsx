import React from 'react'
import ReactDOM from 'react-dom/client'
import Home from './App.jsx'
// import './index.css'

// we will import react-router-dom
import { createBrowserRouter, RouterProvider } from "react-router-dom";

const ecommerce_router = createBrowserRouter(
  [
    {path:"",element: <Home />},
  ]
);

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <RouterProvider router={ecommerce_router} />
  </React.StrictMode>,
)
