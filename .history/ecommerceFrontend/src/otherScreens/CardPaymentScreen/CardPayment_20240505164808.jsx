
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
                Card Payment:(visa)
            </HeaderAndFooter>
        </Elements>
    );
}