
// importing comopnents
import HeaderAndFooter from "../../HeaderAndFooter"

// import card-comonent from react-credit-cards-2
import CreditCardForm from "react-credit-cards-2"

export default function CardPayment(props){
    return(
        <HeaderAndFooter>
            <CreditCardForm />
        </HeaderAndFooter>
    );
}