

// we kinda renamed "App" to "Home"
function Home() {

  return (
    <>
    <header className="d-flex">
      <p className="logo-name p-2">
        964Ecommerce
        <span className="latest">
          (latest)
        </span>
      </p>
      <div className="srchinp">
        <input type="text" className="form-control" />
        <button className="btn-srch">
          <i className="bi bi-search"></i>
        </button>
      </div>
      <div className="authbtns">
        <button style={{borderRadius:"5px",display:"flex", alignItems:"center"}}>
          <i style={{fontSize:"1.5em", marginBottom:"5px"}} 
          class="bi bi-person-circle"></i> &nbsp;
          LOGIN/SIGNUP
        </button>
      </div>
      <div style={{display:"flex",alignItems:"center",padding:"10px"}}>
        <button style={{borderRadius:"5px",height:"100%"}}>
        <i class="bi bi-cart"></i>
            My Cart
        </button>
      </div>
    </header>
      <nav>
          <ul className="category_and_img border-right border-secondary">
              <div onClick={()=>{}} 
              className="HomeLogo">
                <i className="bi bi-house"></i> &nbsp; 
                <span>Home</span>
              </div>
              <button>groceries</button>
              <button>clothing</button>
              <button>gaming</button>
          </ul>
      </nav>
    </>
  )
}

export default Home;
