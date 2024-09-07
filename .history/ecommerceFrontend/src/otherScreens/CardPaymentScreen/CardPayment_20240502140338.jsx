
// importing comopnents
import HeaderAndFooter from "../../HeaderAndFooter"

// stylesheets
import "./CardFormCss.css"

// import card-comonent from react-credit-cards-2
import CreditCardForm from "react-credit-cards-2"

export default function CardPayment(props){

    useEffect(() => {
        var tap = Tapjsli('pk_test_EtHFV4BuPQokJT6jiROls87Y');

        var elements = tap.elements({});
        
        var style = {
          base: {
            color: '#535353',
            lineHeight: '18px',
            fontFamily: 'sans-serif',
            fontSmoothing: 'antialiased',
            fontSize: '16px',
            '::placeholder': {
              color: 'rgba(0, 0, 0, 0.26)',
              fontSize:'15px'
            }
          },
          invalid: {
            color: 'red'
          }
        };
        // input labels/placeholders
        var labels = {
            cardNumber:"Card Number",
            expirationDate:"MM/YY",
            cvv:"CVV",
            cardHolder:"Card Holder Name"
          };
        //payment options
        var paymentOptions = {
          currencyCode:["KWD","USD","SAR"], //change the currency array as per your requirement
          labels : labels,
          TextDirection:'ltr', //only two values valid (rtl, ltr)
          paymentAllowed: ['VISA', 'MASTERCARD', 'AMERICAN_EXPRESS', 'MADA'] //default string 'all' to show all payment methods enabled on your account
        }
        //create element, pass style and payment options
        var card = elements.create('card', {style: style},paymentOptions);
        //mount element
        card.mount('#element-container');
        //card change event listener
        card.addEventListener('change', function(event) {
          if(event.loaded){ //If ‘true’, js library is loaded
            console.log("UI loaded :"+event.loaded);
            console.log("current currency is :"+card.getCurrency())
          }
          var displayError = document.getElementById('error-handler');
          if (event.error) {
            displayError.textContent = event.error.message;
          } else {
            displayError.textContent = '';
          }
        });
    }, [])

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