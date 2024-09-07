

import { useNavigate } from "react-router-dom";
import { useState, useEffect } from "react";

import HeaderAndFooter from "../../HeaderAndFooter"
import Loading from "../../components/Loading"

// icons
import { MdOutlineDone } from "react-icons/md";

export default function SuccessPayment(props){

    const navigate = useNavigate()

    const [loading, setLoading] = useState(true)

    // once the user lands in the success page,
    // it would mean that user has payed for his cart
    // therefore, here we will clear user's cart after successful checkout
    useEffect(() => {

    }, [])


    if(loading){
        return <Loading />
    }
    return (
        <HeaderAndFooter>
            <div style={{fontFamily:"Poppins"}} 
            className="text-center container border shadow-lg">
                    <div className="mb-4 mt-3">
                        <MdOutlineDone size="4em" 
                        color="white" style={{
                        borderRadius:"100%",
                        border:"1px solid",
                        backgroundColor:"lightgreen",
                        padding:"10px"
                        }} />
                        <h3 className="d-block mt-2">
                            Payment Successful
                        </h3>
                        <p>
                            You have completed your transaction!
                            <br />
                            You can now either continue shopping or view the completed order.
                        </p>
                    </div>
                    <div className="d-flex justify-content-center gap-4 mb-4">
                        <button onClick={() => navigate("/")} 
                        className="btn btn-outline-theme">
                            Continue Shopping
                        </button>
                        <button onClick={()=>navigate("/orders/")} 
                        className="btn btn-outline-theme">
                            View Order
                        </button>
                    </div>
            </div>
        </HeaderAndFooter>
    );
}