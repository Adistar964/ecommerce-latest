

import HeaderAndFooter from "../../HeaderAndFooter"

// icons
import { MdOutlineDoneOutline } from "react-icons/md";

export default function SuccessPayment(props){
    return (
        <HeaderAndFooter>
            <div className="text-center container border shadow-lg">
                <div className="rounded">
                    <MdOutlineDoneOutline />
                </div>
            </div>
        </HeaderAndFooter>
    );
}