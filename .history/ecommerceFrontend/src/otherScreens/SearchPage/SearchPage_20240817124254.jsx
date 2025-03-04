import HeaderAndFooter from "../../HeaderAndFooter";
import ProductCard from "../../components/ProductCard";
import Loading from "../../components/Loading";

import { useParams } from "react-router-dom";
import { useContext, useEffect, useState } from "react";
import { MyContext } from "../../configuration/context_config";
import { backend_link } from "../../App"

// react-icons
import { FcSearch } from "react-icons/fc";
import { FaFilter } from "react-icons/fa";

// react-bootstrap
import { Pagination, Modal } from "react-bootstrap";

import "./main.css"

function SearchPage() {
    const context = useContext(MyContext);
    const all_products = context["products"]

    const [loading, setLoading] = useState(true)
    const [showFilters,setShowFilters] = useState(false); // whether to show search filter modal

    const params = useParams();
    const search_text = params["search_text"]

    const [srchResults,setSrchResults] = useState([]);
    const [filters,setFilters] = useState({}); // these contain the filters the user selected => ex:MaxPrice,MinPrice,etc..
    const [filteredResults, setFilteredResults] = useState([]); // It is filtered search results
    // Basically, srchResults consists of all the results, but filteredResults is searchResults but filtered
    const [sortBy,setSortBy] = useState("relevance"); // to know what user has selected in sort_by menu // default is relevance(no sorting)
    const [currentPageNumber,setCurrentPageNumber] = useState(0); // for paginations (current page) (starts from 0)
    const [number_of_pages,setNumber_of_pages] = useState(1); // for paginations (total number of pages)

    // now filter_options' vaiables:
    const [minPrice,setMinPrice] = useState(0) // by default, the minimum price is 0
    const [maxPrice,setMaxPrice] = useState(0) // by default, the maximum price is also 0 (but later we will change it to the actual max price from the search results)
    const [brands, setBrands] = useState([]) // by default, it will be an empty list, but we will change it to have all the brands from the search results so that the user could choose from them in the filter menu
    const [selectedBrands, setSelectedBrands] = useState([]) // basically the brands the user selected from the filter menu
    const [categories, setCategories] = useState([]) // by default, it will be an empty list, but we will change it to have all the categories from the search results so that the user could choose from them in the filter menu
    const [selectedCategories, setSelectedCategories] = useState([]) // basically the categories the user selected from the filter menu
    useEffect(()=>{
        const getProducts = async () => {
            setLoading(true)
            try{
                const body = { filters:{} } // empty filters initially as no filters are currently applied
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
                
                // todo: get the filter-data from backend and assign them below
                const res = await fetch(backend_link+"/getFilterOptions/"+search_text+"/")
                const filter_data = await res.json()
                // then we assign these values to the useState variables
                setMaxPrice(filter_data["maxPrice"]);
                setBrands(filter_data["brands"]);
                setSelectedBrands(filter_data["brands"]); // initially, all brands are selected
                setCategories(filter_data["categories"]);
                setSelectedCategories(filter_data["categories"]); // initially, all categories are selected
                // also set this:
                setMinPrice(1);
                console.log(brands)
            }catch(e){
                console.log(e)
                throw Error("Error!")
            }
            setLoading(false)
        }

        // Also our method for finding the search results: (not used currently)
        const getProducts2 = () => {
            const results = []
            all_products.forEach(i => {
                if(i["title"].toLowerCase().includes(search_text.toLowerCase())){
                    results.push(i)
                }
            })
            setSrchResults(results)
        }

    getProducts()
    }, [search_text]) // we have to manually set params so that it updates

    // below is for sorting results
    const sortResults = e => {
        const sort_by = e.target.value;
        setSortBy(sort_by)
        const body = { filters:filters } 
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
        const body = { filters:filters }
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
                            Sorry, we could not find any results for <b>"{search_text}".</b>
                            <br />
                            Please try another search.
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
                    <h3 className="text-center text-srch">
                        Showing search results for: 
                        <b>"{search_text}"</b>
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
                                        <label htmlFor="minPriceSrch" className="form-label">Minimum Price &nbsp;</label>
                                        <input type="number" className="form-contorl text-center" 
                                        id="minPriceSrch" required 
                                        value={minPrice} min={1} onChange={value => setMinPrice(value)} />
                                    </div>
                                    <div className="form-group mb-2">
                                        <label htmlFor="maxPriceSrch" className="form-label">Maximum Price &nbsp;</label>
                                        <input type="number" className="form-contorl text-center"
                                         id="maxPriceSrch" required 
                                         value={maxPrice} min={1} onChange={value => setMaxPrice(value)} />
                                    </div>
                                    <h4>Brands &nbsp;</h4>
                                    <div className="ml-auto">
                                        {brands.map((brand,idx) => 
                                            <>
                                                <input type="checkbox"
                                                value={brand} 
                                                name="brandFilter" // basically to group these inputs together as "brandFilter"
                                                id={brand}
                                                checked={selectedBrands.includes(brand)} // mark it as checked, if it is something user selected
                                                onClick={ () => {
                                                    newSelectedBrands = [...selectedBrands]
                                                    newSelectedBrands.splice(idx,1); // 2nd parameter means remove one item only
                                                    setSelectedBrands(newSelectedBrands);
                                                } } 
                                                />                                                
                                                <label htmlFor={brand}>&nbsp;{brand}</label>
                                                <br />
                                            </>
                                        )}
                                    </div>
                                    <h4 className="mt-3">Category &nbsp;</h4>
                                    <div className="ml-auto">
                                            {categories.map(category =>
                                                <>
                                                    <input type="checkbox"
                                                    value={category} 
                                                    name="categoryFilter" // basically to group these inputs together as "categoryFilter"
                                                    id={category}
                                                    checked={selectedCategories.includes(category)} // mark it as checked, if it is something user selected
                                                    />
                                                    <label htmlFor={category}>&nbsp;{category}</label>
                                                    <br />
                                                </>
                                            )}
                                    </div>
                                    <div className="mt-3 d-flex justify-content-center">
                                        <button className="btn btn-outline-danger">Reset</button>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {/* Some horizontal spacing between these buttons */}
                                        <button className="btn btn-outline-success">Apply</button>
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

export default SearchPage;
