
// importing comopnents
import HeaderAndFooter from "../../HeaderAndFooter"

// import card-comonent from react-credit-cards-2
import CreditCardForm from "react-credit-cards-2"

export default function CardPayment(props){
    return(
        <HeaderAndFooter>
            <form id="form-container" method="post" action="/charge">
                {/* Tap element will be here */}
                <div id="element-container"></div>
                <div id="error-handler" role="alert"></div>
                <div id="success" style={{display:"none",position:"relative",float:"left"}}>
                        Success! Your token is <span id="token"></span>
                </div>
                {/* Tap pay button */}
                <button id="tap-btn">Submit</button>
            </form>
        </HeaderAndFooter>
    );
}