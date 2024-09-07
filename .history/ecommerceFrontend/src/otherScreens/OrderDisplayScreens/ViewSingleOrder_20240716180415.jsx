
// importing components
import HeaderAndFooter from "../../HeaderAndFooter";
import Loading from "../../components/Loading"
import Error from "../Error/Error";
import { backend_link, currency } from "../../App";
import { MyContext } from "../../configuration/context_config";
import "./orderstyles.css"

// importing from react
import { useState, useEffect, useContext } from "react";
import { useNavigate, useParams } from "react-router-dom";

// importing form react-icons
import { FaArrowsRotate,FaRegCircleQuestion,FaTruck } from "react-icons/fa6";
import { LuClipboardList } from "react-icons/lu";
import { TiTick } from "react-icons/ti";
import { RxCross2 } from "react-icons/rx";

// import from react-bootstrap
import { ProgressBar } from "react-bootstrap";
import { OverlayTrigger, Tooltip } from "react-bootstrap"; // for showing tooltips, we also need to wrap it in OverlayTrigger
// react-toastify => for notifications
import { toast } from "react-toastify";

const description =
  'Here is an informative description, here is an informative description, here is an informative description, here is an informative description, here is an informative description, here is an informative description' ;


export default function ViewSingleOrder(){

    const context = useContext(MyContext)
    const navigate = useNavigate()

    const [loading, setLoading] = useState(true)
    const [found, setFound] = useState(false) // we will throw 404 Error if the order _id is invalid(no order found with that _id)

    const {order_id} =  useParams();
    const [order, setOrder] = useState({})

    // for fetching order with _id=order_id(from params)
    useEffect(() => {
    setLoading(true)
    const getOrderItem = async () => {
        try{
            const body = {
                user_id:context["user"]["uid"],
                order_id:order_id, // from the params
            }
            const request_parameters = {
                method:"POST",
                headers:{"Content-Type":"application/json"},
                body: JSON.stringify(body)
            }
            const response = await fetch(backend_link+"/getSingleOrder/",request_parameters)
            const data = await response.json()
            setOrder(data["order"]) // order-item from backend
            setFound(true) 
        }
        catch(error){setFound(false)} // incase of any error, we will show 404 page
    }

    if(context.loading === false){ // make sure everything s loaded first
        if(context["user"]!==null){
            getOrderItem()
        }else{
            setFound(false) // if the user is not signed in, throw a 404 error
        }
        setLoading(false) // atlast after everything is done
    }
        
    }, [order_id, context["user"]])

    // for copying order_id to clipboard
    const copyOrderId = ()=>{
        navigator.clipboard.writeText(order._id);
        toast.success("copied to clipboard")
    }

    const orderTrackingMsg = () => {
    // this will return the message we show to customers in accordance to order status
    // example: if order-status is pending, then the above will be smth like: "your order is being processed for delivery"
    const order_status = order["status"]
    if(order_status === "pending"){
        return "Your order is being proccessed and will soon be sent for delivery in accordance with the delivery time"
    }else if(order_status === "arriving"){
        return "Your order was shipped to your desired shipping location and will soon reach your doorsteps"
    }else if(order_status === "delivered"){
        return "Your order was delivered to your desired shipping location already"
    }else if(order_status === "cancelled"){
        return "This order was seemingly made cancelled, so the order will not be delivered. If this was'nt you, then please contact our support team"
    }
    }

    if(loading){
        return (<Loading />);
    }else{
        if(found){
            return (
                <HeaderAndFooter>
                <h4 className="text-center display-5">
                    ORDER INFO
                </h4>
                <div className="container shadow-lg border">
                    <div style={{width:"39ch"}} // ch means charachter => best suited as it is font independent
                    className="mt-3 m-auto">
                        <div className="input-group">
                            <div className="input-group-prepend">
                                <div className="input-group-text">Order-id</div>
                            </div>
                            <input value={order._id} type="text"
                            className="form-control" disabled />
                            <div className="input-group-append">
                                <button onClick={copyOrderId}
                                className="input-group-button btn btn-outline-theme"><LuClipboardList /></button>
                            </div>
                        </div>
                    </div>
                    <div className="d-flex justify-content-around mt-3 mb-4">
                        <div className="card p-3 pb-0 border-warning">
                            Ordered at
                            <p className="text-muted">
                                {new Date(order.createdAt).toDateString()}
                            </p>
                        </div>
                        <div className="card p-3 pb-0 border-info">
                                <OverlayTrigger 
                                overlay={<Tooltip>This is just an approximation, the actual delivery-time may differ</Tooltip>}>
                                    {/* <FaRegCircleQuestion type="button" /> */}
                                    <button className="border-0 bg-white">
                                    Delivery Expected &nbsp;
                                    <FaRegCircleQuestion />
                                    </button>
                                </OverlayTrigger>
                            <p className="text-muted">
                                {new Date(order.deliverySlot["date"]).toDateString()}
                                <br />
                                {`${order.deliverySlot["startTime"]} AM - ${order.deliverySlot["endTime"]} AM`}
                            </p>
                        </div>
                    </div>
                    <hr className="mb-4" />
                    <div id="order-status">
                        <h3 className="text-center">Order Status</h3>

                        <ProgressBar now={order.status=="pending"?50:100}
                         animated className="m-5 mb-1 mt-2" />

                        <div className="d-flex justify-content-between">
                            <p className="d-flex">
                                Payment
                                <TiTick size="1.5em" color="green" />
                            </p>
                            <p className="d-flex">
                                Processing &nbsp;
                                {order.status=="pending"?
                                <FaArrowsRotate size="1.2em" color="orange" /> : 
                                order.status=="cancelled" ? 
                                <RxCross2 size="1.5em" color="red" /> : 
                                <TiTick size="1.5em" color="green" /> }
                            </p>
                            <p className="d-flex">
                                {order.status=="cancelled" ? "cancelled" :
                                 order.status=="delivered"?
                                 <p>
                                     Delivered
                                     <TiTick size="1.5em" color="green"/>
                                 </p> :
                                 order.status=="arriving" ? 
                                 <p>
                                    Arrving &nbsp;
                                    <FaTruck  size="1.5em" color="orange" />
                                 </p> : "Delivery" }
                            </p>
                        </div>
                        
                        <div className="text-center">
                            <p className="text-muted border rounded-2 d-inline-block p-2">
                                {
                                orderTrackingMsg() // will return order-tracking message based on order-status
                                }
                            </p>
                        </div>
                    </div>
                    <hr className="mb-4" />
                        <h3 className="text-center">Shipping Details</h3>
                        <div className="form-group mb-2">
                            <label htmlFor="recipient" className="form-label">Recipient</label>
                            <input type="text" value={order.shippingDetails.name}
                             className="form-control" 
                            id="recipient" disabled/>
                        </div>
                        <div className="form-group mb-2">
                            <label htmlFor="city" className="form-label">City</label>
                            <input type="text" value={order.shippingDetails.address.city}
                             className="form-control" 
                            id="city" disabled/>
                        </div>
                        <div className="form-group mb-2">
                            <label htmlFor="addressorderview" className="form-label">Country</label>
                            <input type="text" value={order.shippingDetails.address.country}
                             className="form-control" 
                            id="addressorderview" disabled/>
                        </div>
                        <div className="form-group mb-5">
                            <label htmlFor="addressorderview" className="form-label">Address lines:</label>
                            <input type="text" value={order.shippingDetails.address.line1}
                             className="form-control" 
                            id="addressorderview" disabled/>
                            <input type="text" value={order.shippingDetails.address.line2}
                             className="form-control mt-3" 
                            id="addressorderview" disabled/>
                        </div>
                    <hr className="mb-5" />
                    <h3 className="text-center mt-5 mb-4">Ordered Products</h3>
                    <ul style={{listStyle:"none"}}>
                        {order["products"].map(item => 
                        <li style={{justifyContent:"space-between", cursor:"pointer",transition:"all 0.5s"}} 
                        className="w-100 border d-flex p-3 pr-0 align-items-center cart-item-hover">
                            <div style={{flexGrow:"1",gap:"2em"}} 
                            className="d-flex">
                                <img onClick={()=>navigate("/product/"+item.product_id)}
                                src={item.thumbnail} className="cart-img"
                                style={{cursor:"pointer"}} />
                                <div className="flex-grow-1">
                                    <h5 onClick={()=>navigate("/product/"+item.product_id)}
                                    style={{cursor:"pointer",textAlign:"left"}}>
                                        {item.product_name}
                                    </h5>
                                    <p className="p-3 d-flex align-items-center">
                                        Qty&nbsp;
                                        <span className="border p-2">{item.quantity}</span>
                                    </p>
                                </div>
                            </div>
                            <p style={{fontFamily:"verdana"}}>QAR <b>{(item.price-item.discountPrice)*item.quantity}</b></p>
                        </li>
                        )}
                    </ul>
                    <hr />
                    <div className="text-center">
                        <p style={{
                            fontFamily:"Poppins",
                            fontSize:"1.5em",
                            padding:"10px",
                            display:"inline-block"
                        }} className="border border-info rounded-5 px-4">
                            TOTAL: &nbsp;
                            {currency} {order.totalAmount}
                        </p>
                    </div>
                </div>
            </HeaderAndFooter>
            );
        }else if(!found){
            return (
                <Error />
            );
        }
    }
}