

// importing components
import HeaderAndFooter from "../../HeaderAndFooter";
import Loading from "../../components/Loading"
import { backend_link, currency } from "../../App";
import { MyContext } from "../../configuration/context_config";
import "./orderstyles.css"

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
            setPendingItems(data["pending_orders"])
            setDeliveredItems(data["delivered_orders"])
            setCancelledItems(data["cancelled_orders"])
            setLoading(false)
        }

        context["user"] !== null ? getOrdersFromDb() : setLoading(true) // keep on loading if user is not signed in (like a punishment for navigating to this url) 
    }, [context["user"]])   

    if(loading){return <Loading />}
    return(
        <HeaderAndFooter>
            <div className="mt-3 mb-3 container shadow border border-3 border-top-0">
                {/* inside <Tabs /> we will have many <Tab /> */}
                <Tabs defaultActiveKey="pending" fill variant="pills" className="border border-2 rounded">
                    <Tab className="p-3" eventKey="pending" title="pending orders"> {/* eventKey is used for switching tabs and title is what user sees as tab-title */}
                        <Orders orderItems={pendingItems} emptyMessage="Nothing in here" />
                    </Tab>
                    <Tab className="p-3" eventKey="delivered" title="delivered orders">
                        <Orders orderItems={deliveredItems} emptyMessage="Nothing in here" />
                    </Tab>
                    <Tab className="p-3" eventKey="cancelled" title="cancelled orders">
                        <Orders orderItems={cancelledItems} emptyMessage="Nothing in here" />
                    </Tab>
                    <Tab className="p-3" eventKey="all" title="all orders">
                        <Orders orderItems={[...pendingItems,...deliveredItems,...cancelledItems]} emptyMessage="Nothing in here" />
                    </Tab>
                </Tabs>
            </div>
        </HeaderAndFooter>
    );
}

import {Table} from "react-bootstrap"

function Orders(props) {
    if(props.orderItems.length !== 0){
        return (
        <div>
            <Table bordered hover responsive>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Amount({currency})</th>
                        <th>Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody> 
                    {props.orderItems.map((order,idx) => 
                        <tr key={idx} onClick={()=>navigate("/orders/"+order._id)}>
                            <td>{idx+1}</td>
                            <td>{order.totalAmount}</td>
                            <td>{new Date(order.createdAt).toDateString()}</td>
                            <td>
                                <p className={"status status-"+order.status}>
                                    {order.status}
                                </p>
                            </td>
                        </tr>
                    )}
                </tbody>
            </Table>
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