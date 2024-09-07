

import HeaderAndFooter from "../../HeaderAndFooter"

// icons
import { MdOutlineDoneOutline } from "react-icons/md";

export default function SuccessPayment(props){
    return (
        <HeaderAndFooter>
            <div className="text-center container border shadow-lg">
                <div style={{
                    borderRadius:"100%",
                    border:"1px solid"
                }}>
                    <MdOutlineDoneOutline />
                </div>
            </div>
        </HeaderAndFooter>
    );
}