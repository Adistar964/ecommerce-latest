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
                    <img src="../../../public/no-results.png" alt="" />
                </div>
        </HeaderAndFooter>
    );
}