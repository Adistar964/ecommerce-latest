

// importing components
import { useState } from "react";
import HeaderAndFooter from "../../HeaderAndFooter";

// importing from react-bootstrap
import { Tabs,Tab } from "react-bootstrap";

export default function OrderList() {
    const [pendingItems,setPendingItems] = useState([]);
    const [deliveredItems,setDeliveredItems] = useState([]);
    const [cancelledItems,setCancelledItems] = useState([]);

    return(
        <HeaderAndFooter>
            <div className="mt-3 mb-3 container shadow border border-3 border-top-0">
                {/* inside <Tabs /> we will have many <Tab /> */}
                <Tabs defaultActiveKey="pending" fill variant="tabs" className="border border-2">
                    <Tab className="p-3" eventKey="pending" title="pending orders"> {/* eventKey is used for switching tabs and title is what user sees as tab-title */}
                        <Orders orderItems={pendingItems} />
                    </Tab>
                    <Tab className="p-3" eventKey="delivered" title="delivered orders">
                        Delivered
                    </Tab>
                    <Tab className="p-3" eventKey="cancelled" title="cancelled orders">
                        Cancelled
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