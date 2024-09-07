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
  const user = useState("none")
  return (
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
