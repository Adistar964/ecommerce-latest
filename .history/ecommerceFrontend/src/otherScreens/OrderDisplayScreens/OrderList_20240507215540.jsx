

// importing components
import HeaderAndFooter from "../../HeaderAndFooter";

// importing from react-bootstrap
import { Tabs,Tab } from "react-bootstrap";

export default function OrderList() {
    return(
        <HeaderAndFooter>
            <div className="mt-3 mb-3 container shadow p-3">
                {/* inside <Tabs /> we will have many <Tab /> */}
                <Tabs defaultActiveKey="pending">
                    <Tab eventKey="pending" title="pending"> {/* eventKey is used for switching tabs and title is what user sees as tab-title */}
                        hey there
                    </Tab>
                    <Tab eventKey="delivered" title="delivered">
                        Delivered
                    </Tab>
                </Tabs>
            </div>
        </HeaderAndFooter>
    );
}