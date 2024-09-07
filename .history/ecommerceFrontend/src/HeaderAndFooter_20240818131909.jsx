
// importing from react-router-dom
import { useNavigate } from "react-router-dom";
// importing the context we created to access info(users,cart,etc..)
import { MyContext } from "./configuration/context_config";
// importing constants
import { backend_link } from "./App"
// importing from react
import { useContext, useEffect, useRef, useState } from "react";

// importing icons
import { BsCart,BsPersonCircle,
          BsSearch
        } from "react-icons/bs";
import { FaHouse,FaLocationDot,
        FaPhone,FaTwitter,FaFacebookF,FaLinkedinIn
        } from "react-icons/fa6";
import { MdEmail } from "react-icons/md";
export default function HeaderAndFooter(props){
  // this will help in navigating from pages to pages
    const navigate = useNavigate()

    // accessing the srch-inp
    const srchInp = useRef();

    // access our context
    const context = useContext(MyContext)
    const cart = context["cart"]

    // cart_length
    const [cartLength,setCartLength] = useState("")
    // cartLen is not only number of items in cart,
    //  but their total quantities
    // for example if we have 2 iphoneX and 3 apples
    // number of items in Cart is 2
    // but total cart_length is 5 (quantities)

    useEffect(() => {
      let length = 0
      cart.forEach(item => {
          length = length + item["quantity"]
      })
      setCartLength(length)
    },[cart])


    // we will also fetch the list of all categories to display it in the header
    const [categories, setCategories] = useState([])

    useEffect(() => {
      fetch(backend_link + "/fetchAllProductCategories/").then(res => res.json())
      .then(cats => setCategories(cats))
    }, []) // will only run intially to fetch categories

    return(
        <>
        <header className="d-flex">
          <p className="logo-name p-2">
            964Ecommerce
            <span className="latest">
              (latest)
            </span>
          </p>
          <form onSubmit={e=>{e.preventDefault();navigate(`/search/${srchInp.current.value}/`);}} 
          className="srchinp">
              <input type="text" ref={srchInp} 
              minLength="3"
              required
              placeholder="What are you looking for?"
              className="form-control" />
              <button className="btn-srch btn-theme">
                <BsSearch size="1.3em" />
              </button>
          </form>
          <div className="authbtns">
            {context["user"] === null ? 
            <button onClick={()=>{navigate("/login/",{replace:true})}} 
            className="btn-header-outline p-2"
             style={{borderRadius:"5px",display:"flex", alignItems:"center"}}>
              <BsPersonCircle size="1.8em" /> &nbsp;
              LOGIN/SIGNUP
            </button> :
            <button onClick={()=>{navigate("/profile/",{replace:true})}} 
            className="btn-header-outline p-2"
             style={{borderRadius:"5px",display:"flex", alignItems:"center"}}>
              <BsPersonCircle size="1.8em" /> &nbsp;
              PROFILE
            </button>  
          }
          </div>
          {/* we gave the position relative to place the badge */}
          <div style={{position:"relative",display:"flex",alignItems:"center",padding:"10px"}}>
            <button onClick={()=>navigate("/cart/")} 
            className="p-2 btn-header-outline"
            style={{borderRadius:"5px",display:"flex", alignItems:"center"}}>
                <BsCart size="1.7em" /> &nbsp;
                My Cart
                <span className="info-badge">
                  {cartLength}
                </span>
              </button>
          </div>
        </header>
          <nav className="EcommerceNav">
              <ul className="category_list border-right border-secondary">
                  <div onClick={()=>{navigate("/")}} 
                  className="HomeLogo">
                    <FaHouse className="mb-1" /> &nbsp; 
                    <span>Home</span>
                  </div>
                  {categories.map(category => 
                    <button>{category}</button>
                  )}
              </ul>
          </nav>
          {/* Then the content inside the <HeadAndFooter> tag */}
          {props.children} 
          {/* then comes the footer */}
          <br />
          <footer style={{minHeight:"300px", fontFamily:"Helvetica"}}>
            <h3 className="mt-3">&copy; 964Ecommerce-latest</h3>
            <div className="border border-light mt-3" />
            <div style={{fontFamily:"Poppins"}} 
            className="d-flex flex-wrap mt-3 justify-content-evenly">
                <div className="text-start">
                    <h4 className="mb-4">
                      For Queries
                    </h4>
                    <h6 className="mb-3">
                      <FaLocationDot size="3em" 
                      style={{backgroundColor:"rgb(44, 44, 44)"}}
                      className="border border-light rounded p-2" />
                      &nbsp; <small>21 Skierteff St.</small> <b>Doha,Qatar</b>
                    </h6>
                    <h6 className="mb-3">
                      <FaPhone size="3em" 
                      style={{backgroundColor:"rgb(44, 44, 44)"}}
                      className="border border-light rounded p-2" />
                      &nbsp; <b>+974 77889933</b>
                    </h6>
                    <h6>
                      <MdEmail size="3em" 
                      style={{backgroundColor:"rgb(44, 44, 44)"}}
                      className="border border-light rounded p-2" />
                      &nbsp; <b>support@964ecommerce.com</b>
                    </h6>
                </div>
                <div className="text-start">
                    <h4 className="mb-4">
                      Social Media
                    </h4>
                    <h6 className="mb-3">
                      <FaTwitter  size="3em" 
                      style={{backgroundColor:"rgb(44, 44, 44)"}}
                      className="border border-light rounded p-2" />
                      &nbsp; <b>Twitter</b>
                    </h6>
                    <h6 className="mb-3">
                      <FaFacebookF size="3em" 
                      style={{backgroundColor:"rgb(44, 44, 44)"}}
                      className="border border-light rounded p-2" />
                      &nbsp; <b>Facebook</b>
                    </h6>
                    <h6>
                      <FaLinkedinIn size="3em" 
                      style={{backgroundColor:"rgb(44, 44, 44)"}}
                      className="border border-light rounded p-2" />
                      &nbsp; <b>Linked-in</b>
                    </h6>
                </div>
            </div>
          </footer>
        </>
    );
}