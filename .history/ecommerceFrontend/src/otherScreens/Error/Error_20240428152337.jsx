import HeaderAndFooter from "../../HeaderAndFooter";

export default function () {
    return(
        <HeaderAndFooter>
                <div className="container border border-secondary mb-5 mt-5 p-3">
                    <h3 className="text-center">
                        <i>
                            Sorry, The page you were looking for was not found
                        </i>
                    </h3>
                    <div className="text-center">
                        <img src="../../../public/no-results.png"
                        width={250}
                        height={250}
                        alt="no-results" />
                    </div>
                </div>
        </HeaderAndFooter>
    );
}