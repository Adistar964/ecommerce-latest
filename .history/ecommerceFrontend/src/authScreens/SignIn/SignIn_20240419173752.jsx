
import Header, {Footer} from "../../HeaderAndFooter";



export default function SignIn(){
    return(
        <>
            <Header />
            <main style={{backgroundColor:"rgb(50, 146, 255)",display:"flex",alignItems:"center",justifyContent:"center"}}>
                <div style={{backgroundColor:"white",alignSelf:"center"}} 
                className="container border border-dark p-5 mb-5">
                    <p>
                        Login
                    </p>
                </div>
            </main>
            <Footer />
        </>
    );
}