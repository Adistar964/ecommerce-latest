import HeaderAndFooter from "./HeaderAndFooter";

// form firebase:
import { auth } from "./configuration/firebase_config"

// we will also use useContext
// It helps us pass values down to multiple levels of children components
// without passing it thru props
// refer to broCode if u dont undertand!

// importing from react
import { useState, createContext, useEffect } from "react";  

// creating the userCOntext -> will give us info on user's authentication
export const userContext = createContext()

// we kinda renamed "App" to "Home"
function Home() {
  const [user,setUser] = useState(null)

  return (
    <>
      <HeaderAndFooter>
      <br /><br /><br />
      Home Page!
      <br /><br /><br />
      </HeaderAndFooter>
    </>
  )
}

export default Home;
