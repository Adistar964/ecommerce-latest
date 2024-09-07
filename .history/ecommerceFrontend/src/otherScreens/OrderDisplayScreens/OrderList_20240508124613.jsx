

// importing components
import HeaderAndFooter from "../../HeaderAndFooter";
import Loading from "../../components/Loading"
import { backend_link } from "../../App";
import { MyContext } from "../../configuration/context_config";

// importing from react-bootstrap
import { Tabs,Tab } from "react-bootstrap";

// importing from react
import { useState, useEffect, useContext } from "react";
import { useNavigate } from "react-router-dom";

export default function OrderList() {

    const [loading,setLoading] = useState(true)

    // the below are products divided on the basis of their status
    const [pendingItems,setPendingItems] = useState([]);
    const [deliveredItems,setDeliveredItems] = useState([]);
    const [cancelledItems,setCancelledItems] = useState([]);

    const navigate = useNavigate()
    const context = useContext(MyContext)

    // we will fetch orders and store them in above variables
    useEffect(() => {
        setLoading(true)
        const getOrdersFromDb = async () => {
            const response = await fetch(backend_link+"/getOrdersFromDB/"+context["user"]["uid"]+"/")
            const data = await response.json()
            setPendingItems(data["pending_items"])
            setDeliveredItems(data["delivered_items"])
            setCancelledItems(data["cancelled_items"])
            setLoading(false)
        }

        context["user"] !== null ? getOrdersFromDb() : setLoading(true) // keep on loading if user is not signed in (like a punishment for navigating to this url) 
    }, [context["user"]])   

    if(loading){return <Loading />}
    return(
        <HeaderAndFooter>
            <div className="mt-3 mb-3 container shadow border border-3 border-top-0">
                {/* inside <Tabs /> we will have many <Tab /> */}
                <Tabs defaultActiveKey="pending" fill variant="pills" className="border border-2">
                    <Tab className="p-3" eventKey="pending" title="pending orders"> {/* eventKey is used for switching tabs and title is what user sees as tab-title */}
                        <Orders orderItems={pendingItems} emptyMessage="Nothing in here" />
                    </Tab>
                    <Tab className="p-3" eventKey="delivered" title="delivered orders">
                        <Orders orderItems={deliveredItems} emptyMessage="Nothing in here" />
                    </Tab>
                    <Tab className="p-3" eventKey="cancelled" title="cancelled orders">
                        <Orders orderItems={cancelledItems} emptyMessage="Nothing in here" />
                    </Tab>
                </Tabs>
            </div>
        </HeaderAndFooter>
    );
}

function Orders(props) {
    console.log(props.orderItems)
    if(true){
        return (
        <div className="text-center">
            Hey
        </div>
        )
    }else{ // if there are no items
        return (
            <div className="text-center">
                Oops.. {props.emptyMessage} 
            </div>
        )
    }
}