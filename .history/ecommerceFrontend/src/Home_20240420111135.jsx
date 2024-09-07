import Header, {Footer} from "./HeaderAndFooter";

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

  useEffect(()=>{
      // the event listener handles real-time signin and signout state of user
      // the event also return unsub function
      const unsub = auth.onAuthStateChanged(user=> {
        setUser(user)
      })
      // when the component unloads, we will run unsub() to unsubscribe from the event listener
      // so that it doesnt run forever
      return unsub();
  }, []) // it only runs after this compoenent loads

  return (
    // we will wrap everything in userContext,
    // so that the child components can use variable "user"
    <userContext.Provider value={user}>
      <Header />
      <br /><br /><br />
      Home Page!
      <br /><br /><br />
      <Footer />  
    </userContext.Provider>
  )
}

export default Home;
