

import HeaderAndFooter from "../../HeaderAndFooter"

// icons
import { MdOutlineDoneOutline } from "react-icons/md";

export default function SuccessPayment(props){
    return (
        <HeaderAndFooter>
            <div className="text-center container border shadow-lg">
                    <div className="mb-4 mt-3">
                        <MdOutlineDoneOutline size="3em" 
                        color="white" style={{
                        borderRadius:"100%",
                        border:"1px solid",
                        backgroundColor:"lightgreen"
                        }} />
                    </div>
            </div>
        </HeaderAndFooter>
    );
}