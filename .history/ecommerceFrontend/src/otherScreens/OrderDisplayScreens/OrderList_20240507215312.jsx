

// importing components
import HeaderAndFooter from "../../HeaderAndFooter";

// importing from react-bootstrap
import { Tabs,Tab } from "react-bootstrap";

export default function OrderList() {
    return(
        <HeaderAndFooter>
            {/* inside <Tabs /> we will have many <Tab /> */}
            <Tabs defaultActiveKey="pending">
                <Tab eventKey="pending" title="pending"> {/* eventKey is used for switching tabs and title is what user sees as tab-title */}
                    hey there
                </Tab>
                <Tab eventKey="delivered">
                    Delivered
                </Tab>
            </Tabs>
        </HeaderAndFooter>
    );
}