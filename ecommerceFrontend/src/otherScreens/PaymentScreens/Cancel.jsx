

import HeaderAndFooter from "../../HeaderAndFooter"

import { useNavigate } from "react-router-dom";

// icons
import { RxCross2 } from "react-icons/rx";

export default function CancelPayment(props){

    const navigate = useNavigate()

    return (
        <HeaderAndFooter>
            <div style={{fontFamily:"Poppins"}} 
            className="text-center container border shadow-lg">
                    <div className="mb-4 mt-3">
                        <RxCross2 size="4em" 
                        color="white" style={{
                        borderRadius:"100%",
                        border:"1px solid",
                        backgroundColor:"red",
                        padding:"10px"
                        }} />
                        <h3 className="d-block mt-2">
                            Transaction Cancelled!
                        </h3>
                        <p>
                            Payment was stopped!
                            <br />
                            The transaction could'nt proceed as it was cancelled.
                            <br />
                            No Amount was deducted from your card.
                        </p>
                    </div>
                    <div className="d-flex justify-content-center gap-4 mb-4">
                        <button onClick={()=>navigate("/")}
                        className="btn btn-outline-theme">
                            Continue Shopping
                        </button>
                        <button onClick={()=>navigate("/cart/")} 
                        className="btn btn-outline-theme">
                            View Cart
                        </button>
                    </div>
            </div>
        </HeaderAndFooter>
    );
}