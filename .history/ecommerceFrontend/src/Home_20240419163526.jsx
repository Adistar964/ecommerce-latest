

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
          <i style={{fontSize:"1.8em", marginBottom:"4px"}} 
          class="bi bi-person-circle"></i> &nbsp;
          LOGIN
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
