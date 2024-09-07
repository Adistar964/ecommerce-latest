
// importing comopnents
import HeaderAndFooter from "../../HeaderAndFooter"

// stylesheets
import "./CardFormCss.css"

// First do: npm install @stripe/react-stripe-js @stripe/stripe-js
import { loadStripe } from "@stripe/stripe-js/pure";
import { Elements } from "@stripe/react-stripe-js";

// get credential from the dashboard => also it is okay to not hide pkey but not secret-key
const publishable_key = "pk_test_51J9qlHK0ixBKvwxD8UQ5yWlBRsuhgobvCHszMf09kIpBGVwFOrANQQAkvKbdxtri7yf2swFUcoCFka5I7CJ1ITgf00RwC5WFUz"
// now initialise stripe
const stripeInstance = loadStripe(publishable_key)

export default function CardPayment(props){

    return(
        // We'll wrap everything in Elements tag for loading stripe
        <Elements stripe={stripeInstance}>
            <HeaderAndFooter>
                <h3 className="text-center">Card Payment</h3>
                <CardForm />
            </HeaderAndFooter>
        </Elements>
    );
}


// Now doing second part of our component
import { CardElement, 
        useElements, useStripe } from "@stripe/react-stripe-js";
import { useContext } from "react";
import { MyContext } from "../../configuration/context_config";

function CardForm(){

    const context = useContext(MyContext)

    return(
        <form className="container w-50">
            <div className="form-group">
                <label htmlFor="emailCreditCard">Email:</label>
                <input value={context["user"]["email"]} 
                type="email" className="form-control" id="emailCreditCard" />
            </div>
            <div className="form-group mt-3">
                <label htmlFor="cardElement">Credit or Debit Card</label>
                {/* We will now use the pre-built comp from stripejs */}
                <CardElement  id="cardElement" />
            </div>
        </form>
    );
}