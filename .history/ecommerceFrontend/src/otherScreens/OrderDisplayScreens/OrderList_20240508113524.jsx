

// importing components
import HeaderAndFooter from "../../HeaderAndFooter";
import Loading from "../../components/Loading"

// importing from react-bootstrap
import { Tabs,Tab } from "react-bootstrap";

// importing from react
import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";

export default function OrderList() {

    const [loading,setLoading] = useState(true)

    // the below are products divided on the basis of their status
    const [pendingItems,setPendingItems] = useState([]);
    const [deliveredItems,setDeliveredItems] = useState([]);
    const [cancelledItems,setCancelledItems] = useState([]);

    const navigate = useNavigate()

    // we will fetch orders and store them in above variables
    useEffect(() => {

        const getOrdersFromDb = async () => {
            const response = await fetch(backend_link+"/getOrdersFromDB/1233/")
            const res = await response.json()
            console.log(res)
        }

        getOrdersFromDb()
    }, [])

    if(loading){return <Loading />}
    return(
        <HeaderAndFooter>
            <div className="mt-3 mb-3 container shadow border border-3 border-top-0">
                {/* inside <Tabs /> we will have many <Tab /> */}
                <Tabs defaultActiveKey="pending" fill variant="pills" className="border border-2">
                    <Tab className="p-3" eventKey="pending" title="pending orders"> {/* eventKey is used for switching tabs and title is what user sees as tab-title */}
                        <Orders orderItems={pendingItems} />
                    </Tab>
                    <Tab className="p-3" eventKey="delivered" title="delivered orders">
                        <Orders orderItems={deliveredItems} />
                    </Tab>
                    <Tab className="p-3" eventKey="cancelled" title="cancelled orders">
                        <Orders orderItems={cancelledItems} />
                    </Tab>
                </Tabs>
            </div>
        </HeaderAndFooter>
    );
}

function Orders({orderItems}) {
    return (
        "Heyy"
    );
}