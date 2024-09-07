
// first fo thru ProductsTypes.jsx, thats the main file
// After user clicks on a product-type from the long list of product-types,
// We will show user the products having that product type under that category
// The interface here is similar to searchPage.jsx
// so it would be better to go thru it first to understand this

import HeaderAndFooter from "../../HeaderAndFooter";
import ProductCard from "../../components/ProductCard";
import Loading from "../../components/Loading";

import { useParams } from "react-router-dom";
import { useEffect, useState } from "react";
import { backend_link } from "../../App"

// react-icons
import { FcSearch } from "react-icons/fc";
import { FaFilter } from "react-icons/fa";

// react-bootstrap
import { Pagination, Modal, Accordion } from "react-bootstrap";

const search_text = "everything" //"everything" is basically like a code to backend
// if "everything" is given for search_text, bakcend understands that we dont really require search_text and would give every product matching the filter
// This is not a searchPage, thus we dont require search_text

function ProductsFromProductType() {

    const [loading, setLoading] = useState(true)
    const [showFilters,setShowFilters] = useState(false); // whether to show search filter modal

    // so basically url will have : /category/productType
    // our task is to get products with that productType under that category
    const params = useParams();
    const category = params["category"]
    const productType = params["productType"]

    const [srchResults,setSrchResults] = useState([]);
    const [filters,setFilters] = useState({}); // these contain the filters the user selected => ex:MaxPrice,MinPrice,etc..
    const [sortBy,setSortBy] = useState("relevance"); // to know what user has selected in sort_by menu // default is relevance(no sorting)
    const [currentPageNumber,setCurrentPageNumber] = useState(0); // for paginations (current page) (starts from 0)
    const [number_of_pages,setNumber_of_pages] = useState(1); // for paginations (total number of pages)

    // now filter_options' vaiables:
    const [brandsList, setBrandsList] = useState([]) // by default, it will be an empty list, but we will change it to have all the brands from the search results so that the user could choose from them in the filter menu
    const [selectedBrands, setSelectedBrands] = useState([]) // basically the brands the user selected from the brandsList filter menu
    const [selectedMinPrice,setSelectedMinPrice] = useState(1) // by default, the selected minimum price is 1
    const [selectedMaxPrice,setSelectedMaxPrice] = useState(0) // by default, the selected maximum price is also 0 (but later we will change it to the max price from the search results)

    useEffect(()=>{
        const getProducts = async () => {
            setLoading(true)
            try{
                const body = { filters:{category:category,type:productType} } // no extra filters initially as no extra filters are currently applied by the user, but only our filters are there to fetch products of this specific type under a specific category
                const requestParams = {
                    method:"POST",
                    headers:{"Content-Type":"application/json"},
                    body: JSON.stringify(body)
                }
                const response = await fetch(backend_link+"/getSearchResults/"+search_text+"/"+sortBy+"/0/", requestParams)
                const data = await response.json()
                setNumber_of_pages(data["numberOfPages"])
                setSrchResults(data["searchResults"])

                // then we will also set the values for filter-options' variables so that the filters are shown with proper values when user chooses from them
                
                // getting the filter-data from backend only if srchResults is not empty
                if(data["searchResults"].length !== 0){
                    const requestParams = {
                        method:"POST", headers:{"Content-Type":"application/json"},
                        body: JSON.stringify( { search_text:search_text, filters:{} } ) 
                    }
                    const res = await fetch(backend_link+"/getFilterOptions/", requestParams)
                    const filter_data = await res.json()
                    // so now we have to find the list of all brands and also the maxPrice
                    // first: getting maxPrice
                    
                    // then we assign these values to the useState variables
                    setSelectedMaxPrice(filter_data["maxPrice"]);
                    setBrandsList(filter_data["brands"]); // list of all the brands the search-result contains from which the user chooses
                    setSelectedBrands(filter_data["brands"]); // initially, all brands are selected
                    // Note: we also get CategoriesList form backend, but we dont actually need it in this screen as it is only one category unlike searchResults-page
                    // and then selectedMinPrice is left, but it doesnt need to be set, as it is already set while creating its variable
                }
            }catch(e){
                console.log(e)
                throw Error("Error!")
            }
            setLoading(false)
        }

    getProducts()
    }, []) // runs only once

    // below is for sorting results
    const sortResults = e => {
        const sort_by = e.target.value;
        setSortBy(sort_by)
        const body = { filters:{ category:category,type:productType, ...filters } } 
        const requestParams = {
            method:"POST",
            headers:{"Content-Type":"application/json"},
            body: JSON.stringify(body)
        }
        fetch(`${backend_link}/getSearchResults/${search_text}/${sort_by}/0/`, requestParams)
        .then(res => res.json())
        .then(data => {
            setSrchResults(data["searchResults"]);
        })
        .catch(err => {}) // do nothing incase of error (for now)
    }

    // below will change page number and navigate us to that page
    const gotoPage = idx => {
        const body = { filters:{ category:category,type:productType, ...filters } }
        const requestParams = {
            method:"POST",
            headers:{"Content-Type":"application/json"},
            body: JSON.stringify(body)
        }
        fetch(`${backend_link}/getSearchResults/${search_text}/${sortBy}/${idx}/`, requestParams)
        .then(res => res.json())
        .then(data => {
            setSrchResults(data["searchResults"]);
            setCurrentPageNumber(idx) // so that it gets that active-class
        })
        .catch(err => {}) // do nothing incase of error (for now)
    }


    // below will run after user clicks "apply filters" after selecting some filters from the filter menu
    function applyFilters(){
        //  we will get all the filters that the user selected
        // maxPrice and minPrice useState vars consist of the entered values in the input-field
        const minimumPrice = parseFloat(document.getElementById("minPriceFilter").value)
        const maximumPrice = parseFloat(document.getElementById("maxPriceFilter").value)
        // so no we only want the selected brands from the document
        const userSelectedbrnds = []; // brands that user selected
        document.getElementsByName("brandFilter").forEach( brand => brand.checked ? userSelectedbrnds.push(brand.value) : null );
        // basically add brands which are selected by the user to the userSelectedbrnds-list (note: we dont have category-selection here in filter-menu)
        // then we set the newly created userSelectedCats to our state-var so when then user opens the filter menu next time, he sees the same selected stuff
        setSelectedBrands(userSelectedbrnds); // as user selected these brands
        setSelectedMaxPrice(maximumPrice) // as user selected this price
        setSelectedMinPrice(minimumPrice) // as user selected this price
        // then we set the Filter var
        const filt =  {
            price : {"$gte":minimumPrice, "$lte":maximumPrice},
            brand : {"$in":userSelectedbrnds},
        }
        setFilters(filt);

        setShowFilters(false); // closing the filter-menu-screen
        
        // and then we then fetch the filtered-results from backend and set it to srchResult variable to display it
        // starting our task of fetching filtered-results form backend 
        setLoading(true);

        setCurrentPageNumber(0); // setting it to 0, as we r getting new set of search-results, so we need to be at first page
        setSortBy("relevance");  // setting it to relevance, as we r getting new set of search-results, so we need to be at default-sorting
        
        const body = { filters:{ category:category,type:productType, ...filt } } // so we want products of this productType under this category, and we r also applying filt-variable which mught contain any filters the user selected
        // console.log(filters); // we will get the default empty object instead of the one we set above using setFilters
        // which is why we r using the hardcoded filters-object (filt-variable) in the "body" object
        const requestParams = {
            method:"POST",
            headers:{"Content-Type":"application/json"},
            body: JSON.stringify(body)
        }
        fetch(`${backend_link}/getSearchResults/${search_text}/relevance/0/`, requestParams)
        .then(res=>res.json())
        .then(data => {
            setSrchResults(data["searchResults"])
            console.log(data["searchResults"])
            setNumber_of_pages(data["numberOfPages"])
            setLoading(false); // task completed
        })
        .catch(err => {
            console.log(err);
            alert("error!")
            setLoading(false);
        });
    }


    // This function resets the filter to default values and then applies them
    async function resetFilters () {
        // first we will tick all the checkboxes from both the brandsList and the CategoriesList
        document.querySelectorAll("input[type='checkbox']").forEach(inp => inp.checked=true)
        // then we will set the maxPrice and minPrice to default
        const requestParams = {
            method:"POST", headers:{"Content-Type":"application/json"},
            body: JSON.stringify( { search_text:"everything", filters:{category:category,type:productType} } ) // search_text="everything" is basically a code for backend to understand that we dont really have a search_text 
        }
        const res = await fetch(backend_link+"/getFilterOptions/", requestParams) // for getting maxPrice data
        const filter_data = await res.json()
        document.getElementById("minPriceFilter").value = 1
        document.getElementById("maxPriceFilter").value = filter_data["maxPrice"]
        // note: we r only changing the value of the text field and not the selectMinPrice and selectedMaxPrice variables
        // These vars will only get their values if user clicks on apply-button
    }

    if(loading){
        return <Loading />
    }else if(!loading){
        if(srchResults.length === 0){ // if no results
            return (
                <HeaderAndFooter>
                    <div className="container border shadow-lg text-center">
                        <h3 className="display-4 mt-3 mb-4">
                            <FcSearch size="2em" />
                            No Results...
                        </h3>
                        <h5 className="text-muted">
                            Sorry, we could not find any results
                            <br />
                            Please try to change filters.
                        </h5>
                        <p className="mt-4 border p-3 d-inline-block">
                            Can't find what you are looking for? <br />
                            Contact <a href="mailto:adistar964@gmail.com">Customer service </a>
                            <br />
                            Or call: +000 1234567
                        </p>
                    </div>
                </HeaderAndFooter>
            )
        }else{
            return (
                <HeaderAndFooter>
                    <h3 className="display-6 text-search">{category}</h3>
                    <h3 className="text-center text-srch">
                        showing results for <b>{productType}</b>
                    </h3>
                    <div className="container border shadow-lg p-2">
                        <div className="d-flex justify-content-between mb-5 mt-3 mx-3">
                            <button onClick={()=>setShowFilters(true)} 
                            className="btn btn-outline-theme rounded-4">
                                Show Filters &nbsp;
                                <FaFilter />
                            </button>
                            <div>
                                <label htmlFor="searchSort"><b>Sort By</b></label> &nbsp;
                                <select className="form-select mt-0 pt-0" 
                                id="searchSort" onChange={sortResults}>
                                    <option value="relevance">relevance</option>
                                    <option value="alphabetical">Name (A-Z)</option>
                                    <option value="antiAlphabetical">Name (Z-A)</option>
                                    <option value="priceLowest">Price (lowest first)</option>
                                    <option value="priceHighest">Price (highest first)</option>
                                    <option value="discount">Discount</option>
                                </select>
                            </div>
                        </div>
                        <div className="cards-container mb-3">
                            {srchResults.map(prod =>
                                <ProductCard product_id={prod["_id"]}
                                price={prod["price"]}
                                title={prod["title"]}
                                discountPrice={prod["discountPrice"]}
                                thumbnail={prod["thumbnail"]}
                                maxQuantityForAUser={prod["maxQuantityForAUser"]}/>
                            )}
                        </div>
                        
                        {/* We will have a modal for showing search filters */}
                        <Modal show={showFilters} onHide={()=>setShowFilters(false)}>
                            <Modal.Header closeButton>
                                <Modal.Title>Search Filters</Modal.Title>
                            </Modal.Header>
                            <Modal.Body>
                                <div className="text-center">
                                    <h4>Budget</h4>
                                    <div className="form-group">
                                        <label htmlFor="minPriceFilter" className="form-label">Minimum Price &nbsp;</label>
                                        <input type="number" className="form-contorl text-center" 
                                        id="minPriceFilter" required 
                                        defaultValue={selectedMinPrice} min={1} />
                                    </div>
                                    <div className="form-group mb-2">
                                        <label htmlFor="maxPriceFilter" className="form-label">Maximum Price &nbsp;</label>
                                        <input type="number" className="form-contorl text-center"
                                         id="maxPriceFilter" required 
                                         defaultValue={selectedMaxPrice} min={1} />
                                    </div>
                                    {/* Now we will use Accordions for selecting brand (go thru React-Bootstrap docs) */}
                                    {/* Also, we dont have category-selection here unlike searchResultsPage */}
                                    <Accordion>
                                        <Accordion.Item eventKey="0"> {/* Event-Key is basically like ID which is required in each Accordion-item even tho it might not be used */}
                                            <Accordion.Header>
                                                Brands
                                            </Accordion.Header>
                                            <Accordion.Body>
                                                <input type="checkbox"
                                                id="allBrands"
                                                defaultChecked={selectedBrands.length==brandsList.length} // mark it as checked, if user selected everything from the brands-list
                                                onClick={inp => {
                                                    if(inp.target.checked){ // if someone checked it, then check all the brands from the brandsList
                                                        document.querySelectorAll("input[name='brandFilter']").forEach(inp => inp.checked=true)
                                                    }else{ // otherwise, un-check all brands
                                                        document.querySelectorAll("input[name='brandFilter']").forEach(inp => inp.checked=false)
                                                    }
                                                }}
                                                />
                                                <label htmlFor="allBrands">&nbsp;All</label>
                                                <br />
                                                {brandsList.map(brand =>
                                                    <>
                                                        <input type="checkbox"
                                                        value={brand}
                                                        name="brandFilter" // basically to group these inputs together as "brandFilter"
                                                        defaultChecked={selectedBrands.includes(brand)} // mark it as checked, if it is something user selected
                                                        onClick={inp => {
                                                            // if anyone un-checks any brand from the list, then the top-option "all" must be unchecked as well, as now not all brands are checked
                                                            if(inp.target.checked == false){ 
                                                                document.getElementById("allBrands").checked = false
                                                            }
                                                        }}
                                                        />
                                                        <label htmlFor={brand}>&nbsp;{brand}</label>
                                                        <br />
                                                    </>
                                                )}
                                            </Accordion.Body>
                                        </Accordion.Item>
                                    </Accordion>
                                    <div className="mt-3 d-flex justify-content-center">
                                        <button className="btn btn-outline-danger" onClick={resetFilters}>Reset</button>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {/* Some horizontal spacing between these buttons */}
                                        <button className="btn btn-outline-success" onClick={applyFilters}>Apply</button>
                                    </div>
                                </div>
                            </Modal.Body>
                        </Modal>

                        {/* only render pagination if there are more than 1 pages */}
                        {number_of_pages !== 1 ? 
                            <Pagination size="lg" className="mt-3 mb-3 d-flex justify-content-center">
                                {/* Previous button */}
                                <Pagination.Prev onClick={()=>gotoPage(currentPageNumber-1)} 
                                disabled={currentPageNumber+1==1}/>
                                
                                {/* All page buttons */}
                                { [...Array(number_of_pages).keys()] // like pyton range function
                                .map(i => 
                                <Pagination.Item onClick={() => gotoPage(i)} active={currentPageNumber===i} 
                                key={i}>
                                    {i+1} {/* i+1 as i starts from 0, but we want to display from 1 */}
                                </Pagination.Item> 
                                )}

                                {/* Next button */}
                                <Pagination.Next onClick={()=>gotoPage(currentPageNumber+1)} disabled={currentPageNumber+1==number_of_pages} />     
                            </Pagination>    
                        : ""}
                    </div>
                </HeaderAndFooter>
            )
        }
    }
}

export default ProductsFromProductType;
