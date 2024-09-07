import HeaderAndFooter from "../../HeaderAndFooter";

export default function () {
    return(
        <HeaderAndFooter>
                <div className="container border border-secondary mt-5 p-3">
                    <h3 className="text-center">
                        <i>
                            Sorry, The page you were looking for was not found!
                        </i>
                    </h3>
                    <div className="d-flex flex-column justify-content-center align-items-center mt-5 mb-5">
                        <img src="../../../public/no-results.png"
                        width={250}
                        height={250}
                        alt="no-results" />
                        <button className="btn btn-light border border-dark mt-4">
                            <img src="../../../public/shopping-cart.gif"
                            width={40}
                            height={40}
                            />
                            &nbsp;&nbsp;Continue Shopping&nbsp;&nbsp;
                        </button>
                    </div>
                </div>
        </HeaderAndFooter>
    );
}