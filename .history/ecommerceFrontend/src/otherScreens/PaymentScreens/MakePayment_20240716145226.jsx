
// from react
import { useContext, useState, useEffect } from "react";
import { MyContext } from "../../configuration/context_config";
import { useNavigate, useParams } from "react-router-dom";

// importing from stripe:
// first do: npm install @stripe/react-stripe-js @stripe/stripe-js
import { loadStripe } from "@stripe/stripe-js"
import { EmbeddedCheckoutProvider, EmbeddedCheckout } from 
"@stripe/react-stripe-js"

// components:
import HeaderAndFooter from "../../HeaderAndFooter";
import { MainScreenLoading } from "../../components/Loading";

import { backend_link, displayModal } from "../../App";
import { clearCart } from "../../ProductScreens/CartScreen/CartFunctions";

// rc-steps => showing steps for payment 
import Steps from "rc-steps";
import "rc-steps/assets/index.css"

// react-icons
import { TiTick } from "react-icons/ti";
import { FaCalendar } from "react-icons/fa6";
import { CiDeliveryTruck } from "react-icons/ci";
import { IoIosArrowBack } from "react-icons/io";

// react-date-picker
import DatePicker from "react-date-picker";
import 'react-date-picker/dist/DatePicker.css';
import 'react-calendar/dist/Calendar.css';

// main component
export default function MakePayment(props){
    
    const [currentStepIndex,setCurrentStepIndex] = useState(0) // currently at first slide

    const [deliveryDate, setDeliveryDate] = useState( new Date ) // by default it will be today's date
    const [slot, setSlot] = useState({}) // this will be the slot chosen by the user (for now, it is empty)

    return (
        <HeaderAndFooter>
            <Steps 
            icons={ {finish:<TiTick/>}} // icon once the step is finished 
            className="container" // to be responsive and not take complete width
            current={currentStepIndex} // current active index (to control the step)
            // example: below we will show deliveryTimingSelection Screen and after thats complete we will change th currentIdx to 1 
            // => so that it goes to card payment screen
            items={[
                {title:"delivery time"},
                {title:"Payment"},
            ]} />
            {currentStepIndex === 0 ? 
                <DeliveryTimingSelection setCurrentStepIndex={setCurrentStepIndex}
                deliveryDate={deliveryDate} setDeliveryDate={setDeliveryDate}
                setSlot={setSlot} slot={slot} /> // basically setting delivery timing here
            : <CardPayment
              setCurrentStepIndex={setCurrentStepIndex} // for going back to the delivery-slot-screen
              deliveryDate={deliveryDate}  // and then passing the selected timing to this screen so it can send it to backend
               />
            }
        </HeaderAndFooter>
    );
}



function DeliveryTimingSelection(props){
    const [allSlots, setAllSlots] = useState([]) // all the 3 slots will be stored in it after fetching from the backend, for the user to choose from 
    
    useState(() => {
        if(props.deliveryDate){
            setSlots_as_per_date(props.deliveryDate)
        }
    }, [props.deliveryDate]) // runs everytime a different delivery-date is chosen 
    
    async function setSlots_as_per_date(selected_date) { // this will update available/unavailable slots as the chosen date changes
        const date = selected_date.toDateString() // converting into string so that it can be sent to backend
        
        // now fetching slots from backend:
        var body = {date:date} // getting slots for this date!
        const requestParams = {
            method:"POST",
            headers:{"Content-type":"application/json"},
            body: JSON.stringify(body) // converting js to json
        } 
        const response = await fetch(`${backend_link}/getSlots/`, requestParams)
        const slots_data = await response.json()
        setAllSlots(slots_data)
    }

    return (
        <div className="shadow-lg border container p-3 mt-3 text-center">
            <h3 className="text-center display-6 mb-3">
                Delivery Timing Selection
            </h3>
            <hr />
            <div className="d-flex justify-content-center">
                <p style={{fontSize:"1.5em"}} className="mt-2">
                    <span className="text-danger">*</span>
                    Date
                </p>
                &nbsp;&nbsp;&nbsp;
                <DatePicker 
                calendarIcon={<FaCalendar size="1.5em" />} // our custom calendar icon
                clearIcon={()=>{}} // no clear button haha
                minDate={new Date()}
                //  maxDate={() => {
                    // let now = new Date();
                    // now.setDate(now.getDay()+5)
                    // return now
                // }}
                value={props.slot} onChange={
                    function (selectedDate){
                        let day = selectedDate.getDay()
                        // day returns => 0 for sunday, 1 monday, 2 tuesday, etc..
                        if(day == 5){ // 5 stands for "Friday"
                            alert("Not our working day!")
                        }else{
                            props.setDeliveryDate(selectedDate); 
                            // the above will then re-trigger the useEffect as the deliveryDate changed
                        }
                    }
                } />
            </div>
            <br />
            <p style={{fontSize:"1.5em"}} className="mt-2">
                <span className="text-danger">*</span>
                Delivery Slot
            </p>
            {allSlots.map(slot => 
                <div className="m-5 mt-0 mb-1 d-flex justify-content-around align-items-center border shadow-lg p-2">
                    <div className="flex-grow-1 d-flex">
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="checkbox"
                        disabled={!slot["available"]} // checkbox disabled if slot not available
                        style={{transform:"scale(2)"}} />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <CiDeliveryTruck size="5em"/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <div className="mt-4">
                            <p>
                                {slot["startTime"]} AM to {slot["endTime"]} AM
                            </p>
                        </div>
                    </div>
                    {slot["available"] ? 
                        <p className="text-success">available</p>
                    :   <p className="text-danger">unavailable</p>
                    }
                </div>
            )}
            <button onClick={()=>props.setCurrentStepIndex(1)} 
            className="btn btn-theme mt-5 w-50 p-2 text-light">
                Next
            </button>
        </div>
    );
}


// initialising stripe:
const stripeInstance = loadStripe("pk_test_51J9qlHK0ixBKvwxD8UQ5yWlBRsuhgobvCHszMf09kIpBGVwFOrANQQAkvKbdxtri7yf2swFUcoCFka5I7CJ1ITgf00RwC5WFUz")

function CardPayment(props){

    const [clientSecret, setClientSecret] = useState("")
    const [sessionID, setSessionID] = useState("") 
    // every session has an ID, and this will be very useful for getting all session's data like shipping details, email, etc..
    const [loading, setLoading] = useState(true)

    const context = useContext(MyContext)
    const navigate = useNavigate()
    const {operation} = useParams() // we will get operation param from the url

    // after the payment is completed
    const afterPaymentComplete = async () => {
        setLoading(true)
        // for different operation types, it will be different
        // for now, we only have cart_purchase
        if(operation === "cart_purchase"){

            // we will have to add current cart to user's doc's orders array
            // for that an object with 3 props will be created like below:
            // createdAt => date/time when the order was taken
            // products array => consists info of all products purchased
            // status => will show pending,delivered,etc...
            // uid => that user's id to whom the order belongs
            // uid => that user's email to whom the order belongs
            let newOrder = {createdAt:new Date(), status:"pending",
                            uid:context["user"]["uid"], email:context["user"]["email"],
                            products:[]}
            
            for(let product of context["cart"]){
                // appending this product to newOrder's products array
                newOrder["products"].push({
                    product_id:product["product_id"],
                    product_name:product["product_name"],
                    quantity:product["quantity"],
                    price:product["price"],
                    discountPrice:product["discountPrice"],
                    thumbnail:product["thumbnail"],
                })
            }
            // now we will have to add this ordered_products to our user_orders array in user's document
            // but wait, the backend will also add the shipping_address field and totalAmount field to this newly created order
            // the shipping_address and totalAmount is gotten from this session and thats why send sessionID to the backend so it can fetch that data
            const body = {
                orderToBeInserted:newOrder, // this will be added as a doc in mongodb from the backend after some modifications as mentioned above
                session_id:sessionID
            }
            const request_parameters = {
                method:"POST",
                headers:{"Content-Type":"application/json"},
                body:JSON.stringify(body)
            }
            try{
                const response = await fetch(backend_link+"/addOrder/",request_parameters)
                const data = await response.json()
                const order_id = data["inserted_id"] // will give id of the order we just inserted.
                clearCart(context) // we will also have to empty the cart
                setLoading(false)
                navigate("/successPayment/"+order_id)
            }catch(error){
                displayModal(context, "Server Error!",
                "Your payment was complete! but we couldnt proccess it.\n This error is one in a million, so please pardon us! \n kindly contact our team as soon as possible for solving this issue",
            "Contact us", 
            ()=>{window.replace("mailto:adistar964@gmail.com?subject=payment%20complete%20but%20not%20received%20by%20ecommerce")})
            setLoading(false)
            }
            
        }
    }
 
    useEffect(() => {
        console.log(operation)
        const getClientSecret = async () => {
            const request_parameters = {
                method:"POST",
                headers:{"Content-Type":"application/json"},
                body:JSON.stringify({uid:context["user"]["uid"], operation:operation})
            }
            const response = await fetch(backend_link+"/makePayment/", request_parameters)
            const json_response = await response.json()
            setClientSecret(json_response["client_secret"])
            setSessionID(json_response["session_id"]) // we will also get this session id
            context.cart.length !== 0 ? setLoading(false) : ""
        }


        // only fetch clientsecret if user is signed in
        if(context["user"] !== null){
            getClientSecret()
        }
    }, [context["user"]])

    if(loading){
        return <MainScreenLoading />
    }
    return (
        <div>
            <div className="d-flex justify-content-center mb-3">
                <button className="btn btn-outline-theme" onClick={()=>props.setCurrentStepIndex(0)}>
                    <IoIosArrowBack />
                    back
                </button>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <h3 className=" justify-self-center">
                    {operation}
                </h3>
            </div>
            {/* below is embeddded stripe-created form */}
            <EmbeddedCheckoutProvider stripe={stripeInstance}
            // also we should specify options like below:
            options={{clientSecret, onComplete:afterPaymentComplete}}>
                <EmbeddedCheckout className="border border-secondary shadow-lg container pt-3 pb-3" />
            </EmbeddedCheckoutProvider> 
        </div>
    );
}
