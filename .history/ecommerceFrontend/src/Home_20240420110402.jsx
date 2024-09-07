import Header, {Footer} from "./HeaderAndFooter";


// we will also use useContext
// It helps us pass values down to multiple levels of children components
// without passing it thru props

// importing from react
import { useState, createContext } from "react";  

// creating the userCOntext -> will give us info on user's authentication
export const userContext = createContext()

// we kinda renamed "App" to "Home"
function Home() {

  return (
    <>
      <Header />
      <br /><br /><br />
      Home Page!
      <br /><br /><br />
      <Footer />  
    </>
  )
}

export default Home;
