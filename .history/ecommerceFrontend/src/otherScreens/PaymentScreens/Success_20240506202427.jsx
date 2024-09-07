

import HeaderAndFooter from "../../HeaderAndFooter"

// icons
import { MdOutlineDone } from "react-icons/md";

export default function SuccessPayment(props){
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
                    </div>
                    <p>
                        Your payment was Successful
                    </p>
            </div>
        </HeaderAndFooter>
    );
}