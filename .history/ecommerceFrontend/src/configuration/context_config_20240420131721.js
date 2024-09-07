

// we will also use CreateContext
// It helps us pass values down to multiple levels of children components
// without passing it thru props
// basically, it allows us to use the same useState variable in multiple components 
// refer to broCode if u dont understand!

// importing from react
import { useContext } from "react";

// creating our context!
// creating the myContext -> will gives us info on cart,user-info,etc...
export const MyContext = createContext()
