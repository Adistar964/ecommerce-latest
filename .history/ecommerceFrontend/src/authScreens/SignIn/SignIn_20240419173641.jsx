
import Header, {Footer} from "../../HeaderAndFooter";



export default function SignIn(){
    return(
        <>
            <Header />
            <main style={{backgroundColor:"rgb(50, 146, 255)"}}>
                <div style={{backgroundColor:"white"}} 
                className="container border border-dark p-5 mb-5">
                    <p>
                        Login
                    </p>
                </div>
                {/* now we will pull that footer to the bottom */}
                <div style={{height:"47vh"}}></div>
            </main>
            <Footer />
        </>
    );
}