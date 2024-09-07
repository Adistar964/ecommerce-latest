
import Header, {Footer} from "../../HeaderAndFooter";



export default function SignIn(){
    return(
        <>
            <Header />
            <div className="container border border-dark p-5 mb-5">
                <h3>
                    Login
                </h3>
            </div>
            {/* now we will pull that footer to the bottom */}
            <div style={{height:"47vh"}}></div> 
            <Footer />
        </>
    );
}