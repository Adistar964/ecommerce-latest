
import Header, {Footer} from "../../HeaderAndFooter";



export default function SignIn(){
    return(
        <>
            <Header />
            <div style={{backgroundColor:"rgb(50, 146, 255)",display:"flex",marginTop:0,marginBottom:0}}>
                <div style={{backgroundColor:"white"}} 
                className="container border border-dark p-5 mb-5">
                    <p>
                        Login
                    </p>
                </div>
            </div>
            <Footer />
        </>
    );
}