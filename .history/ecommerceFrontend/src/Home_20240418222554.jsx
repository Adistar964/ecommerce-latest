

// we kinda renamed "App" to "Home"
function Home() {

  return (
    <>
    <header>
      <div className="logo-container">
        <img src="../public/ecommerce.png"/>
        hh
      </div>
    </header>
      <nav>
          <ul className="category_and_img border-right border-secondary">
              <div onClick={()=>{}} 
              className="HomeLogo">
                <i class="bi bi-house"></i> &nbsp; 
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
