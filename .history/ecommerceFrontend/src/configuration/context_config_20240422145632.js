

// we will also use CreateContext
// It helps us pass values down to multiple levels of children components
// without passing it thru props
// basically, it allows us to use the same useState variable in multiple components 
// refer to broCode if u dont understand!

// importing from react
import { createContext } from "react";

// creating our context!
// myContext -> will store info on cart,user-info,etc...
export const MyContext = createContext()
//  Now we will use the above in App.js 

export const useMyContext = () => {
    return useContext(MyContext);
}
