import HeaderAndFooter from "../../HeaderAndFooter";
import { useContext, useEffect, useState } from "react";
import { MyContext } from "../../configuration/context_config";
import { backend_link, currency } from "../../App";
import ProductCard from "../../components/ProductCard";
import Loading from "../../components/Loading";
import "./Home.css"

// importing from rect-bootstrap
import { Carousel } from "react-bootstrap";

// miscellaneous components:
// import from react-type-animation
import { TypeAnimation } from "react-type-animation";
// import from react-scroll-to-top
import ScrollToTopArrow from "react-scroll-to-top";
// import from react-icons
import { MdOutlineKeyboardDoubleArrowUp  } from "react-icons/md";


function Home() {
  const context = useContext(MyContext);
  const [HomePageContent,setHomePageContent] = useState({});
  const [ loading,setLoading ] = useState(true)
  useEffect(() => {
      const getHomePage = async () => {
        const response = await fetch(`${backend_link}/getHomePageContent/`)
        let homePageDocument = await response.json()

        homePageDocument = {...homePageDocument}
        setHomePageContent(homePageDocument)
        setLoading(false)
      }

      getHomePage();
  }, [])

  const showProducts = elem => {
    let image_and_correspondingProducts = {...elem}
    let product_ids = image_and_correspondingProducts["products"]
    // // in "image_and_correspondingProducts" array,  
    // // we only have product_ids, but we need complete products (with their titles,etc..)
    // let products = []
    // for(let prod of context["products"]){
    //     for(let pid of product_ids){
    //       if(pid===prod["_id"]){
    //           products.push(prod)
    //       }
    //     }
    // }
    // image_and_correspondingProducts["products"] = products // now we no longer have only pids, but the products with complete info
    
    // now we will have to structure our products:
    // ex: from [1,2,3,4,5,6,7,8,9] to [[1,2,3].[4,5,6],[7,8,9]]
    // we could then use this structuring in carousel
    // where each carousel slide has five/three products
    let structuredProds = []
    let i = 0;
    while (i<image_and_correspondingProducts["products"].length){
      structuredProds.push(image_and_correspondingProducts["products"].slice(i,i+5))
      i = i+5;
    }
    image_and_correspondingProducts["products"] = structuredProds;
    return (
      <div className="mt-3 mb-3">
        <img src={image_and_correspondingProducts["image"]} 
        className="img-fluid p-5"/>
        {/*  
        touch => carousel will move on swipe(touchscreen devices)
        interval => after every 2s, it will slide
        */}
        <Carousel interval={2000} touch data-bs-theme="dark" className="p-5">
            {image_and_correspondingProducts["products"].map((prodlist,index) => 
              // prodlist is list with 3/5 products
              <Carousel.Item className="p-5" key={index}>
                <div className="cards-container">
                  {prodlist.map((prod,prodidx) =>
                          <ProductCard key={prodidx} product_id={prod["_id"]}
                          price={prod["price"]}
                          title={prod["title"]}
                          discountPrice={prod["discountPrice"]}
                          thumbnail={prod["thumbnail"]} 
                          maxQuantityForAUser={prod["maxQuantityForAUser"]}/>
                  )}
                </div>
              </Carousel.Item>
            )}
        </Carousel>
      </div>
    );
  }

  if(!loading){
    return (
      <HeaderAndFooter>
        {/* fade animation for Carousel */}
        {/* each slide stays up for 2000ms */}
      <Carousel fade data-bs-theme="dark" className="p-5">
          {HomePageContent["carousel images"].map(imgSrc => 
              <Carousel.Item className="pb-5" interval={3000}>
                <img className="w-100"
                src={imgSrc} />        
              </Carousel.Item>
          )}
      </Carousel>
      <div className="mt-3 mb-3 border text-center bg-dark text-light p-4"
      style={{fontSize:"2em "}}>
          {/* <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-send" viewBox="0 0 16 16">
            <path d="M15.854.146a.5.5 0 0 1 .11.54l-5.819 14.547a.75.75 0 0 1-1.329.124l-3.178-4.995L.643 7.184a.75.75 0 0 1 .124-1.33L15.314.037a.5.5 0 0 1 .54.11ZM6.636 10.07l2.761 4.338L14.13 2.576zm6.787-8.201L1.591 6.602l4.339 2.76z"/>
          </svg> */}
          <img src="../../../public/tap.png" alt="tap image"
          width="100px"
          height="100px" />
          <TypeAnimation
            sequence={[
              "964Ecommerce has the best imported products!",1000,// basically stop for 1s then continue
              "964Ecommerce has new deals!",1000, 
              "964Ecommerce is the right place to stop!",1000,
              "964Ecommerce is your go-to for everything!",1000,
              "964Ecommerce has everything you need!",1000,
            ]
            }
            speed={50}
            repeat={Infinity}
            />
      </div>
      {HomePageContent["images and products"].map(showProducts)}
      <div className="text-center p-0">
          <img className="border" 
          src="../../../public/banner1.jpg" alt="ecoproducts"
          width="100%"
          style={{display:"inline-block",transform:"scale(0.75,0.75)"}}
          />
      </div>

      {/* always add ScrollToTopArrow at the bottom */}
      {/* we will be applying custom class! */}
      <ScrollToTopArrow smooth color="white" 
      // Now we will add our custom up-arrow
      component={<MdOutlineKeyboardDoubleArrowUp size="1.8em" className="mb-1"/>}
      className="scroll-to-top-arrow" />

  </HeaderAndFooter>
    )
  }else{
    return <Loading />
  }
}

export default Home;
